<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('egate_logs', function (Blueprint $table) {
            if (! Schema::hasColumn('egate_logs', 'login')) {
                $table->time('login')->nullable()->after('student_id');
            }

            if (! Schema::hasColumn('egate_logs', 'logout')) {
                $table->time('logout')->nullable()->after('login');
            }

            if (! Schema::hasColumn('egate_logs', 'time_consumed')) {
                $table->string('time_consumed')->nullable()->after('logout');
            }
        });

        if (Schema::hasColumn('egate_logs', 'time')) {
            $logs = DB::table('egate_logs')
                ->select([
                    'id',
                    'student_id',
                    'date',
                    'time',
                    'created_at',
                ])
                ->orderByRaw('COALESCE(date, DATE(created_at))')
                ->orderBy('student_id')
                ->orderByRaw('COALESCE(time, TIME(created_at))')
                ->orderBy('id')
                ->get()
                ->groupBy(function ($log) {
                    return $log->student_id . '|' . ($log->date ?: substr((string) $log->created_at, 0, 10));
                });

            foreach ($logs as $studentDayLogs) {
                $studentDayLogs
                    ->values()
                    ->chunk(2)
                    ->each(function ($pair) {
                        $login = $pair->first();
                        $logout = $pair->get(1);
                        $loginTime = $login->time ?: substr((string) $login->created_at, 11, 8);
                        $logoutTime = $logout ? ($logout->time ?: substr((string) $logout->created_at, 11, 8)) : null;

                        DB::table('egate_logs')
                            ->where('id', $login->id)
                            ->update([
                                'login' => $loginTime,
                                'logout' => $logoutTime,
                                'time_consumed' => $logoutTime ? $this->formatTimeConsumed($loginTime, $logoutTime) : null,
                                'date' => $login->date ?: substr((string) $login->created_at, 0, 10),
                            ]);

                        if ($logout) {
                            DB::table('egate_logs')
                                ->where('id', $logout->id)
                                ->delete();
                        }
                    });
            }

            Schema::table('egate_logs', function (Blueprint $table) {
                $table->dropColumn('time');
            });
        }
    }

    public function down(): void
    {
        Schema::table('egate_logs', function (Blueprint $table) {
            if (! Schema::hasColumn('egate_logs', 'time')) {
                $table->time('time')->nullable()->after('student_id');
            }
        });

        DB::table('egate_logs')
            ->whereNull('time')
            ->update([
                'time' => DB::raw('COALESCE(login, logout)'),
            ]);

        Schema::table('egate_logs', function (Blueprint $table) {
            if (Schema::hasColumn('egate_logs', 'time_consumed')) {
                $table->dropColumn('time_consumed');
            }

            if (Schema::hasColumn('egate_logs', 'logout')) {
                $table->dropColumn('logout');
            }

            if (Schema::hasColumn('egate_logs', 'login')) {
                $table->dropColumn('login');
            }
        });
    }

    private function formatTimeConsumed(string $loginTime, string $logoutTime): string
    {
        $login = strtotime($loginTime);
        $logout = strtotime($logoutTime);

        if ($login === false || $logout === false) {
            return '';
        }

        $minutes = (int) floor(abs($logout - $login) / 60);

        if ($minutes < 1) {
            return 'Less than 1 min';
        }

        $hours = intdiv($minutes, 60);
        $remainingMinutes = $minutes % 60;
        $parts = [];

        if ($hours > 0) {
            $parts[] = $hours . ' hr' . ($hours === 1 ? '' : 's');
        }

        if ($remainingMinutes > 0) {
            $parts[] = $remainingMinutes . ' min' . ($remainingMinutes === 1 ? '' : 's');
        }

        return implode(' ', $parts);
    }
};
