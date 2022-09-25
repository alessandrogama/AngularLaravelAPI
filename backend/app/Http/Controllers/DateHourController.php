<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DateHourController extends Controller
{
    public function getDateHour(){
       $datehour = date("d/m/Y H:i:s");
       return response()->json($datehour);
    }
}
