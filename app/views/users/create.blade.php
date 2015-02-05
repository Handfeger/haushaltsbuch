@extends('layouts.default')

@section('content')

    <div class="container-fluid">
        <div id="page-login" class="row">
            <div class="col-xs-12 col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
                <div class="text-right">
                    {{ link_to('/login', 'Already have an account?', ['class' => 'txt-default',]) }}
                </div>
                <div class="box">
                    {{ Form::open(['route' => 'users.store']) }}
                    <div class="box-content">
                        <div class="text-center">
                            <h3 class="page-header">Register</h3>
                        </div>
                        <div class="form-group">
                            {{ Form::label('email', 'Email:', ['class' => 'control-label',]) }}
                            {{ Form::email('email', null, ['class' => 'form-control',]) }}
                            {{ $errors->first('email', '<span class="small">:message</span>') }}
                        </div>
                        <div class="form-group">
                            {{ Form::label('name', 'Username:', ['class' => 'control-label',]) }}
                            {{ Form::text('name', null, ['class' => 'form-control',]) }}
                            {{ $errors->first('name', '<span class="small">:message</span>') }}
                        </div>
                        <div class="form-group">
                            {{ Form::label('password', 'Password:', ['class' => 'control-label',]) }}
                            {{ Form::password('password', ['class' => 'form-control',]) }}
                            {{ $errors->first('password', '<span class="small">:message</span>') }}
                        </div>
                        <div class="text-center">
                            {{ Form::submit('Register', ['class' => 'btn btn-primary',]) }}
                        </div>
                    </div>
                    {{ Form::close() }}
                </div>
            </div>
        </div>
    </div>

@stop