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
<body>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/PartieModele.php');
include ('../vue/affichage_parties_rejouees.php');

$_SESSION['niveau'] = intval($_POST['niveau']); // récupère en session le niveau choisi


// Récupération des parties pour ce niveau et le joueur connecté
get_parties($_SESSION['pseudo'],$_SESSION['niveau'],$dbConn);

if (!is_null($_SESSION['parties'][0])) {
    // Affichage des parties (choix de l'utilisateur pour la partie qu'il veut revoir)
    affichage_parties_jouees($_SESSION['parties']);
} else {
    // Aucune partie pour le niveau jouée
    echo "<h2>Aucune partie ne correspond au niveau demandé</h2>";
    echo "<a href='../vue/menu.php'><h3>Retourner au menu</h3></a>";
}

} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='../vue/accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}

?>

</body>

</html>