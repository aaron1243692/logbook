@extends('layouts.app')

@section('title', 'Setup Management')

@section('content')
<main class="eg-setup-page">
    <section class="eg-setup-hero">
        <div>
            <p class="eg-setup-kicker">Administration</p>
            <h1 class="eg-setup-title">Setup Management</h1>
            <p class="eg-setup-subtitle">
                Manage registration details and logbook records from one clean admin hub.
            </p>
        </div>
    </section>

    <section class="eg-setup-grid" aria-label="Setup modules">
        @can('data.view')
        <a class="eg-setup-card eg-setup-card-link" href="{{ route('admin.data') }}">
            <span class="eg-setup-card-icon">R</span>
            <span class="eg-setup-card-body">
                <span class="eg-setup-card-title">Registration</span>
                <span class="eg-setup-card-text">Manage registered logbook people and access details.</span>
            </span>
            <span class="eg-setup-card-arrow" aria-hidden="true">-></span>
        </a>
        @endcan

        @can('logs.view')
        <a class="eg-setup-card eg-setup-card-link" href="{{ route('admin.logs') }}">
            <span class="eg-setup-card-icon">L</span>
            <span class="eg-setup-card-body">
                <span class="eg-setup-card-title">Logs</span>
                <span class="eg-setup-card-text">Review, print, and export logbook records.</span>
            </span>
            <span class="eg-setup-card-arrow" aria-hidden="true">-></span>
        </a>
        @endcan

    </section>
</main>
@endsection
