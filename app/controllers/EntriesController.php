<?php

class EntriesController extends \BaseController {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
		return Response::json(Entry::all());
	}


	/**
	 * Show the form for creating a new resource.
	 *
	 * @return Response
	 */
	public function create()
	{
		//no
	}


	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
		/** @var Entry $entry */
		$entry = new Entry(Input::all());

		if ($entry->save()) {
			return Response::json([], 201, [
				'Location' => route('entry.show', ['id' => $entry->id,]),
			]);
		} else {
			return Response::json(['error' => $entry->getErrors()], 409);
		}
	}


	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
		/** @var Entry $entry */
		$entry = Entry::find($id);

		if (!$entry) {
			return Response::json([], 404);
		}

		return Response::json($entry);
	}


	/**
	 * Show the form for editing the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function edit($id)
	{
		//no
	}


	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		/** @var Entry $entry */
		$entry = Entry::find($id);

		if (!$entry) {
			return Response::json(['error' => 'Not Found!',], 404);
		}

		$entry->fill(Input::all());

		if ($entry->save()) {
			return Response::json([], 204);
		} else {
			return Response::json(['error' => $entry->getErrors()], 409);
		}
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		/** @var Entry $entry */
		$entry = Entry::find($id);

		if (!$entry) {
			return Response::json(['error' => 'Not Found!',], 404);
		}

		if ($entry->delete()) {
			return Response::json([], 204);
		} else {
			return Response::json(['error' => 'Db Error ¯\_(ツ)_/¯',], 500);
		}
	}


}
