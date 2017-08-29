<?php
/** The name of the database for WordPress */
define('DB_NAME', 'test');

/** MySQL database username */
define('DB_USER', 'admin');

/** MySQL database password */
define('DB_PASSWORD', 'admin');

/** MySQL hostname */
define('DB_HOST', getenv("DB_1_PORT_3306_TCP_ADDR").':'.getenv("DB_1_PORT_3306_TCP_PORT"));

/** Force Base URLs for the ENV **/
//define('WP_HOME','http://'.getenv("CIRCLE_SHA1").'.ngrok.io');
//define('WP_SITEURL','http://'.getenv("CIRCLE_SHA1").'.ngrok.io');
