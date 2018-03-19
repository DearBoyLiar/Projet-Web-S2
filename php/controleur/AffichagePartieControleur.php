<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Partie</title>
</head>
<header>
    <?php
    session_start();
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
    echo "<a href='../vue/menu.php'><img src='../../img/logo.png' alt='LOGO'></a> ";
    echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='../vue/deconnexion.php' title='Se déconnecter'>";
    echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";

    ?>
</header>
<body">
<script type="text/javascript" src='../../js/script_partie_jouee.js'></script>
<script type="text/javascript" src='../../js/script_rebours.js'></script>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/PartieModele.php');
include('../vue/affichage_logo.php');

$_SESSION['niveau'] = intval($_POST['niveau']); // récupère en session le niveau choisi

// Création de la partie pour le niveau choisi
$id_collection = creer_partie($_SESSION['niveau'],$_SESSION['pseudo'],$dbConn);

if (isset($id_collection)) {
    if (recup_logo($id_collection,$dbConn)) {
        // Affichage des logos
        $temps = $_SESSION['temps'];
        $_SESSION['temps'] = NULL;
        afficheLogoPartieJouee($_SESSION['logos'],$temps);
    }
} else {
    echo "<h2>Ce niveau n'est pas accessible, vous n'avez pas l'experience requise</h2>".'<br />';
    echo "<a href='../vue/menu.php'><h3>Retourner au menu</h3></a>";

}
} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='../vue/accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}

?>

</body>

</html>


