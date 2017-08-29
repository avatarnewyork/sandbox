<?php

/**
 * @file
 * Local development override configuration feature.
 *
 * To activate this feature, copy and rename it such that its path plus
 * filename is 'sites/default/settings.local.php'. Then, go to the bottom of
 * 'sites/default/settings.php' and uncomment the commented lines that mention
 * 'settings.local.php'.
 *
 * If you are using a site name in the path, such as 'sites/example.com', copy
 * this file to 'sites/example.com/settings.local.php', and uncomment the lines
 * at the bottom of 'sites/example.com/settings.php'.
 */

$databases = array(
  'default' => array(
    'default' => array(
      'database' => 'test',
      'username' => 'admin',
      'password' => 'admin',
      'host' => getenv('DB_1_PORT_3306_TCP_ADDR'),
      'port' => getenv('DB_1_PORT_3306_TCP_PORT'),
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

