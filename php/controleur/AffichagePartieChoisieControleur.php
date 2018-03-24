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
<script src='../../js/script_partie_choisie.js'></script>
<?php

include('../modele/GestionBD/GestionBD.php');
include('../modele/GestionJeu/PartieModele.php');
include('../vue/affichage_logo.php');

// Récupération des réponses_repondus et des resultat réponses pour la partie selectionnée
if (get_reponse_partie_choisie($_POST['id_partie'], $dbConn)) {

    foreach ($_SESSION['partie_choisie'] as $logo) {
        recup_logos_choisis($logo['ID_LOGO'], $dbConn);
    }
    // Affichage de la partie jouée
    afficheLogoPartieChoisie($_SESSION['partie_choisie'], $_SESSION['logos_choisis']);
}

} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='../vue/accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}



?>

</body>

</html>