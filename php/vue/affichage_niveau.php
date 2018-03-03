<?php
/**
 * @param $tab
 */
function afficheNiveau($tab) {
    echo "<form method='post' action='../controleur/AffichagePartieControleur.php'>";
    echo "<table>";
    foreach($tab as $ligne) {
        if ($ligne > $_SESSION['experience']) {
            echo"<tr><button type='submit' disabled>Niveau '".$ligne."'</button></tr>";
        } else {
            echo"<tr><button type='submit' name='niveau' value='".$ligne."'>Niveau'".$ligne."'</button></tr>";
        }
    }
    echo "</table>";
    echo "</form>";
}
?>