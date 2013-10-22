<?php

class HomeController extends BaseController {

	/*
	|--------------------------------------------------------------------------
	| Default Home Controller
	|--------------------------------------------------------------------------
	|
	| You may wish to use controllers instead of, or in addition to, Closure
	| based routes. That's great! Here is an example controller method to
	| get you started. To route to this controller, just add the route:
	|
	|	Route::get('/', 'HomeController@showWelcome');
	|
	| Main route for Teens For Jeans:
	| Route::get('/', 'HomeController@doRedirect');
	|
	*/

  /**
   * Based on GeoIP header passed by Varnish, redirect to the appropriate
   * site.
   *
   * Examples:
   *    X-Geo-IP: country:US
   *    X-Geo-IP: country:CA
   *    X-Geo-IP: country:A6 (failure case)
   *
   * @see https://github.com/cosimo/varnish-geoip
   */
  public function doRedirect()
  {

    try
    {
      $country = self::getCountryCode();
    }
    catch (Exception $e)
    {
      $country = 'None';
    }

    $url = self::redirectToCountry($country);

    if (Request::query('debug'))
    {
      return 'Will redirect to ' . $url;
    }

    return Redirect::to($url);
  }

  /**
   * Given a country code, redirect to the appropriate site.
   *
   * @param string $country
   * @return string
   */
  public static function redirectToCountry($country)
  {
    self::log('TFJ: Country: ' . $country);

    $redirectTargets = Config::get('app.tfj-redirects');

    $country = ('None' == $country) ? 'US' : $country;

    return $redirectTargets[$country];
  }

  /**
   * Punt log message to our Logger class.
   *
   * @param $code
   */
  protected static function log($code)
  {
    \TeensForJeans\Logger::logRedirect(Config::get('app.stathat-account'), $code);
  }

  /**
   * Safely retrieve X-Geo-IP header contents. Allow for a test
   * override via "country" GET param, or $header.
   *
   * @param string $header      Optional two-letter country code.
   * @throws Exception
   * @return string
   */
  public static function getCountryCode($header = '')
  {
    // 'country' GET param can override. This obviously only works
    // if passed through from the external cache layer (e.g.,
    // Varnish).

    $header = (empty($header)) ? Request::query('country') : $header;

    if (empty($header))
    {
      $header = Request::header('X-Geo-IP');
      $response = str_replace('country:', '', $header);
    }
    else
    {
      // In the override case, we'll just be passing, e.g., "country=US".
      $response = $header;
    }

    if (empty($header))
    {
      throw new \Exception('No X-Geo-IP header passed');
    }

    return $response;
  }

}
