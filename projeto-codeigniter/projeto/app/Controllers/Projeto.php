<?php

namespace App\Controllers;

class Projeto extends BaseController
{
    public function index(): string
    {
        return view('projeto');
    }
}
