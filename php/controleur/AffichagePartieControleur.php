<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Partie</title>
</head>
<header>
    <a href="../vue/accueil.php"><img src="../../img/logo.png" alt="LOGO"></a> <!-- Resize l'image-->
    <?php
    session_start();
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
        echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='../vue/deconnexion.php' title='Se déconnecter'>";
        echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";
    }
    ?>
</header>
<body>
<?php

include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/PartieModele.php');
include ('../vue/affiche_logo.php');

$_SESSION['niveau'] = intval($_POST['niveau']); // récupère en session le niveau choisi

// Création de la partie pour le niveau choisi
$id_collection = creer_partie($_SESSION['niveau'],$_SESSION['pseudo'],$dbConn);

if (isset($id_collection)) {
    if (recup_logo($id_collection,$dbConn)) {
        // Affichage des logos
        afficheLogo($_SESSION['logos']);
    }
} else {
    echo "<h2>Ce niveau n'est pas accessible, vous n'avez pas l'experience requise</h2>".'<br />';
    echo "<a href='../vue/menu.php'><h3>Retourner à la page de choix de niveau</h3></a>";

}

?>

</body>

</html>


