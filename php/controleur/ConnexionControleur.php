<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Connexion</title>
</head>
<header>
    <?php
    session_start();
    echo "<a href='../vue/accueil.php'><img src='../../img/logo.png' alt='LOGO'></a> ";
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
        echo "<div id ='nomuser'>" . $_SESSION['pseudo'] . "<a href='../vue/deconnexion.php' title='Se déconnecter'>";
        echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";
    }
    ?>
</header>
<body>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJoueur/ConnexionModele.php');

// Récupère le message renvoyer par la fonction inscrire de la classe InscriptionModele
if(connexion($_POST['pseudo'],$_POST['password'],$dbConn))
{
    session_start();
    $_SESSION['pseudo'] = $_POST['pseudo'];
    echo "<h2>Vous êtes connecté !</h2><br />
          <a href='../vue/menu.php'><h3>Rejoindre le menu</h3></a>";
} else {
    echo "<a href='../vue/accueil.php'><h3>Retourner à l'accueil</h3></a>";
}


?>

</body>
</html>