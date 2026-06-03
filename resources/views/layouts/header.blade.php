@php
    $canRegistration = auth()->user()->can('data.view');
    $canRecords = auth()->user()->can('logs.view');
    $canSetup = $canRegistration || $canRecords;
    $canAccessControl = auth()->user()->can('roles.view')
        || auth()->user()->can('users.view');
    $canTimeIn = canAccessWithParent(auth()->user(), 'login');
    $canTimeOut = canAccessWithParent(auth()->user(), 'logout');
    $canGate = $canTimeIn || $canTimeOut;

    $isDashboard = request()->routeIs('admin.dashboard');
@endphp

<header class="eg-rb" data-eg-ribbon>
    <div class="eg-rb-top">
        <a class="eg-rb-brand" href="{{ route('admin.dashboard') }}" aria-label="LogBook dashboard">
            <img src="{{ asset('images/olpcc-logo-removebg.png') }}" alt="">
            <span>OLPCC / LogBook</span>
        </a>

        <nav class="eg-rb-tabs" aria-label="Admin navigation">
            <button class="eg-rb-tab is-active" type="button" data-eg-ribbon-tab="menu">Menu</button>
        </nav>

        <details class="eg-rb-user" id="egRbUserDropdown">
            <summary
                class="eg-rb-userbtn"
                aria-controls="egRbUserMenu"
            >
                <span class="eg-rb-userlabel">{{ auth()->user()->username ?? auth()->user()->email }}</span>
                <span class="eg-rb-usercaret" aria-hidden="true"></span>
            </summary>
            <div class="eg-rb-usermenu" id="egRbUserMenu" role="menu">
                <div class="eg-rb-usercaption">Signed in as</div>
                <div class="eg-rb-username">{{ auth()->user()->username ?? auth()->user()->email }}</div>
                <a class="eg-rb-usermenu-link eg-rb-usermenu-link--danger" href="{{ route('admin.reauth') }}" role="menuitem">
                    Sign Out
                </a>
            </div>
        </details>
    </div>

    <div class="eg-rb-ribbon">
        <div class="eg-rb-page is-active" data-eg-ribbon-page="menu">
            <section class="eg-rb-group">
                <div class="eg-rb-group-title">Dashboard</div>
                <div class="eg-rb-items">
                    <a class="eg-rb-tile {{ $isDashboard ? 'is-active' : '' }}" href="{{ route('admin.dashboard') }}">
                        <span class="eg-rb-icon eg-rb-icon--image">
                            <img src="{{ asset('icons/list.png') }}" alt="" aria-hidden="true">
                        </span>
                        <span>Dashboard</span>
                    </a>
                </div>
            </section>

            @if ($canSetup)
                <section class="eg-rb-group">
                    <div class="eg-rb-group-title">Setup</div>
                    <div class="eg-rb-items">
                        @if ($canRegistration)
                            <a class="eg-rb-tile {{ request()->routeIs('admin.data*') ? 'is-active' : '' }}" href="{{ route('admin.data') }}">
                                <span class="eg-rb-icon eg-rb-icon--image">
                                    <img src="{{ asset('icons/folder.png') }}" alt="" aria-hidden="true">
                                </span>
                                <span>Registration</span>
                            </a>
                        @endif
                        @can('logs.view')
                            <a class="eg-rb-tile {{ request()->routeIs('admin.logs*') ? 'is-active' : '' }}" href="{{ route('admin.logs') }}">
                                <span class="eg-rb-icon eg-rb-icon--image">
                                    <img src="{{ asset('icons/stlog.png') }}" alt="" aria-hidden="true">
                                </span>
                                <span>Logs</span>
                            </a>
                        @endcan
                    </div>
                </section>
            @endif

            @if ($canAccessControl)
                <section class="eg-rb-group">
                    <div class="eg-rb-group-title">Access Control</div>
                    <div class="eg-rb-items">
                        @can('roles.view')
                            <a class="eg-rb-tile {{ request()->routeIs('admin.roles*') ? 'is-active' : '' }}" href="{{ route('admin.roles') }}">
                                <span class="eg-rb-icon eg-rb-icon--image">
                                    <img src="{{ asset('icons/crown.png') }}" alt="" aria-hidden="true">
                                </span>
                                <span>Roles</span>
                            </a>
                        @endcan
                        @can('users.view')
                            <a class="eg-rb-tile {{ request()->routeIs('admin.users.*') ? 'is-active' : '' }}" href="{{ route('admin.users.index') }}">
                                <span class="eg-rb-icon eg-rb-icon--image">
                                    <img src="{{ asset('icons/user.png') }}" alt="" aria-hidden="true">
                                </span>
                                <span>Users</span>
                            </a>
                        @endcan
                    </div>
                </section>
            @endif

            @if ($canGate)
                <section class="eg-rb-group">
                    <div class="eg-rb-group-title">LogBook</div>
                    <div class="eg-rb-items">
                        @if ($canTimeIn)
                            <a class="eg-rb-tile eg-rb-tile--success" href="{{ route('in') }}">
                                <span class="eg-rb-icon">IN</span>
                                <span>Login</span>
                            </a>
                        @endif
                        @if ($canTimeOut)
                            <a class="eg-rb-tile eg-rb-tile--danger" href="{{ route('out') }}">
                                <span class="eg-rb-icon">OUT</span>
                                <span>Logout</span>
                            </a>
                        @endif
                    </div>
                </section>
            @endif
        </div>
    </div>
</header>

@once
    @push('scripts')
        <script>
            document.addEventListener('click', (event) => {
                const dropdown = document.getElementById('egRbUserDropdown');

                if (dropdown && !dropdown.contains(event.target)) {
                    dropdown.removeAttribute('open');
                }
            });

            document.addEventListener('keydown', (event) => {
                const dropdown = document.getElementById('egRbUserDropdown');

                if (event.key === 'Escape' && dropdown?.hasAttribute('open')) {
                    dropdown.removeAttribute('open');
                    dropdown.querySelector('summary')?.focus();
                }
            });
        </script>
    @endpush
@endonce
