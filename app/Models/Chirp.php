<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Chirp extends Model
{
    protected $fillable = [
        'message',
    ];

    //metodo che definisce la relazione con gli utenti
    // : BelongsTo è un hint che indica il tipo di ritorno
    public function user(): BelongsTo{
        return $this->belongsTo(User::class);
    }

}