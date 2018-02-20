<?php

$dbHost = "telline.univ-tlse3.fr";
$dbHostPort="1521";
$dbServiceName = "etupre";
$usr = "zzw2090a";
$pswd = "Zamelie81!";
$dbConnStr = "(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)
        (HOST=".$dbHost.")(PORT=".$dbHostPort."))
        (CONNECT_DATA=(SERVICE_NAME=".$dbServiceName.")))";

if(!$dbConn = oci_connect($usr,$pswd,$dbConnStr)){
    $err = oci_error();
    trigger_error('Could not establish a connection: ' . $err['message'], E_USER_ERROR);
}

?>
