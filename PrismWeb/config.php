<?php

// PRISM
// By viveleroi.
require_once('libs/Peregrine.php');
require_once('libs/Auth.php');


// ------------------------------------------
// DATABASE
// ------------------------------------------

// Setup your MySQL connection information
// below.

define("MYSQL_HOSTNAME", "127.0.0.1");
define("MYSQL_USERNAME", "root");
define("MYSQL_PASSWORD", "");
define("MYSQL_DATABASE", "minecraft");

// NOTICE:
//
// We *strongly* recommend that you use a mysql account that has been given
// SELECT permissions ONLY. We try to ensure that this web interface can't be
// used maliciously but the more safeguards you can take, the better.

// This interface does not yet support sqlite databases.

// ------------------------------------------
// USER AUTHENTICATION
// ------------------------------------------

// This is a basic method for requiring user authentication
// before being allowed to access the interface.

// You can add as many users as you wish by following the instructions
// below.

// Change this to "true" if you want to require authentication
define("REQUIRE_AUTH", true);

$auth = new Auth();

// Define usernames and passwords below, in the format of
// $auth->addUser( "username", "password" );

$auth->addUser( "admin", "prism" );


// ------------------------------------------
// INTERNAL STUFF (IGNORE)
// ------------------------------------------

error_reporting(E_ALL);
ini_set('display_errors', true);

session_start();

$peregrine = new Peregrine;
$peregrine->init();