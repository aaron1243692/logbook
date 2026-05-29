<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasColumn('egate_data', 'gatepass_no')) {
            return;
        }

        Schema::table('egate_data', function (Blueprint $table) {
            $table->string('gatepass_no', 100)->nullable()->after('rfid')->index();
        });
    }

    public function down(): void
    {
        if (! Schema::hasColumn('egate_data', 'gatepass_no')) {
            return;
        }

        Schema::table('egate_data', function (Blueprint $table) {
            $table->dropColumn('gatepass_no');
        });
    }
};
