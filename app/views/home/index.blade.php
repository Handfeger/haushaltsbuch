@extends('layouts.default')

@section('content')

    <header class="navbar">
        <div class="container-fluid expanded-panel">
            <div class="row">
                <div id="logo" class="col-xs-12 col-sm-2">
                    <a href="#">Haushaltsbuch</a>
                </div>
                <div id="top-panel" class="col-xs-12 col-sm-10">
                    <div class="row">
                        <div class="col-xs-10 col-sm-10">
                        </div>
                        <div class="col-xs-4 col-sm-2 top-panel-right">
                            <ul class="nav navbar-nav pull-right panel-menu">
                                <li class="dropdown">
                                    <div class="hoodie-account-signedout">

                                    </div>

                                    <a href="#" class="dropdown-toggle account" data-toggle="dropdown">
                                        <i class="fa fa-angle-down pull-right"></i>

                                        <div class="user-mini pull-right">
                                            <span class="welcome">Moin moin,</span>
                                            <span>{{ Auth::user()->name }}</span>
                                        </div>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="{{ route('sessions.logout') }}">
                                                <i class="fa fa-power-off"></i>
                                                <span>Logout</span>
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--End Header-->
    <!--Start Container-->
    <div id="main" class="container-fluid">
        <div class="row">
            <div id="sidebar-left" class="col-xs-2 col-sm-2">
                <ul class="nav main-menu">
                    <li>
                        <a href="#" class="active ajax-link">
                            <i class="fa fa-dashboard"></i>
                            <span class="hidden-xs">Dashboard</span>
                        </a>
                    </li>
                </ul>
                <footer class="container">
                </footer>
            </div>
            <!--Start Content-->
            <div id="content" class="col-xs-12 col-sm-10">
                <div class="row">
                    <div id="breadcrumb" class="col-xs-12">
                        <ol class="breadcrumb">
                            <li><a href="#"></a></li>
                        </ol>
                    </div>
                </div>


                <all-entries></all-entries>

            </div>
            <!--End Content-->
        </div>
    </div>
    <!--End Container-->

@stop

@section('footer')
    <script src="assets/vendor/vendor.js"></script>
    <script src="assets/js/application.js"></script>
@stop
