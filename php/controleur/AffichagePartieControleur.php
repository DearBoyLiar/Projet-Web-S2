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

// $_SESSION['niveau_choisi'] = $_POST['niveau'] => correspond au niveau choisi par l'utilisateur;
$_SESSION['niveau_choisi'] = $_POST['niveau'];
