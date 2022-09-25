<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class GetTextReturnController extends Controller
{
    public function getInput(Request $request){
        return response()->json([$request->textInput]);
    }
}
