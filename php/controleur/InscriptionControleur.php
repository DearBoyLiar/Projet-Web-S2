<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Inscription</title>
</head>

<body>
<?php

include ('..\vue\header.php');
include ('..\modele\GestionBD\GestionBD.php');
include ('..\modele\GestionJoueur\InscriptionModele.php');

// Récupère le message renvoyer par la fonction inscrire de la classe InscriptionModele
return inscrire($_POST['pseudo'],$_POST['password'],$_POST['confirmed_password'],$dbConn);

?>

</body>
</html>
