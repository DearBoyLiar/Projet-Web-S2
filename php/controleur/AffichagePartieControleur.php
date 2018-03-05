<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Choix Niveau</title>
</head>
<header>
    <a href='../vue/accueil.php'><img src='../../img/logo.png' alt='LOGO'></a>
</header>
<body>
<?php
session_start();
include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/PartieModele.php');
include ('../vue/affiche_logo.php');

// Création de la partie pour le niveau choisi
$id_collection = creer_partie(intval($_POST['niveau']),$_SESSION['pseudo'],$dbConn);

if (isset($id_collection)) {
    if (recup_logo($id_collection,$dbConn)) {
        // Affichage des logos
        afficheLogo($_SESSION['logos']);
    }
} else {
    echo "<h2>Ce niveau n'est pas accessible, vous n'avez pas l'experience requise</h2>".'<br />';
    echo "<a href='../vue/choix_niveau.php'><h3>Retourner à la page de choix de niveau</h3></a>";

}



