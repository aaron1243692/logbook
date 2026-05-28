<table border="1">
    <thead>
        <tr style="color: #000000;">
            <th>No.</th>
            <th>ID No / LRN</th>
            <th>RFID</th>
            <th>Name</th>
            <th>Role</th>
            <th>Email</th>
            <th>Contact</th>
            <th>Department</th>
            <th>Course</th>
            <th>School Level</th>
            <th>Grade Level</th>
        </tr>
    </thead>
    <tbody>
        @php
            $roleLabel = fn ($role) => match ((int) $role) {
                1 => 'Student',
                2 => 'Employee',
                default => filled($role) ? $role : '',
            };
        @endphp
        @forelse ($records as $index => $record)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ $record->student_number ?: $record->lrn }}</td>
                <td>{{ $record->rfid }}</td>
                <td>{{ $record->name }}</td>
                <td>{{ $roleLabel($record->role) }}</td>
                <td>{{ $record->email }}</td>
                <td>{{ $record->contact }}</td>
                <td>{{ $record->department }}</td>
                <td>{{ $record->course }}</td>
                <td>{{ $record->school_level }}</td>
                <td>{{ $record->grade_level }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="10">No records found.</td>
            </tr>
        @endforelse
    </tbody>
</table>
