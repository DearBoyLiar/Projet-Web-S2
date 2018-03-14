<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Choix Niveau</title>
</head>
<header>
    <?php
    session_start();
    $_SESSION['choix'] = $_POST['choix'];
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
    echo "<a href='../vue/menu.php'><img src='../../img/logo.png' alt='LOGO'></a> ";
    echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='../vue/deconnexion.php' title='Se déconnecter'>";
    echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";

    ?>
</header>
<body>
<?php
include ('../modele/GestionBD/GestionBD.php');
include ('../modele/GestionJeu/ChoixNiveauModele.php');
include ('../vue/affichage_niveau.php');

// On récupère tout les niveaux
if(getNiveau($dbConn)) {
    // Affiche les niveaux en fonction ede l'expérience de l'utilisateur
    afficheNiveau($_SESSION['niveaux']);
} else {
    echo 'On ne peut récupérer les niveaux, merci de réessayer ultérieurement';
}

} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='../vue/accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}
?>
</body>
</html>