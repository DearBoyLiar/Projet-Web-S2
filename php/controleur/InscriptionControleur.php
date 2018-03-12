<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Inscription</title>
</head>
<header>
    <a href="../vue/accueil.php"><img src="../../img/logo.png" alt="LOGO"></a> <!-- Resize l'image-->
    <?php
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
        echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='../vue/deconnexion.php' title='Se déconnecter'>";
        echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";
    }
    ?>
</header>
<body>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJoueur/InscriptionModele.php');

// Récupère le message renvoyer par la fonction inscrire de la classe InscriptionModele
if(inscrire($_POST['pseudo'],$_POST['password'],$_POST['confirmed_password'],$dbConn))
{
    echo "<a href='../vue/accueil.php'><h3>Se connecter</h3></a>";
} else {
    echo "<a href='../vue/inscription_vue.php'><h3>Retourner à la page d'inscription</h3></a>";
}

?>

</body>
</html>
