<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Student Data Print</title>
    <style>
        @page {
            margin: 12mm;
            @bottom-center {
                content: "Page " counter(page) " of " counter(pages);
                font-family: Arial, sans-serif;
                font-size: 11px;
                color: #111827;
            }
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            color: #111827;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 11px;
            line-height: 1.35;
            background: #fff;
        }

        .sheet {
            width: 100%;
            break-after: page;
            page-break-after: always;
        }

        @media screen {
            .sheet {
                margin-bottom: 28px;
            }
        }

        .sheet:last-child {
            break-after: auto;
            page-break-after: auto;
        }

        .report-header {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            gap: 12px;
            align-items: center;
            padding: 0 0 8px;
            border-bottom: 2px solid #111827;
        }

        .report-brand {
            display: flex;
            grid-column: 2;
            justify-self: center;
            gap: 12px;
            align-items: center;
        }

        .report-logo {
            width: 64px;
            height: 64px;
            object-fit: contain;
        }

        .agency {
            text-align: center;
        }

        .agency-name {
            margin: 0;
            font-family: "Times New Roman", serif;
            font-size: 14px;
            font-weight: 700;
            letter-spacing: 0.02em;
            text-transform: uppercase;
        }

        .agency-subtitle,
        .agency-system {
            margin: 2px 0 0;
            font-size: 10px;
            color: #374151;
        }

        .document-code {
            display: grid;
            grid-column: 3;
            justify-self: end;
            gap: 2px;
            font-size: 9px;
        }

        .document-code div {
            display: flex;
            justify-content: space-between;
            gap: 10px;
            white-space: nowrap;
        }

        .report-title {
            margin: 8px 0 8px;
            text-align: center;
        }

        .report-title h2 {
            margin: 0;
            font-size: 13px;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .report-title p {
            margin: 3px 0 0;
            color: #374151;
            font-size: 11px;
            font-weight: 700;
        }

        .meta-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 0;
            margin-bottom: 8px;
            border: 1px solid #111827;
            border-right: 0;
            border-bottom: 0;
        }

        .meta-item {
            min-height: 30px;
            padding: 3px 6px;
            border-right: 1px solid #111827;
            border-bottom: 1px solid #111827;
        }

        .meta-item--wide {
            grid-column: span 2;
        }

        .meta-label {
            display: block;
            color: #4b5563;
            font-size: 8px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .meta-value {
            display: block;
            margin-top: 3px;
            color: #111827;
            font-size: 11px;
            font-weight: 700;
        }

        .summary-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            margin-bottom: 8px;
            border: 1px solid #111827;
            border-right: 0;
        }

        .summary-item {
            padding: 5px 8px;
            border-right: 1px solid #111827;
            text-align: center;
        }

        .summary-label {
            display: block;
            color: #4b5563;
            font-size: 8px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .summary-value {
            display: block;
            margin-top: 2px;
            font-size: 12px;
            font-weight: 700;
        }

        .student-form {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 0;
            border: 1px solid #111827;
            border-right: 0;
            border-bottom: 0;
        }

        .field {
            min-height: 36px;
            padding: 4px 6px;
            border-right: 1px solid #111827;
            border-bottom: 1px solid #111827;
        }

        .field--wide {
            grid-column: span 2;
        }

        .field label {
            display: block;
            color: #4b5563;
            font-size: 8px;
            font-weight: 700;
            letter-spacing: 0.08em;
            text-transform: uppercase;
        }

        .field .value {
            display: block;
            margin-top: 4px;
            color: #111827;
            font-size: 11px;
            font-weight: 700;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            font-size: 10px;
        }

        .data-table th,
        .data-table td {
            border: 1px solid #111827;
            padding: 4px 5px;
            text-align: left;
            vertical-align: middle;
            word-break: break-word;
        }

        .data-table th {
            background: #f3f4f6;
            font-size: 9px;
            font-weight: 700;
            text-transform: uppercase;
        }

        .data-table tbody tr:nth-child(even) td {
            background: #fbfbfb;
        }

        .text-center {
            text-align: center;
        }

        .nowrap { white-space: nowrap; }

        .empty {
            padding: 18mm;
            color: #111827;
            font-size: 14px;
            font-weight: 700;
        }

        @media print {
            body {
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
            }
        }
    </style>
</head>
<body>
    @if ($individualPrint && $records->isNotEmpty())
        @php
            $record = $records->first();
            $value = fn ($field) => filled($field) ? $field : 'N/A';
            $roleLabel = fn ($role) => match ((int) $role) {
                1 => 'Student',
                2 => 'Employee',
                default => $value($role),
            };
        @endphp

        <main class="sheet">
            <header class="report-header">
                <div class="report-brand">
                    <img src="{{ asset('images/olpcc-logo.png') }}" class="report-logo" alt="OLPCC logo">

                    <div class="agency">
                        <h1 class="agency-name">OLPCC / OSMIS-eGATE</h1>
                        <p class="agency-subtitle">Student Information Management System</p>
                        <p class="agency-system">Official Student Data Record</p>
                    </div>
                </div>

                <div class="document-code" aria-label="Document details">
                    <div><span>Report</span><strong>DATA</strong></div>
                    <div><span>Mode</span><strong>Single</strong></div>
                    <div><span>Printed</span><strong>{{ $printedAt->format('m/d/Y') }}</strong></div>
                </div>
            </header>

            <section class="report-title">
                <h2>Student Data Record</h2>
                <p>{{ $record->name ?: 'N/A' }}</p>
            </section>

            <section class="meta-grid" aria-label="Report information">
                <div class="meta-item meta-item--wide">
                    <span class="meta-label">Record Scope</span>
                    <span class="meta-value">Single student data record</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Generated By</span>
                    <span class="meta-value">{{ auth()->user()->username ?? auth()->user()->email ?? 'System' }}</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Generated At</span>
                    <span class="meta-value">{{ $printedAt->format('F j, Y g:i A') }}</span>
                </div>
            </section>

            <section class="student-form" aria-label="Student information">
                <div class="field">
                    <label>ID No / LRN</label>
                    <span class="value">{{ $value($record->student_number ?: $record->lrn) }}</span>
                </div>
                <div class="field">
                    <label>RFID</label>
                    <span class="value">{{ $value($record->rfid) }}</span>
                </div>
                <div class="field field--wide">
                    <label>Name</label>
                    <span class="value">{{ $value($record->name) }}</span>
                </div>
                <div class="field">
                    <label>Role</label>
                    <span class="value">{{ $roleLabel($record->role) }}</span>
                </div>
                <div class="field field--wide">
                    <label>Email</label>
                    <span class="value">{{ $value($record->email) }}</span>
                </div>
                <div class="field">
                    <label>Contact</label>
                    <span class="value">{{ $value($record->contact) }}</span>
                </div>
                <div class="field">
                    <label>Department</label>
                    <span class="value">{{ $value($record->department) }}</span>
                </div>
                <div class="field">
                    <label>Course</label>
                    <span class="value">{{ $value($record->course) }}</span>
                </div>
                <div class="field">
                    <label>School Level</label>
                    <span class="value">{{ $value($record->school_level) }}</span>
                </div>
                <div class="field">
                    <label>Grade Level</label>
                    <span class="value">{{ $value($record->grade_level) }}</span>
                </div>
            </section>
        </main>
    @elseif ($individualPrint)
        <div class="empty">No records found.</div>
    @else
        @php
            $roleLabel = fn ($role) => match ((int) $role) {
                1 => 'Student',
                2 => 'Employee',
                default => filled($role) ? $role : 'N/A',
            };
        @endphp

        <main class="sheet">
            <header class="report-header">
                <div class="report-brand">
                    <img src="{{ asset('images/olpcc-logo.png') }}" class="report-logo" alt="OLPCC logo">

                    <div class="agency">
                        <h1 class="agency-name">OLPCC / OSMIS-eGATE</h1>
                        <p class="agency-subtitle">Student Information Management System</p>
                        <p class="agency-system">Official Student Data Record</p>
                    </div>
                </div>

                <div class="document-code" aria-label="Document details">
                    <div><span>Report</span><strong>DATA</strong></div>
                    <div><span>Mode</span><strong>Bulk</strong></div>
                    <div><span>Printed</span><strong>{{ $printedAt->format('m/d/Y') }}</strong></div>
                </div>
            </header>

            <section class="report-title">
                <h2>Student Data Records</h2>
                <p>All matching student data</p>
            </section>

            <section class="meta-grid" aria-label="Report information">
                <div class="meta-item meta-item--wide">
                    <span class="meta-label">Report Scope</span>
                    <span class="meta-value">All matching student data records</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Generated By</span>
                    <span class="meta-value">{{ auth()->user()->username ?? auth()->user()->email ?? 'System' }}</span>
                </div>
                <div class="meta-item">
                    <span class="meta-label">Generated At</span>
                    <span class="meta-value">{{ $printedAt->format('F j, Y g:i A') }}</span>
                </div>
            </section>

            <section class="summary-grid" aria-label="Record summary">
                <div class="summary-item">
                    <span class="summary-label">Total Records</span>
                    <span class="summary-value">{{ $records->count() }}</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Students</span>
                    <span class="summary-value">{{ $records->where('role', 1)->count() }}</span>
                </div>
                <div class="summary-item">
                    <span class="summary-label">Employees</span>
                    <span class="summary-value">{{ $records->where('role', 2)->count() }}</span>
                </div>
            </section>

            <table class="data-table">
                <colgroup>
                    <col style="width: 6%">
                    <col style="width: 13%">
                    <col style="width: 10%">
                    <col style="width: 17%">
                    <col style="width: 9%">
                    <col style="width: 16%">
                    <col style="width: 10%">
                    <col style="width: 10%">
                    <col style="width: 9%">
                </colgroup>
                <thead>
                    <tr>
                        <th class="text-center">No.</th>
                        <th>ID No / LRN</th>
                        <th>RFID</th>
                        <th>Name</th>
                        <th>Role</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Department</th>
                        <th>Grade Level</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse ($records as $index => $record)
                        <tr>
                            <td class="text-center nowrap">{{ $index + 1 }}</td>
                            <td>{{ $record->student_number ?: ($record->lrn ?: 'N/A') }}</td>
                            <td>{{ $record->rfid ?: 'N/A' }}</td>
                            <td>{{ $record->name ?: 'N/A' }}</td>
                            <td>{{ $roleLabel($record->role) }}</td>
                            <td>{{ $record->email ?: 'N/A' }}</td>
                            <td>{{ $record->contact ?: 'N/A' }}</td>
                            <td>{{ $record->department ?: 'N/A' }}</td>
                            <td>{{ $record->grade_level ?: 'N/A' }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="9" class="text-center">No records found.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </main>
    @endif

    <script>
        const returnUrl = @json(url('admin/data') . (request()->except('record_id') ? '?' . http_build_query(request()->except('record_id')) : ''));
        let printRequested = false;
        let redirected = false;

        function redirectBackToData() {
            if (redirected) {
                return;
            }

            redirected = true;
            window.location.replace(returnUrl);
        }

        window.addEventListener('afterprint', () => {
            window.setTimeout(redirectBackToData, 100);
        });

        window.addEventListener('focus', () => {
            if (printRequested) {
                window.setTimeout(redirectBackToData, 300);
            }
        });

        window.addEventListener('load', () => {
            window.setTimeout(() => {
                printRequested = true;
                window.print();
            }, 100);
        });
    </script>
</body>
</html>
