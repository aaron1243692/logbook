<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\LogsSystemActions;
use Illuminate\Http\JsonResponse;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\EgateEntryLog;
use Carbon\Carbon;
use Illuminate\Database\Query\Builder;
use Symfony\Component\HttpFoundation\StreamedResponse;

class LogController extends Controller
{
    use LogsSystemActions;

    public function index()
    {
        abort_unless(auth()->user()?->can('logs.view'), 403);

        $departments = DB::table('egate_data')
            ->where('role', 1)
            ->whereNotNull('department')
            ->where('department', '!=', '')
            ->distinct()
            ->orderBy('department')
            ->pluck('department');

        $courses = DB::table('egate_data')
            ->where('role', 1)
            ->whereNotNull('course')
            ->where('course', '!=', '')
            ->distinct()
            ->orderBy('course')
            ->pluck('course');

        $gradeLevels = DB::table('egate_data')
            ->where('role', 1)
            ->whereNotNull('grade_level')
            ->where('grade_level', '!=', '')
            ->distinct()
            ->orderBy('grade_level')
            ->pluck('grade_level');

        return view('admin.logs', compact('departments', 'courses', 'gradeLevels'));
    }

    public function fetchLogs(Request $request): JsonResponse
    {
        abort_unless(auth()->user()?->can('logs.view'), 403);
        $pairedLogs = $this->buildPairedScanLogs($request);
        $page = max(1, (int) $request->get('page', 1));
        $perPage = 10;

        $logs = new LengthAwarePaginator(
            $pairedLogs->forPage($page, $perPage)->values(),
            $pairedLogs->count(),
            $perPage,
            $page,
            [
                'path' => $request->url(),
                'query' => $request->query(),
            ],
        );

        return response()->json($logs);
    }

    public function print(Request $request)
    {
        abort_unless(auth()->user()?->can('logs.print'), 403);

        $logs = $this->buildPairedScanLogs($request);

        if ($request->filled('student_id')) {
            $logs = $logs
                ->where('student_id', $request->get('student_id'))
                ->values();
        }

        $reports = $logs
            ->groupBy('student_id')
            ->map(function ($studentLogs) {
                $firstLog = $studentLogs->first();

                return [
                    'student' => [
                        'name' => $firstLog['name'] ?? 'N/A',
                        'student_id' => $firstLog['student_id'] ?? 'N/A',
                        'lrn' => $firstLog['lrn'] ?? null,
                        'contact' => $firstLog['contact'] ?? null,
                        'email' => $firstLog['email'] ?? null,
                    ],
                    'logs' => $studentLogs->values(),
                    'summary' => [
                        'total' => $studentLogs->count(),
                    ],
                ];
            })
            ->values();

        if ($request->filled('student_id')) {
            $studentId = (string) $request->get('student_id');
            $egateDataId = DB::table('egate_data')
                ->where('id', $studentId)
                ->orWhere('student_number', $studentId)
                ->value('id');

            $this->logSystemAction('printed egate_data ' . ($egateDataId ?: $studentId));
        } else {
            $this->logSystemAction('printed student logs');
        }

        return view('admin.print-logs', [
            'logs' => $logs,
            'reports' => $reports,
            'isIndividual' => $request->filled('student_id'),
            'periodLabel' => $this->formatPrintPeriod($request),
            'printedAt' => now(),
            'summary' => [
                'total' => $logs->count(),
            ],
        ]);
    }

    public function export(Request $request): StreamedResponse
    {
        abort_unless(auth()->user()?->can('export.logs'), 403);

        $logs = $this->buildPairedScanLogs($request);

        $filename = 'logs-' . now()->format('Y-m-d_H-i-s') . '.xls';
        $html = view('admin.export-logs', [
            'logs' => $logs,
        ])->render();

        $this->logSystemAction('exported student logs');

        return response()->streamDownload(function () use ($html) {
            echo $html;
        }, $filename, [
            'Content-Type' => 'application/vnd.ms-excel; charset=UTF-8',
        ]);
    }

    public function destroy(int $id): JsonResponse
    {
        abort_unless(auth()->user()?->can('logs.delete'), 403);

        try {
            $log = EgateEntryLog::query()->findOrFail($id);
            $label = $log->id;
            $log->delete();
            $this->logSystemAction('deleted egate_logs ' . $label);

            return response()->json([
                'success' => true,
                'message' => 'Log deleted successfully.',
            ]);
        } catch (\Throwable $e) {
            report($e);

            return response()->json([
                'success' => false,
                'message' => 'Unable to delete log right now.',
            ], 500);
        }
    }

    private function formatLogDate(mixed $value): string
    {
        if (blank($value)) {
            return 'N/A';
        }

        try {
            return Carbon::parse($value)->format('M j, Y');
        } catch (\Throwable) {
            return (string) $value;
        }
    }

    private function formatLogTimeOnly(mixed $value): string
    {
        if (blank($value)) {
            return 'N/A';
        }

        try {
            return Carbon::parse($value)->format('g:i A');
        } catch (\Throwable) {
            return (string) $value;
        }
    }

    private function formatTimeConsumed(mixed $date, mixed $loginTime, mixed $logoutTime): string
    {
        if (blank($date) || blank($loginTime) || blank($logoutTime)) {
            return '';
        }

        try {
            $login = Carbon::parse($date . ' ' . $loginTime);
            $logout = Carbon::parse($date . ' ' . $logoutTime);
            $minutes = (int) floor(abs($login->diffInMinutes($logout)));

            if ($minutes < 1) {
                return 'Less than 1 min';
            }

            $hours = intdiv($minutes, 60);
            $remainingMinutes = $minutes % 60;

            return collect([
                $hours > 0 ? $hours . ' hr' . ($hours === 1 ? '' : 's') : null,
                $remainingMinutes > 0 ? $remainingMinutes . ' min' . ($remainingMinutes === 1 ? '' : 's') : null,
            ])->filter()->implode(' ');
        } catch (\Throwable) {
            return '';
        }
    }

    private function formatPrintPeriod(Request $request): string
    {
        $dateFrom = trim((string) $request->get('date_from', ''));
        $dateTo = trim((string) $request->get('date_to', ''));

        if ($dateFrom === '' && $dateTo === '') {
            return 'All available records';
        }

        $from = $dateFrom !== '' ? $this->formatPrintDateTime($dateFrom) : 'Beginning';
        $to = $dateTo !== '' ? $this->formatPrintDateTime($dateTo) : 'Present';

        return "{$from} - {$to}";
    }

    private function formatPrintDateTime(string $value): string
    {
        try {
            return Carbon::parse($value)->format('M j, Y g:i A');
        } catch (\Throwable) {
            return str_replace('T', ' ', $value);
        }
    }

    private function resolveTimeSortDirection(Request $request): string
    {
        return $request->get('time_sort') === 'asc' ? 'asc' : 'desc';
    }

    private function buildScanLogsQuery(Request $request): Builder
    {
        $direction = $this->resolveTimeSortDirection($request);

        return $this->buildFilteredQuery($request)
            ->select([
                'egate_logs.id',
                'egate_logs.student_id',
                DB::raw('COALESCE(egate_logs.date, DATE(egate_logs.created_at)) as scan_date'),
                DB::raw('COALESCE(egate_logs.time, TIME(egate_logs.created_at)) as scan_time'),
                'egate_data.name',
                'egate_data.lrn',
                'egate_data.contact',
                'egate_data.email',
            ])
            ->orderBy('scan_date', $direction)
            ->orderBy('scan_time', $direction)
            ->orderBy('egate_logs.id', $direction);
    }

    private function mapScanLog(object $log): array
    {
        $name = trim((string) $log->name);

        return [
            'id' => $log->id,
            'student_id' => $log->student_id,
            'lrn' => $log->lrn,
            'name' => $name !== '' ? $name : $log->student_id,
            'contact' => $log->contact,
            'email' => $log->email,
            'time' => $this->formatLogTimeOnly($log->scan_time),
            'date' => $this->formatLogDate($log->scan_date),
        ];
    }

    private function buildPairedScanLogs(Request $request)
    {
        $direction = $this->resolveTimeSortDirection($request);

        $pairedLogs = $this->buildScanLogsQuery($request)
            ->reorder()
            ->orderByRaw('COALESCE(egate_logs.date, DATE(egate_logs.created_at))')
            ->orderBy('egate_logs.student_id')
            ->orderByRaw('COALESCE(egate_logs.time, TIME(egate_logs.created_at))')
            ->orderBy('egate_logs.id')
            ->get()
            ->unique('id')
            ->values()
            ->groupBy(function ($log) {
                return $log->student_id . '|' . $log->scan_date;
            })
            ->flatMap(function ($studentDayLogs) {
                return $studentDayLogs
                    ->sortBy([
                        ['scan_date', 'asc'],
                        ['scan_time', 'asc'],
                        ['id', 'asc'],
                    ])
                    ->values()
                    ->chunk(2)
                    ->values()
                    ->map(function ($pair, $index) {
                        $pair = $pair->values();
                        $login = $pair->first();
                        $logout = $pair->get(1);
                        $name = trim((string) $login->name);

                        return [
                            'id' => $login->id,
                            'session' => $index + 1,
                            'student_id' => $login->student_id,
                            'lrn' => $login->lrn,
                            'name' => $name !== '' ? $name : $login->student_id,
                            'contact' => $login->contact,
                            'email' => $login->email,
                            'login' => $this->formatLogTimeOnly($login->scan_time),
                            'logout' => $logout ? $this->formatLogTimeOnly($logout->scan_time) : '',
                            'time_consumed' => $logout ? $this->formatTimeConsumed($login->scan_date, $login->scan_time, $logout->scan_time) : '',
                            'date' => $this->formatLogDate($login->scan_date),
                            'sort_date' => $login->scan_date,
                            'sort_time' => $login->scan_time,
                            'sort_id' => $login->id,
                        ];
                    });
            })
            ->values();

        $pairedLogs = $direction === 'asc'
            ? $pairedLogs->sortBy([
                ['sort_date', 'asc'],
                ['sort_time', 'asc'],
                ['sort_id', 'asc'],
            ])
            : $pairedLogs->sortByDesc(function (array $log) {
                return $log['sort_date'] . ' ' . $log['sort_time'] . ' ' . str_pad((string) $log['sort_id'], 20, '0', STR_PAD_LEFT);
            });

        return $pairedLogs
            ->map(function (array $log) {
                unset($log['sort_date'], $log['sort_time'], $log['sort_id']);

                return $log;
            })
            ->values();
    }

    private function buildFilteredQuery(Request $request): Builder
    {
        $search = trim((string) $request->get('search', ''));
        $department = trim((string) $request->get('department', ''));
        $course = trim((string) $request->get('course', ''));
        $gradeLevel = trim((string) $request->get('grade_level', ''));
        $dateFrom = trim((string) $request->get('date_from', ''));
        $dateTo = trim((string) $request->get('date_to', ''));

        return DB::table('egate_logs')
            ->leftJoin('egate_data', function ($join) {
                $join
                    ->on('egate_data.id', '=', 'egate_logs.egate_data_id')
                    ->orOn('egate_data.student_number', '=', 'egate_logs.student_id');
            })
            ->where('egate_data.role', 1)
            ->when($search !== '', function ($query) use ($search) {
                $query->where(function ($innerQuery) use ($search) {
                    $innerQuery
                        ->where('egate_logs.student_id', 'like', "%{$search}%")
                        ->orWhere('egate_data.id', 'like', "%{$search}%")
                        ->orWhere('egate_data.student_number', 'like', "%{$search}%")
                        ->orWhere('egate_data.lrn', 'like', "%{$search}%")
                        ->orWhere('egate_data.name', 'like', "%{$search}%");
                });
            })
            ->when($department !== '', function ($query) use ($department) {
                $query->where('egate_data.department', $department);
            })
            ->when($course !== '', function ($query) use ($course) {
                $query->where('egate_data.course', $course);
            })
            ->when($gradeLevel !== '', function ($query) use ($gradeLevel) {
                $query->where('egate_data.grade_level', $gradeLevel);
            })
            ->when($dateFrom !== '', function ($query) use ($dateFrom) {
                $query->where('egate_logs.created_at', '>=', $this->normalizeDateTimeFilter($dateFrom, false));
            })
            ->when($dateTo !== '', function ($query) use ($dateTo) {
                $query->where('egate_logs.created_at', '<=', $this->normalizeDateTimeFilter($dateTo, true));
            });
    }

    private function normalizeDateTimeFilter(string $value, bool $endOfDay): string
    {
        try {
            $date = Carbon::parse($value);

            if (! str_contains($value, 'T') && ! str_contains($value, ':')) {
                $date = $endOfDay ? $date->endOfDay() : $date->startOfDay();
            }

            return $date->format('Y-m-d H:i:s');
        } catch (\Throwable) {
            return str_replace('T', ' ', $value);
        }
    }
}
