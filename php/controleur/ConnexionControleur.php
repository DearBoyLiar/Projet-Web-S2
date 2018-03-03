<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Connexion</title>
</head>
<header>
    <a href='../vue/accueil.php'><img src='../../img/logo.png' alt='LOGO'></a>
</header>
<body>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJoueur/ConnexionModele.php');

// Récupère le message renvoyer par la fonction inscrire de la classe InscriptionModele
if(connexion($_POST['pseudo'],$_POST['password'],$dbConn))
{
    echo "<a href='../vue/choix_niveau.php'><h3>Page du choix du niveau</h3></a>";;
} else {
    echo "<a href='../vue/accueil.php'><h3>Retourner à l'accueil</h3></a>";
}

?>

</body>
</html>