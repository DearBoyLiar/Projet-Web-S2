<?php
/**
 * Permet de faire l'affichage du résultat d'une partie et des différents highscore concernant le niveau choisi
 * @param $score
 * @param $statut
 * @param $highscore_minute
 * @param $highscore_hour
 * @param $highscore_global
 */
function affiche_resultat_high_score($score,$statut,$highscore_minute,$highscore_hour,$highscore_global) {
    echo "<div  class='accueil'>";
    echo "<form>";
    echo"<h1>Votre score : </h1>";
    echo "<div id='lescore'>".$score."/10</div>"."<br />";
    echo "<a href='../controleur/ChoixNiveauControleur.php'>";
    if($statut){
        $niveau_up = $_SESSION['niveau']+1;
        echo "Bravo vous avez gagné ! Essayer le niveau ".$niveau_up." qui est plus difficile</a>";
    } else {
        echo "Vous avez perdu ! Rententez votre chance ici</a>";
        echo "<h4>(Il vous faut répondre correctement à ".$_SESSION['min_score']['NB_LOGO_GAGNE'].
            " questions pour passer au niveau suivant)</h4>";
    }
    // Affiche les highscore minute (limité à 5 max)
    if(count($highscore_hour)>5) {
        echo "<h3>Score pour la dernière minute :</h3>";
        affiche_high_score($highscore_minute);
    }

    // Affiche les highscore heure (limité à 5 max)
    if(count($highscore_hour) >1) {
        echo"<h3>Score pour la dernière heure :</h3>";
        affiche_high_score($highscore_hour);
    }

    // Affiche les highscore globaux (limité à 5 max)
    if(count($highscore_global)>1) {
        echo"<h3>Score global :</h3>";
        affiche_high_score($highscore_global);
    }

    echo "</form>";
    echo "</div>";
}

/**
 * Affichage des différents tableaux dde highscore
 * @param $high_score
 */
function affiche_high_score($high_score) {
    echo "<table class='classement'>";
    echo    "<tr>
                <th>PSEUDO</th>
                <th>DATE</th>
                <th>HEURE</th>
                <th>SCORE</th>
             </tr>";
    for($i=0; $i < sizeof($high_score) && $i <5;$i++) {
        echo "<tr>
                <td>".$high_score[$i]['PSEUDO']."</td>
                <td>".$high_score[$i]['DATE_PARTIE']."</td>
                <td>".$high_score[$i]['HOURS'].":".$high_score[$i]['MINUTES']."</td>
                <td>".intval($high_score[$i]['SCORE'])."</td>
             </tr>";
            }
    echo "</table>";
}