@extends('layouts.default')

@section('content')

    <div class="container-fluid">
        <div id="page-login" class="row">
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                <div class="box">
                    {{ Form::open(['route' => 'sessions.store']) }}
                    <div class="box-content">
                        <div class="text-center">
                            <h3 class="page-header">Haushaltsbuch Login</h3>
                        </div>
                        <div class="form-group">
                            {{ Form::label('email', 'Email:') }}
                            {{ Form::email('email') }}
                            <label class="control-label">Benutzer</label>
                            <input type="text" class="form-control" name="username" ng-model="userCtrl.username" required/>
                        </div>
                        <div class="form-group">
                            {{ Form::label('password', 'Password:') }}
                            {{ Form::password('password') }}
                            <label class="control-label">Passwort</label>
                            <input type="password" class="form-control" name="password" ng-model="userCtrl.password" required/>
                        </div>
                        <div class="text-center">
                            {{ Form::submit('login') }}
                            <button type="submit" class="btn btn-primary" ng-disabled="!loginForm.$valid">Einloggen
                            </button>
                        </div>
                    </div>
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>

@stop