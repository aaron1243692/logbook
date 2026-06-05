<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\View\View;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;

class EgateDashboardController extends Controller
{
    public function __invoke(Request $request): View
    {
        $this->logoutCurrentAdmin($request);

        return view('pages.welcome', [
            'manualEntryEnabled' => SettingController::isEnabled(1),
            'rfidLoginEnabled' => SettingController::isEnabled(2),
        ]);
    }

    public function showLogin(): View
    {
        return view('signin');
    }

    public function adminDashboard(): View
    {
        return view('pages.welcome');
    }

    public function forceSignin(Request $request): RedirectResponse
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return redirect()->route('signin');
    }

    public function getStudents(Request $request): JsonResponse
    {
        return response()->json($this->buildStudentPayload('other'));
    }

    private function logoutCurrentAdmin(Request $request): void
    {
        if (! Auth::check()) {
            return;
        }

        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
    }

    public function buildStudentPayload(string $statusGroup)
    {
        return DB::table('egate_logs')
            ->leftJoin('egate_data', function ($join) {
                $join
                    ->on('egate_data.id', '=', 'egate_logs.egate_data_id')
                    ->orOn('egate_data.student_number', '=', 'egate_logs.student_id');
            })
            ->orderByDesc(DB::raw("COALESCE(CONCAT(egate_logs.date, ' ', egate_logs.time), egate_logs.created_at)"))
            ->select([
                'egate_logs.id as log_id',
                'egate_logs.student_id',
                DB::raw("COALESCE(CONCAT(egate_logs.date, ' ', egate_logs.time), egate_logs.created_at) as logged_at"),
                'egate_data.id',
                'egate_data.student_number',
                'egate_data.lrn',
                'egate_data.gatepass_no',
                'egate_data.name',
                'egate_data.department',
                'egate_data.course',
                'egate_data.school_level',
                'egate_data.grade_level',
                'egate_data.image',
            ])
            ->take(100)
            ->get()
            ->map(function ($student) {
                $name = trim((string) $student->name);

                return [
                    'id' => $student->id,
                    'log_id' => $student->log_id,
                    'student_id' => $student->student_id,
                    'student_number' => $student->student_number,
                    'lrn' => $student->lrn,
                    'gatepass_no' => $student->gatepass_no,
                    'student_name' => $name !== '' ? $name : $student->student_id,
                    'department' => $student->department,
                    'course' => $student->course,
                    'year_level' => $student->school_level ?: $student->grade_level,
                    'grade_level' => $student->grade_level,
                    'image' => self::resolveStudentImageUrl($student->image),
                    'logged_at' => $student->logged_at,
                ];
            })
            ->take(3)
            ->values();
    }

    public static function resolveStudentImageUrl(?string $image): ?string
    {
        $image = trim((string) $image);

        if ($image === '') {
            return null;
        }

        if (preg_match('/^(?:https?:)?\/\//i', $image) || str_starts_with($image, 'data:image/')) {
            return $image;
        }

        $normalized = ltrim(str_replace('\\', '/', $image), '/');

        if (str_starts_with($normalized, 'storage/')) {
            return '/' . $normalized;
        }

        if (str_starts_with($normalized, 'registration-images/')) {
            return '/storage/' . $normalized;
        }

        if (str_contains($normalized, '/')) {
            return '/' . $normalized;
        }

        if (file_exists(public_path('db_img/' . $normalized))) {
            return '/db_img/' . $normalized;
        }

        if (file_exists(public_path('images/' . $normalized))) {
            return '/images/' . $normalized;
        }

        if (Storage::disk('public')->exists($normalized)) {
            return '/storage/' . $normalized;
        }

        return '/db_img/' . $normalized;
    }

    public function submitLogin(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'login' => ['required', 'string', 'max:255'],
            'password' => ['required', 'string'],
        ]);

        $login = trim((string) $validated['login']);
        $password = (string) $validated['password'];
        $field = filter_var($login, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

        if (! Auth::attempt([$field => $login, 'password' => $password], $request->boolean('remember'))) {
            return back()
                ->withInput($request->except('password'))
                ->with('login_error', 'Incorrect credentials');
        }

        $request->session()->regenerate();

        if (! Auth::user()?->hasAdminRole()) {
            Auth::logout();
            $request->session()->invalidate();
            $request->session()->regenerateToken();

            return back()
                ->withInput($request->except('password'))
                ->with('login_error', 'Incorrect credentials');
        }

        return redirect()->route('admin.dashboard');
    }


}
