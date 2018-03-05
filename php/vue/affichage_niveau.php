<?php
/**
 * @param $tab
 */
function afficheNiveau($tab) {
    echo"<div  class='accueil'>";
    echo "<form method='post' action='../controleur/AffichagePartieControleur.php'>";
    echo"<h1>Choisissez votre niveau</h1>";
    echo "<table>";
    foreach($tab as $niveau) {
        // renvoie l'id_collection pour ce niveau lors du choix du niveau
        echo"<tr><td><button type='submit' name='niveau' value='".$niveau['NIVEAU']."'>Niveau"." ".intval($niveau['NIVEAU'])."</button></td></tr>";
    }
    echo "</table>";
    echo "</form>";
    echo"</div>";
}
?>