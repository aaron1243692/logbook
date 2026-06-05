<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (! Schema::hasColumn('egate_logs', 'status')) {
            Schema::table('egate_logs', function (Blueprint $table) {
                $table->integer('status')->default(2)->after('student_id')->index();
            });
        }
    }

    public function down(): void
    {
        if (Schema::hasColumn('egate_logs', 'status')) {
            Schema::table('egate_logs', function (Blueprint $table) {
                $table->dropIndex(['status']);
                $table->dropColumn('status');
            });
        }
    }
};
