<?php

class ExampleTest extends TestCase {

	/**
	 * A basic functional test example.
	 *
	 * @return void
   */
	public function testBasicExample()
	{
		$crawler = $this->client->request('GET', '/?country=US');

		$this->assertTrue($this->client->getResponse()->isOk());
	}

}
