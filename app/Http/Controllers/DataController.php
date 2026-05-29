<?php

namespace App\Http\Controllers;

use App\Models\EgateLog;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Storage;
use Illuminate\Validation\Rule;
use Symfony\Component\HttpFoundation\StreamedResponse;
use Illuminate\Validation\ValidationException;

class DataController extends Controller
{
    public function index()
    {
        abort_unless(auth()->user()?->can('data.view'), 403);
        return view('admin.data', [
            'departments' => EgateLog::query()
                ->whereNotNull('department')
                ->where('department', '!=', '')
                ->distinct()
                ->orderBy('department')
                ->pluck('department')
                ->values(),
            'courses' => EgateLog::query()
                ->whereNotNull('course')
                ->where('course', '!=', '')
                ->distinct()
                ->orderBy('course')
                ->pluck('course')
                ->values(),
            'yearLevels' => EgateLog::query()
                ->whereNotNull('grade_level')
                ->where('grade_level', '!=', '')
                ->distinct()
                ->orderBy('grade_level')
                ->pluck('grade_level')
                ->values(),
        ]);
    }

    public function fetchData(Request $request): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.view'), 403);
        $records = $this->buildFilteredQuery($request)
            ->orderBy('name', $this->resolveNameSortDirection($request))
            ->paginate(10);

        return response()->json($records);
    }

    public function show(int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.view'), 403);
        $record = EgateLog::query()->find($id);

        if (! $record) {
            return response()->json([
                'success' => false,
                'message' => 'Record not found.',
            ], 404);
        }

        return response()->json([
            'success' => true,
            'record' => $record,
        ]);
    }

    public function print(Request $request)
    {
        abort_unless(auth()->user()?->can('data.print'), 403);

        $records = $this->buildFilteredQuery($request)
            ->when($request->filled('record_id'), fn ($query) => $query->whereKey($request->integer('record_id')))
            ->orderBy('name', $this->resolveNameSortDirection($request))
            ->get();

        return view('admin.print-data', [
            'records' => $records,
            'individualPrint' => $request->filled('record_id'),
            'printedAt' => now(),
        ]);
    }

    public function export(Request $request): StreamedResponse
    {
        abort_unless(auth()->user()?->can('data.export'), 403);

        $records = $this->buildFilteredQuery($request)
            ->orderBy('name', $this->resolveNameSortDirection($request))
            ->get();

        $filename = 'student-data-' . now()->format('Y-m-d_H-i-s') . '.xls';
        $html = view('admin.export-data', [
            'records' => $records,
        ])->render();

        return response()->streamDownload(function () use ($html) {
            echo $html;
        }, $filename, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.create'), 403);

        try {
            $request->merge([
                'rfid' => $this->normalizeIntegerInput($request->input('rfid')),
                'gatepass_no' => $this->normalizeStringInput($request->input('gatepass_no')),
                'email' => $this->normalizeEmailInput($request->input('email')),
            ]);

            $validated = $request->validate($this->rules(), $this->validationMessages());
            $data = $this->dataForSave($validated);

            if ($imagePath = $this->storeUploadedImage($request)) {
                $data['image'] = $imagePath;
            }

            $record = EgateLog::query()->create($data);

            return response()->json([
                'success' => true,
                'message' => 'Student data created successfully.',
                'record' => $record,
            ], 201);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => collect($e->errors())->flatten()->first() ?? 'Validation failed.',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to create student data right now.',
            ], 500);
        }
    }

    public function update(Request $request, int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.update'), 403);

        try {
            $record = EgateLog::query()->findOrFail($id);
            $request->merge([
                'rfid' => $this->normalizeIntegerInput($request->input('rfid')),
                'gatepass_no' => $this->normalizeStringInput($request->input('gatepass_no')),
                'email' => $this->normalizeEmailInput($request->input('email')),
            ]);

            $validated = $request->validate($this->rules($record->id), $this->validationMessages());
            $data = $this->dataForSave($validated);

            if ($imagePath = $this->storeUploadedImage($request)) {
                $this->deleteStoredImage($record->image);
                $data['image'] = $imagePath;
            }

            $record->update($data);

            return response()->json([
                'success' => true,
                'message' => 'Student data updated successfully.',
                'record' => $record->fresh(),
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => collect($e->errors())->flatten()->first() ?? 'Validation failed.',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to update student data right now.',
            ], 500);
        }
    }

    public function registerRfid(Request $request, int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.update'), 403);

        try {
            $record = EgateLog::query()->findOrFail($id);
            $request->merge([
                'rfid' => $this->normalizeIntegerInput($request->input('rfid')),
            ]);

            $validated = $request->validate([
                'rfid' => [
                    'required',
                    'regex:/^\d+$/',
                    Rule::unique('egate_data', 'rfid')->ignore($record->id),
                ],
            ], $this->validationMessages());

            $record->update([
                'rfid' => (int) $validated['rfid'],
            ]);

            return response()->json([
                'success' => true,
                'message' => 'RFID registered successfully.',
                'record' => $record->fresh(),
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => collect($e->errors())->flatten()->first() ?? 'RFID registration failed.',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to register RFID right now.',
            ], 500);
        }
    }

    public function registerGatePass(Request $request, int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.update'), 403);

        try {
            $record = EgateLog::query()->findOrFail($id);
            $request->merge([
                'gatepass_no' => $this->normalizeStringInput($request->input('gatepass_no')),
            ]);

            $validated = $request->validate([
                'gatepass_no' => [
                    'required',
                    'string',
                    'max:100',
                    Rule::unique('egate_data', 'gatepass_no')->ignore($record->id),
                ],
            ], $this->validationMessages());

            $record->update([
                'gatepass_no' => trim($validated['gatepass_no']),
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Gate pass registered successfully.',
                'record' => $record->fresh(),
            ]);
        } catch (ValidationException $e) {
            return response()->json([
                'success' => false,
                'message' => collect($e->errors())->flatten()->first() ?? 'Gate pass registration failed.',
                'errors' => $e->errors(),
            ], 422);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to register gate pass right now.',
            ], 500);
        }
    }

    public function destroy(int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('data.delete'), 403);

        try {
            $record = EgateLog::query()->findOrFail($id);
            $record->delete();

            return response()->json([
                'success' => true,
                'message' => 'Student data deleted successfully.',
            ]);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to delete student data right now.',
            ], 500);
        }
    }

    private function rules(?int $ignoreId = null): array
    {
        return [
            'student_number' => ['required', 'string', 'max:255', 'unique:egate_data,student_number' . ($ignoreId ? ',' . $ignoreId : '')],
            'lrn' => ['nullable', 'digits_between:1,20'],
            'rfid' => [
                'nullable',
                'regex:/^\d+$/',
                Rule::unique('egate_data', 'rfid')->ignore($ignoreId),
            ],
            'gatepass_no' => [
                'nullable',
                'string',
                'max:100',
                Rule::unique('egate_data', 'gatepass_no')->ignore($ignoreId),
            ],
            'name' => ['required', 'string', 'max:150'],
            'role' => ['nullable', 'integer', 'in:1,2'],
            'email' => [
                'nullable',
                'email',
                'max:100',
                Rule::unique('egate_data', 'email')->ignore($ignoreId),
            ],
            'contact' => ['nullable', 'string', 'max:100'],
            'sex' => ['nullable', 'string', 'max:20'],
            'department' => ['nullable', 'string', 'max:100'],
            'course' => ['nullable', 'string', 'max:100'],
            'school_level' => ['nullable', 'string', 'max:100'],
            'grade_level' => ['nullable', 'string', 'max:100'],
            'image' => ['nullable', 'image', 'mimes:jpg,jpeg,png,webp', 'max:4096'],
        ];
    }

    private function validationMessages(): array
    {
        return [
            'rfid.unique' => 'This RFID is already registered.',
            'gatepass_no.unique' => 'This gate pass number is already registered.',
            'email.unique' => 'This email is already registered.',
        ];
    }

    private function normalizeIntegerInput(mixed $value): ?string
    {
        $digits = preg_replace('/\D+/', '', (string) $value);

        return $digits === '' ? null : $digits;
    }

    private function normalizeStringInput(mixed $value): ?string
    {
        $text = trim((string) $value);

        return $text === '' ? null : $text;
    }

    private function normalizeEmailInput(mixed $value): ?string
    {
        $email = strtolower(trim((string) $value));

        return $email === '' ? null : $email;
    }

    private function dataForSave(array $validated): array
    {
        return [
            'student_number' => $validated['student_number'],
            'lrn' => $validated['lrn'] ?? null,
            'rfid' => isset($validated['rfid']) && $validated['rfid'] !== '' ? (int) $validated['rfid'] : null,
            'gatepass_no' => trim((string) ($validated['gatepass_no'] ?? '')) ?: null,
            'name' => $this->normalizeName($validated['name']),
            'role' => $validated['role'] ?? null,
            'email' => $validated['email'] ?? null,
            'contact' => $validated['contact'] ?? null,
            'sex' => $validated['sex'] ?? null,
            'department' => $validated['department'] ?? null,
            'course' => $validated['course'] ?? null,
            'school_level' => $validated['school_level'] ?? null,
            'grade_level' => $validated['grade_level'] ?? null,
        ];
    }

    private function storeUploadedImage(Request $request): ?string
    {
        if (! $request->hasFile('image')) {
            return null;
        }

        $path = $request->file('image')->store('registration-images', 'public');

        return $path ? '/storage/' . ltrim($path, '/') : null;
    }

    private function deleteStoredImage(?string $image): void
    {
        if (! $image || ! str_starts_with($image, '/storage/')) {
            return;
        }

        $path = ltrim(substr($image, strlen('/storage/')), '/');

        if ($path !== '') {
            Storage::disk('public')->delete($path);
        }
    }

    private function resolveNameSortDirection(Request $request): string
    {
        return $request->get('name_sort') === 'desc' ? 'desc' : 'asc';
    }

    private function normalizeName(string $name): string
    {
        $name = trim(preg_replace('/\s+/', ' ', $name) ?? $name);
        $parts = array_values(array_filter(array_map('trim', explode(',', $name))));

        if (count($parts) === 3) {
            return "{$parts[0]} {$parts[1]}, {$parts[2]}";
        }

        return $name;
    }

    private function buildFilteredQuery(Request $request): Builder
    {
        $search = trim((string) $request->get('search', ''));
        $department = trim((string) $request->get('department', ''));
        $course = trim((string) $request->get('course', ''));
        $yearLevel = trim((string) $request->get('year_level', ''));

        return EgateLog::query()
            ->when($search !== '', function ($query) use ($search) {
                $query->where(function ($innerQuery) use ($search) {
                    $innerQuery
                        ->where('student_number', 'like', "%{$search}%")
                        ->orWhere('lrn', 'like', "%{$search}%")
                        ->orWhere('rfid', 'like', "%{$search}%")
                        ->orWhere('gatepass_no', 'like', "%{$search}%")
                        ->orWhere('name', 'like', "%{$search}%")
                        ->orWhere('role', 'like', "%{$search}%")
                        ->orWhere('email', 'like', "%{$search}%")
                        ->orWhere('contact', 'like', "%{$search}%")
                        ->orWhere('department', 'like', "%{$search}%")
                        ->orWhere('course', 'like', "%{$search}%")
                        ->orWhere('school_level', 'like', "%{$search}%")
                        ->orWhere('grade_level', 'like', "%{$search}%");
                });
            })
            ->when($department !== '', fn ($query) => $query->where('department', $department))
            ->when($course !== '', fn ($query) => $query->where('course', $course))
            ->when($yearLevel !== '', fn ($query) => $query->where('grade_level', $yearLevel));
    }
}
