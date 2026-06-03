<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\PermissionRegistrar;

return new class extends Migration
{
    public function up(): void
    {
        DB::table('permissions')
            ->where('code', 'time')
            ->where('guard_name', 'web')
            ->update([
                'name' => 'Login/Logout',
                'code' => 'login_logout',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->where('code', 'time.in')
            ->where('guard_name', 'web')
            ->update([
                'name' => 'Login',
                'code' => 'login',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->whereIn('code', ['time.out', 'time.login'])
            ->where('guard_name', 'web')
            ->update([
                'name' => 'Logout',
                'code' => 'logout',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->where('code', 'time.none')
            ->where('guard_name', 'web')
            ->update([
                'code' => 'login_logout.none',
                'updated_at' => now(),
            ]);

        app(PermissionRegistrar::class)->forgetCachedPermissions();
    }

    public function down(): void
    {
        DB::table('permissions')
            ->where('code', 'login_logout')
            ->where('guard_name', 'web')
            ->update([
                'name' => 'Time Log',
                'code' => 'time',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->where('code', 'login')
            ->where('guard_name', 'web')
            ->update([
                'name' => 'In',
                'code' => 'time.in',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->where('code', 'logout')
            ->where('guard_name', 'web')
            ->update([
                'name' => 'Out',
                'code' => 'time.out',
                'updated_at' => now(),
            ]);

        DB::table('permissions')
            ->where('code', 'login_logout.none')
            ->where('guard_name', 'web')
            ->update([
                'code' => 'time.none',
                'updated_at' => now(),
            ]);

        app(PermissionRegistrar::class)->forgetCachedPermissions();
    }
};
