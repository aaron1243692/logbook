<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Concerns\LogsSystemActions;
use App\Models\EgateLog as EgateData;
use Carbon\CarbonImmutable;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GateEntryController extends Controller
{
    use LogsSystemActions;

    public function store(Request $request): JsonResponse
    {
        $manualEntryEnabled = SettingController::isEnabled(1);
        $rfidLoginEnabled = SettingController::isEnabled(2);

        if (! $manualEntryEnabled && ! $rfidLoginEnabled) {
            return response()->json([
                'message' => 'Manual login and RFID login are currently disabled.',
            ], 403);
        }

        $validated = $request->validate([
            'student_id' => ['nullable', 'string', 'max:255'],
            'rfid' => ['nullable', 'string', 'max:255'],
        ]);

        $manualInput = trim((string) ($validated['student_id'] ?? ''));
        $rfidInput = trim((string) ($validated['rfid'] ?? ''));

        if ($manualInput !== '' && ! $manualEntryEnabled) {
            return response()->json([
                'message' => 'Manual login is currently disabled.',
            ], 403);
        }

        if ($rfidInput !== '' && ! $rfidLoginEnabled) {
            return response()->json([
                'message' => 'RFID login is currently disabled.',
            ], 403);
        }

        $lookup = trim((string) ($validated['rfid'] ?: $validated['student_id'] ?: ''));

        if ($lookup === '') {
            return response()->json([
                'message' => 'Scan an RFID / gate pass or enter a student number / LRN first.',
            ], 422);
        }

        $student = EgateData::query()
            ->when($rfidInput !== '', function ($query) use ($lookup) {
                $query
                    ->where('rfid', $lookup)
                    ->orWhere('gatepass_no', $lookup);
            })
            ->when($rfidInput === '', function ($query) use ($lookup) {
                $query
                    ->where('student_number', $lookup)
                    ->orWhere('lrn', $lookup);
            })
            ->first();

        if (! $student) {
            return response()->json([
                'message' => 'No matching RFID, gate pass, student number, or LRN was found in egate_data.',
            ], 404);
        }

        $now = CarbonImmutable::now(config('app.timezone'));
        $loggedAt = $now->format('Y-m-d H:i:s');
        $loggedTime = $now->format('H:i:s');
        $logDate = $now->format('Y-m-d');

        $logId = DB::transaction(function () use ($student, $loggedAt, $loggedTime, $logDate) {
            $entryLogId = DB::table('egate_logs')->insertGetId([
                'egate_data_id' => $student->id,
                'student_id' => $student->student_number,
                'time' => $loggedTime,
                'date' => $logDate,
                'created_at' => $loggedAt,
                'updated_at' => $loggedAt,
            ]);

            return $entryLogId;
        });
        $this->logSystemAction('recorded gate entry egate_data ' . $student->id);

        return response()->json([
            'message' => 'Entry submitted successfully.',
            'log_id' => $logId,
            'egate_data_id' => $student->id,
            'student_id' => $student->student_number,
            'student_number' => $student->student_number,
            'lrn' => $student->lrn,
            'gatepass_no' => $student->gatepass_no,
            'student_name' => $student->name ?: $student->student_number,
            'department' => $student->department,
            'course' => $student->course,
            'year_level' => $student->school_level ?: $student->grade_level,
            'grade_level' => $student->grade_level,
            'image' => EgateDashboardController::resolveStudentImageUrl($student->image),
            'time' => $loggedTime,
            'date' => $logDate,
            'logged_at' => $loggedAt,
        ]);
    }
}
