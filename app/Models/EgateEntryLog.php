<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class EgateEntryLog extends Model
{
    use HasFactory;

    protected $table = 'egate_logs';

    protected $fillable = [
        'egate_data_id',
        'student_id',
        'time',
        'date',
    ];

    public function egateData(): BelongsTo
    {
        return $this->belongsTo(EgateLog::class, 'egate_data_id');
    }
}
