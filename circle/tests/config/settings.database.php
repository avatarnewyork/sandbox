<?
$databases = array (
		    'default' =>
		    array (
			   'default' =>
			   array (
				  'database' => 'test',
				  'username' => 'admin',
				  'password' => 'admin',
				  'host' => getenv("DB_1_PORT_3306_TCP_ADDR"),
				  'port' => getenv("DB_1_PORT_3306_TCP_PORT"),
				  'driver' => 'mysql',
				  'prefix' => '',
				  ),
			   ),
		    );

return $databases;
