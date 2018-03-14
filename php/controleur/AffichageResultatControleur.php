<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <title>QUIZZ : Résultat</title>
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
include ('../modele/GestionJeu/ResultatModele.php');
include ('../vue/affichage_resultat.php');

// variable du score de l'utilisateur, initialisée à 0
$score = 0;


/**
 * TROUVER SOLUTION POUR ACTUALISATION DE PAGE
 */
foreach($_SESSION['logos'] as $logo) {

    // pour chaque logo, comparatif réponse donnée et la vrai réponse
    $resultat_reponse = strtoupper($_POST[$logo['ID_LOGO']]) == strtoupper($logo['REPONSE']) ? 1 : 0;

    // On ajoute plus 1 au score si resultat_reponse est true (1)
    if ($resultat_reponse) {
        $score++;
    }

    // insertion dans la table réponse, avec booléen résultat à la bonne valeur
    inserer_repond($resultat_reponse,strtoupper($_POST[$logo['ID_LOGO']]),intval($logo['ID_LOGO']),intval($_SESSION['id_partie']),$dbConn);
}

// On récupère le minimum du score que le joueur doit faire pour gagner la partie pour le niveau choisi
get_min_score($_SESSION['niveau'],$dbConn);
$min_score = $_SESSION['min_score'];

// On met à jour la table partie en fonction du score et donc du résultat de cette partie (gagné ou perdu)
if ($score >=$min_score['NB_LOGO_GAGNE']) {
    // Si partie gagné
    $statut= true;
    update_partie(intval($_SESSION['id_partie']),$statut,$score,$_SESSION['pseudo'],$_SESSION['niveau'],$dbConn);
} else {
    // Si partie perdu
    $statut= false;
    update_partie(intval($_SESSION['id_partie']),$statut,$score,$_SESSION['pseudo'],$_SESSION['niveau'],$dbConn);
}


// Récupération des highscore pour la minute
$highscore_minute = get_highscore(intval($_SESSION['niveau']),0,$dbConn);


// Récupération des highscore pour l'heure
$highscore_hour = get_highscore(intval($_SESSION['niveau']),1,$dbConn);

// Récupération des highscore global
$highscore_global = get_highscore(intval($_SESSION['niveau']),2,$dbConn);


// Afficher le résultat de la partie, ainsi que les high_score
affiche_resultat_high_score($score,$statut,$highscore_minute,$highscore_hour,$highscore_global);

} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='../vue/accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}
?>

</body>
</html>

