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

        if ($niveau['NIVEAU'] > $_SESSION['experience']) {
            echo"<tr><td><button type='submit' disabled>Niveau ".intval($niveau['NIVEAU'])."</button></td></tr>";
        } else {
            echo"<tr><td><button type='submit' name='niveau' value=".$niveau.">Niveau".intval($niveau['NIVEAU'])."</button></td></tr>";
        }
    }
    echo "</table>";
    echo "</form>";
    echo"</div>";
}
?>