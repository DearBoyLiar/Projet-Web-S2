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

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/ChoixNiveauModele.php');
include ('../vue/affichage_niveau.php');

// récupère le niveau d'expérience du joueur connecté
if(getExperience($_SESSION['pseudo'],$dbConn))
{
    // On récupère tout les niveaux
    if(getNiveau($dbConn)) {
        // Affiche les niveaux en fonction ede l'expérience de l'utilisateur
        afficheNiveau($_SESSION['niveaux']);
    } else {
        echo 'non';
    }
} else {
    echo 'non';
}
?>

</body>
</html>