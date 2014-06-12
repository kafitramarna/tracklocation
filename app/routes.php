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

Route::get('/', function()
{
	return View::make('hello');
});

Route::get('city', function(){
	$visitor = Tracker::currentSession();
	echo '<pre>';
	var_dump( $visitor );
	echo '</pre>';
});

Route::get('errors', function(){
	$errors = Tracker::errors(60 * 24);
	var_dump($errors);
});

Route::get('users', function(){
	$users = Tracker::users(60 * 24);
	var_dump($users);
});

Route::get('page', function(){
	$pageViews = Tracker::pageViews(60 * 24 * 30);
	var_dump($pageViews);
});

Route::get('cview', function(){
	$pageViews = Tracker::pageViewsByCountry(60 * 24);
	var_dump($pageViews);
});
