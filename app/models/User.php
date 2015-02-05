<?php

use Illuminate\Auth\UserTrait;
use Illuminate\Auth\UserInterface;
use Illuminate\Auth\Reminders\RemindableTrait;
use Illuminate\Auth\Reminders\RemindableInterface;

class User extends \Handfeger\Database\Model implements UserInterface, RemindableInterface
{

    use UserTrait, RemindableTrait;

    /**
     * @var array
     */
    protected $fillable = ['email', 'name', 'password'];

    /**
     * @var array
     */
    protected static $rules = [
        'name'     => 'required',
        'email'    => 'required|email|unique:users',
        'password' => 'required|min:6',
    ];

    /**
     * The database table used by the model.
     *
     * @var string
     */
    protected $table = 'users';

    /**
     * The attributes excluded from the model's JSON form.
     *
     * @var array
     */
    protected $hidden = array('password', 'remember_token');

    public static function boot()
    {
        parent::boot();

        User::saving(
            /**
             * Always save a hash of the password
             *
             * @param User $user
             *
             * @return null
             */
            function ($user) {
                if (Hash::needsRehash($user->password)) {
                    $user->password = Hash::make($user->password);
                }

                return NULL;
            });
    }
}
