<?php

function affichage_parties_jouees($tab) {
    echo"<div  class='accueil'>";
    echo "<form method='post' action='../controleur/AffichagePartieChoisieControleur.php'>";
    echo "<select name='id_partie'>";
    foreach($tab as $partie) {
        //ID_PARTIE,DATE_PARTIE,STATUT,SCORE
        if ($partie['STATUT'] == 'G') {
            $partie['STATUT'] = 'Gagnée';
        } else {
            $partie['STATUT'] = 'Perdue';
        }
        echo "<option value=".$partie['ID_PARTIE'].">Partie du : ".$partie['DATE_PARTIE']." Résultat : ".$partie['STATUT']." Score : ".$partie['SCORE']."</option>";

    }
    echo "</select>";
    echo "<button>VALIDER</button>";
    echo "</form>";
    echo"</div>";
}