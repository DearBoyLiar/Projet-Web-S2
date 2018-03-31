<?php
/**
 * @param $tab
 */
function afficheNiveau($tab) {
    echo"<div  class='accueil'>";
    // Joueur veut jouer ne partie
    if ($_SESSION['choix'] == 0) {
        echo "<form method='post' action='../controleur/AffichagePartieControleur.php'>";
        echo"<h1>Choisissez votre niveau</h1>";

    } else { // Joueur sohaite rejouer ses parties
        echo "<form method='post' action='../controleur/AffichagePartiesJoueesControleur.php'>";
        echo"<h1>Choisissez le niveau pour voir vos parties jouées sur ce dernier</h1>";
    }
    echo "<table>";
    foreach($tab as $niveau) {
        // renvoie le niveau lors du choix du niveau
        echo"<tr><td><button type='submit' name='niveau' value='".$niveau['NIVEAU']."'>Niveau"." ".intval($niveau['NIVEAU'])."</button></td></tr>";
    }
    echo "</table>";
    echo "</form>";
    echo"</div>";
}
?>