<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Inicio::index');
$routes->get('/projeto', 'Projeto::index');
$routes->get('/participantes', 'Participantes::index');
