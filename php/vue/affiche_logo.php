<?php
/**
 * @param $tab
 */
function afficheLogo($tab)
{
    echo "<div  class='accueil'>";
    echo "<form method='post' action='../controleur/AffichageResultatControleur.php'>";
    echo "<h1>Répondez aux questions, bon courage !</h1>";
    $tab = trieLogo($tab);
    foreach ($tab as $logo) {
        echo "<table>";
        // renvoie l'id_collection pour ce niveau lors du choix du niveau
        echo "
            <tr>
                <img class='logo' src='" . $logo['LIEN_LOGO'] . "'</img>
            </tr>
            <br />
            <tr>
                <label>" . str_shuffle($logo['REPONSE']) . "</label>
            </tr>
            <tr>
                <input type='text' placeholder='Votre réponse' name='" . $logo['ID_LOGO'] . "'>
            </tr>";
        echo "</table>";
    }
    echo "<button><VALIDER</button>"; // VOIR POUR L'AFFICHER
    echo "</form>";
    echo "</div>";
}

function trieLogo($tab){
    $array = array();
    shuffle($tab);
    $i=0 ;
    while ($i <10) {
        array_push($array,$tab[$i]);
        $i++;
    }
    return $array;
}
?>