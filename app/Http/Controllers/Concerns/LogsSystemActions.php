<?php

namespace App\Http\Controllers\Concerns;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

trait LogsSystemActions
{
    protected function logSystemAction(string $action): void
    {
        try {
            if (! Schema::hasTable('syslog')) {
                return;
            }

            $columns = Schema::getColumnListing('syslog');

            $payload = [
                'action' => $action,
            ];

            if (in_array('user_id', $columns, true)) {
                $payload['user_id'] = auth()->id() ?: 0;
            } elseif (in_array('user', $columns, true)) {
                $payload['user'] = $this->systemLogUser();
            } elseif (in_array('username', $columns, true)) {
                $payload['username'] = $this->systemLogUser();
            }

            if (in_array('created_at', $columns, true)) {
                $payload['created_at'] = now();
            }

            if (in_array('updated_at', $columns, true)) {
                $payload['updated_at'] = now();
            }

            DB::table('syslog')->insert($payload);
        } catch (\Throwable $e) {
            report($e);
        }
    }

    protected function describeChanges(array $original, array $current, array $fields): string
    {
        return collect($fields)
            ->filter(fn (string $field) => array_key_exists($field, $current))
            ->map(function (string $field) use ($original, $current) {
                $before = $this->describeLogValue($original[$field] ?? null);
                $after = $this->describeLogValue($current[$field] ?? null);

                return $before === $after ? null : "{$field} {$before} to {$after}";
            })
            ->filter()
            ->implode(', ');
    }

    protected function describeLogValue(mixed $value): string
    {
        if ($value === null || $value === '') {
            return 'blank';
        }

        return (string) $value;
    }

    private function systemLogUser(): string
    {
        $user = auth()->user();

        if (! $user) {
            return 'guest';
        }

        return (string) ($user->username ?? $user->id);
    }
}
