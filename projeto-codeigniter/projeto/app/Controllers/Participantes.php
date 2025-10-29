<?php

namespace App\Controllers;

class Participantes extends BaseController
{
    public function index(): string
    {
        return view('participantes');
    }
}
