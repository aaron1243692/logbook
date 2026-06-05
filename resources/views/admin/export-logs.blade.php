<table border="1">
    <thead>
        <tr style="color: #000000;">
            <th>No.</th>
            <th>ID</th>
            <th>Name</th>
            <th>Login</th>
            <th>Logout</th>
            <th>Time Consumed</th>
            <th>Date</th>
        </tr>
    </thead>
    <tbody>
        @forelse ($logs as $index => $log)
            <tr>
                <td>{{ $index + 1 }}</td>
                <td>{{ $log['student_id'] }}</td>
                <td>{{ $log['name'] }}</td>
                <td>{{ $log['login'] }}</td>
                <td>{{ $log['logout'] }}</td>
                <td>{{ $log['time_consumed'] }}</td>
                <td>{{ $log['date'] }}</td>
            </tr>
        @empty
            <tr>
                <td colspan="7">No logs found.</td>
            </tr>
        @endforelse
    </tbody>
</table>
