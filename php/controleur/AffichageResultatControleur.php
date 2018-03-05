<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Résultat</title>
</head>
<header>
    <a href='../vue/accueil.php'><img src='../../img/logo.png' alt='LOGO'></a>
</header>
<body>
<?php
session_start();
include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/ResultatModele.php');
//include ('../vue/affiche_resultat.php');

// $_SESSION['logos'], $_POST ['ID_LOGO'], $_SESSION['id_partie']

// comparatif réponse donnée, vrai réponse
// insertion dans la table réponse, avec booléen résultat à la bonne valeur

// afficher le résultat


foreach($_SESSION['logos'] as $logo) {
    $resultat_reponse = $_POST[$logo['ID_LOGO']] == $logo['REPONSE'] ? 1 : 0;
    echo inserer_repond($resultat_reponse,$_POST[$logo['ID_LOGO']],intval($logo['ID_LOGO']),intval($_SESSION['id_partie']),$dbConn);
}
?>



