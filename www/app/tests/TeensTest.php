<?php
/**
 * Tests Teens For Jeans redirects.
 */

class TeensTest extends TestCase {

  /**
   * Test that a CA country code results in the
   * Canada URL redirect. Trivial test.
   */
  public function testCanada()
  {
    $urlFromApp = HomeController::redirectToCountry('CA');
    $redirectTargets = Config::get('app.tfj-redirects');
    $urlFromConfig = $redirectTargets['CA'];

    $this->assertTrue($urlFromApp == $urlFromConfig);

  }

  /**
   * Test that a US country code results in the
   * Canada URL redirect. Trivial test.
   */
  public function testUS()
  {
    $urlFromApp = HomeController::redirectToCountry('US');
    $redirectTargets = Config::get('app.tfj-redirects');
    $urlFromConfig = $redirectTargets['US'];

    $this->assertTrue($urlFromApp == $urlFromConfig);

  }

}
