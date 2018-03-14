<?php

function affichage_parties_jouees($tab) {
    echo"<div  class='accueil'>";
    echo "<form method='post' action='../controleur/AffichagePartieChoisieControleur.php'>";
    echo "<table>";
    foreach($tab as $partie) {
        //ID_PARTIE,DATE_PARTIE,STATUT,SCORE
        if ($partie['STATUT'] == 'G') {
            $partie['STATUT'] = 'Gagnée';
        } else {
            $partie['STATUT'] = 'Perdue';
        }
        echo"<tr>
               <td> <button type='submit'>Partie du : ".$partie['DATE_PARTIE']."<br /> 
                <label>Résultat : ".$partie['STATUT']."</label><br /> 
                <label>Score : ".$partie['SCORE']."</label></td></button>
                <td><input type='hidden' name='id_partie' value=".$partie['ID_PARTIE']."></td>
             </tr>";
    }
    echo "</table>";
    echo "</form>";
    echo"</div>";
}