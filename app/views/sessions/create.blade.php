@extends('layouts.default')

@section('content')

    <div class="container-fluid">
        <div id="page-login" class="row">
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                <div class="text-right">
                    {{ link_to('/register', 'Need an account?', ['class' => 'txt-default',]) }}
                </div>
                <div class="box">
                    {{ Form::open(['route' => 'sessions.store']) }}
                    <div class="box-content">
                        <div class="text-center">
                            <h3 class="page-header">Haushaltsbuch Login</h3>
                        </div>
                        <div class="form-group">
                            {{ Form::label('email', 'Email:', ['class' => 'control-label',]) }}
                            {{ Form::email('email', null, ['class' => 'form-control',]) }}
                            {{ $errors->first('email', '<span class="small">:message</span>') }}
                        </div>
                        <div class="form-group">
                            {{ Form::label('password', 'Password:', ['class' => 'control-label',]) }}
                            {{ Form::password('password', ['class' => 'form-control',]) }}
                        </div>
                        <div class="text-center">
                            {{ Form::submit('Login', ['class' => 'btn btn-primary',]) }}
                        </div>
                    </div>
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>

@stop