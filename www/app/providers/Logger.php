<?php
/**
 * Created by PhpStorm.
 * User: mholford
 * Date: 10/22/13
 * Time: 4:30 PM
 */

namespace TeensForJeans;

use \StatHat;
use \Illuminate\Support\Facades\Config;

/**
 * Class Logger
 *
 * Handles logging to StatHat.
 *
 * @package TeensForJeans
 */
class Logger {

  /**
   * Log country to StatHat.
   *
   * @param string $account   StatHat account name
   * @param string $code      Logging code
   */
  public static function logRedirect($account, $code)
  {
    StatHat::stathat_ez_count($account, $code, 1);
  }

}
