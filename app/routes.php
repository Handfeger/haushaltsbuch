<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
*/
Route::get('/', [
    'uses' => 'HomeController@index',
    'as' => 'root',
    ])->before('auth');
Route::post('/', function () {
    return Redirect::to('/');
});

/*
|--------------------------------------------------------------------------
| User Routes
|--------------------------------------------------------------------------
|
| Here are all the Routes needed for Users and Sessions
|
*/
Route::get('login', ['as' => 'sessions.login','uses' => 'SessionsController@create']);
Route::get('logout', ['as' => 'sessions.logout', 'uses' => 'SessionsController@destroy']);
Route::resource('sessions', 'SessionsController');
Route::get('register', ['as' => 'sessions.register', 'uses' => 'UsersController@create']);
Route::resource('users', 'UsersController');