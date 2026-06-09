<?php

namespace Database\Seeders;

use App\Models\Permission;
use Spatie\Permission\Models\Role;
use Illuminate\Database\Seeder;
use Spatie\Permission\PermissionRegistrar;

class PermissionRoleSeeder extends Seeder
{
    public function run(): void
    {
        $admin = Role::findOrCreate('admin', 'web');
        $staff = Role::findOrCreate('Staff', 'web');
        $guard = Role::findOrCreate('Guard', 'web');

        $parents = collect([
            'data' => 'Registration',
            'logs' => 'Logs',
            'emlog' => 'Employee Logs',
            'roles' => 'Roles',
            'setschedcehed' => 'Setup Sched Schedule',
            'setschedem' => 'Setup Sched Employee',
            'login_logout' => 'Login/Logout',
            'users' => 'Users',
        ])->mapWithKeys(function (string $name, string $code) {
            $permission = Permission::query()->updateOrCreate(
                ['code' => $code, 'guard_name' => 'web'],
                ['name' => $name, 'parent_id' => null]
            );

            return [$code => $permission];
        });

        $legacyTimeLogin = Permission::query()
            ->where('code', 'time.login')
            ->where('guard_name', 'web')
            ->first();

        $logout = Permission::query()
            ->where('code', 'logout')
            ->where('guard_name', 'web')
            ->first();

        if ($legacyTimeLogin && ! $logout) {
            $legacyTimeLogin->update([
                'name' => 'Logout',
                'code' => 'logout',
                'parent_id' => $parents['login_logout']->id,
            ]);
        } elseif ($legacyTimeLogin && $logout) {
            $logout->roles()->syncWithoutDetaching($legacyTimeLogin->roles()->pluck('id')->all());
            $legacyTimeLogin->delete();
        }

        $definitions = [
            ['name' => 'View Registration', 'code' => 'data.view', 'parent_id' => $parents['data']->id],
            ['name' => 'Create Registration', 'code' => 'data.create', 'parent_id' => $parents['data']->id],
            ['name' => 'Update Registration', 'code' => 'data.update', 'parent_id' => $parents['data']->id],
            ['name' => 'Delete Registration', 'code' => 'data.delete', 'parent_id' => $parents['data']->id],
            ['name' => 'Print Registration', 'code' => 'data.print', 'parent_id' => $parents['data']->id],
            ['name' => 'Export Registration', 'code' => 'data.export', 'parent_id' => $parents['data']->id],
            ['name' => 'View Logs', 'code' => 'logs.view', 'parent_id' => $parents['logs']->id],
            ['name' => 'Update Logs', 'code' => 'logs.update', 'parent_id' => $parents['logs']->id],
            ['name' => 'Delete Logs', 'code' => 'logs.delete', 'parent_id' => $parents['logs']->id],
            ['name' => 'Print Logs', 'code' => 'logs.print', 'parent_id' => $parents['logs']->id],
            ['name' => 'Export Logs', 'code' => 'export.logs', 'parent_id' => $parents['logs']->id],
            ['name' => 'View Employee Logs', 'code' => 'emlog.view', 'parent_id' => $parents['emlog']->id],
            ['name' => 'Print Employee Logs', 'code' => 'emlog.print', 'parent_id' => $parents['emlog']->id],
            ['name' => 'Export Employee Logs', 'code' => 'emlog.export', 'parent_id' => $parents['emlog']->id],
            ['name' => 'Delete Employee Logs', 'code' => 'emlog.delete', 'parent_id' => $parents['emlog']->id],
            ['name' => 'View Roles', 'code' => 'roles.view', 'parent_id' => $parents['roles']->id],
            ['name' => 'Create Roles', 'code' => 'roles.create', 'parent_id' => $parents['roles']->id],
            ['name' => 'Update Roles', 'code' => 'roles.update', 'parent_id' => $parents['roles']->id],
            ['name' => 'Delete Roles', 'code' => 'roles.delete', 'parent_id' => $parents['roles']->id],
            ['name' => 'View', 'code' => 'setschedcehed.view', 'parent_id' => $parents['setschedcehed']->id],
            ['name' => 'Create', 'code' => 'setschedcehed.create', 'parent_id' => $parents['setschedcehed']->id],
            ['name' => 'Update', 'code' => 'setschedcehed.update', 'parent_id' => $parents['setschedcehed']->id],
            ['name' => 'Delete', 'code' => 'setschedcehed.delete', 'parent_id' => $parents['setschedcehed']->id],
            ['name' => 'View', 'code' => 'setschedem.view', 'parent_id' => $parents['setschedem']->id],
            ['name' => 'Update', 'code' => 'setschedem.update', 'parent_id' => $parents['setschedem']->id],
            ['name' => 'Login', 'code' => 'login', 'parent_id' => $parents['login_logout']->id],
            ['name' => 'Logout', 'code' => 'logout', 'parent_id' => $parents['login_logout']->id],
            ['name' => 'None', 'code' => 'login_logout.none', 'parent_id' => $parents['login_logout']->id],
            ['name' => 'View Users', 'code' => 'users.view', 'parent_id' => $parents['users']->id],
            ['name' => 'Create Users', 'code' => 'users.create', 'parent_id' => $parents['users']->id],
            ['name' => 'Update Users', 'code' => 'users.update', 'parent_id' => $parents['users']->id],
            ['name' => 'Update User Passwords', 'code' => 'users.update.pass', 'parent_id' => $parents['users']->id],
            ['name' => 'Delete Users', 'code' => 'users.delete', 'parent_id' => $parents['users']->id],
        ];

        foreach ($definitions as $definition) {
            Permission::query()->updateOrCreate(
                ['code' => $definition['code'], 'guard_name' => 'web'],
                ['name' => $definition['name'], 'parent_id' => $definition['parent_id']]
            );
        }

        $allPermissions = Permission::query()
            ->where('guard_name', 'web')
            ->pluck('id')
            ->all();

        $staffPermissions = Permission::query()
            ->whereIn('code', [
                'data',
                'data.create',
                'data.export',
                'data.print',
                'data.update',
                'data.view',
                'logs',
                'emlog',
                'emlog.export',
                'emlog.print',
                'emlog.view',
                'export.logs',
                'logs.print',
                'logs.update',
                'logs.view',
                'login_logout',
                'login',
                'login_logout.none',
                'logout',
                'users',
                'users.view',
                'users.create',
                'users.update',
            ])
            ->where('guard_name', 'web')
            ->get();

        $guardPermissions = Permission::query()
            ->whereIn('code', [
                'data',
                'data.export',
                'data.print',
                'data.view',
                'logs',
                'emlog',
                'emlog.export',
                'emlog.print',
                'emlog.view',
                'export.logs',
                'logs.view',
                'logs.print',
                'login_logout',
                'login',
                'login_logout.none',
                'logout',
            ])
            ->where('guard_name', 'web')
            ->get();

        $admin->syncPermissions($allPermissions);
        $staff->syncPermissions($staffPermissions);
        $guard->syncPermissions($guardPermissions);

        app(PermissionRegistrar::class)->forgetCachedPermissions();
    }
}
