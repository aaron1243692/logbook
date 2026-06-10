<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        if (Schema::hasTable('syslog')) {
            return;
        }

        Schema::create('syslog', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->default(0);
            $table->text('action');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        // The table may have been created manually before this migration existed.
        // Leave it intact on rollback to avoid deleting audit history.
    }
};
