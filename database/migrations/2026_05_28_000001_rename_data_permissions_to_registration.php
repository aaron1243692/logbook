<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $labels = [
            'Data' => 'Registration',
            'View Data' => 'View Registration',
            'Create Data' => 'Create Registration',
            'Update Data' => 'Update Registration',
            'Delete Data' => 'Delete Registration',
            'Print Data' => 'Print Registration',
            'Export Data' => 'Export Registration',
        ];

        foreach ($labels as $from => $to) {
            DB::table('permissions')
                ->where('name', $from)
                ->update(['name' => $to]);
        }
    }

    public function down(): void
    {
        $labels = [
            'Registration' => 'Data',
            'View Registration' => 'View Data',
            'Create Registration' => 'Create Data',
            'Update Registration' => 'Update Data',
            'Delete Registration' => 'Delete Data',
            'Print Registration' => 'Print Data',
            'Export Registration' => 'Export Data',
        ];

        foreach ($labels as $from => $to) {
            DB::table('permissions')
                ->where('name', $from)
                ->update(['name' => $to]);
        }
    }
};
