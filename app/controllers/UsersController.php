<?php

class UsersController extends \BaseController {

	/**
	 * @var User
	 */
	protected $user;

	public function __construct(User $user)
	{
		$this->user = $user;
	}

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		if (Auth::guest()) {
			return Redirect::route('sessions.login');
		}

		return User::all();
	}


	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		if (Auth::guest()) {
			return View::make('users.create');
		} else {
			return Redirect::to('/');
		}
	}


	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		$this->user->fill(Input::all());

		if ($this->user->save()) {
			return Redirect::route('sessions.login');
		}

		dd($this->user->getErrors());

		return Redirect::back()->withInput()->withErrors($this->user->getErrors());
	}


	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		if (Auth::guest()) {
			return Redirect::route('sessions.login');
		}

		return $this->loadUser($id);
	}


	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		App::abort(500, 'This action is not defined yet!');
		$this->loadUser($id);

		if (!$this->user) {
			APP::abort(404, 'Could not find the User');
		}

		return View::make('users.create')->withInput($this->user->attributes);
	}


	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		//
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		$this->loadUser($id);

		if ($this->user) {
			$this->user->delete();
		}
	}

	protected function loadUser($id)
	{
		$this->user = User::find($id);

		return $this->user;
	}


}
