<?php
/*!!*
╔================================ Entry.php ====================================
║
║ 	Create Date: 05.02.2015
║
║ 	Last Update: 05.02.2015
║
║ 	Author(s): Michel Vielmetter <coding@michelvielemtter.de>
║ 	Copyright: Michel Vielmetter 2015
║ 	Licence:   MIT
║
╠================================ Entry.php ====================================
║
║ 	[packageID]					accountbook.
║
╚================================ Entry.php ====================================
*/

/**
 * Class Entry
 */
class Entry extends \Handfeger\Database\Model
{
    protected static $rules = [
        'entry_date' => 'required|date',
        'subject' => 'required',
        'price' => 'required|numeric',
        'shared' => 'boolean',
    ];

    protected $fillable = [
        'entry_date',
        'subject',
        'price',
        'shared',
    ];

    protected $appends = [
        'owned',
    ];

    public static function boot()
    {
        parent::boot();

        Entry::creating(function ($entry) {
            $entry->user_id = Auth::user()->id;

            return NULL;
        });
    }

    public function user()
    {
        return $this->belongsTo('User');
    }

    public function getOwnedAttribute()
    {
        return $this->user->id == Auth::user()->id;
    }

    /**
     * Set the scope to entries that the user actually can show
     *
     * @param \Illuminate\Database\Eloquent\Builder $query
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopeBelonging($query)
    {

        return $query->whereUserId(Auth::user()->id)->orWhere('shared', '=', 1);
    }

    public function getHasAccessAttribute()
    {
        return $this->owned || $this->shared;
    }
}