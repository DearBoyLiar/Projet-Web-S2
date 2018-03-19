<?php
/**
 * @param $tab
 */
function afficheLogoPartieJouee($tab)
{
    echo "<div  class='accueil'>";
    echo "<form method='post' action='../controleur/AffichageResultatControleur.php' onload='compteARebour()' onsubmit='return ValiderReponse()'>";
    echo "<h1>Répondez aux questions, bon courage !</h1>";
    $tab = trieLogo($tab);
    $_SESSION['logos'] = $tab; // Récupère en session les logos choisis
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
    echo "<h4 id='temps' value='".$_SESSION['temps']."'></h4>";
    echo "<div id='compteur'></div>";
    echo "<button id='btn_valider'><img src='../../img/valider_icon.svg' alt='VALIDER'></button>";
    echo "</form>";
    echo "</div>";
}

/**
 * Permet de récupérer que 10 questions en les mélangant
 * @param $tab
 * @return array
 */
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

function afficheLogoPartieChoisie($partie_choisie,$logos_choisis)
{
    echo "<div  class='accueil'>";
    echo "<form action='../vue/menu.php' onsubmit='messageMenu()'>";
    echo "<h1>Voici ce que vous avez répondu</h1>";
    foreach ($partie_choisie as $reponse_logo) {
        if ($reponse_logo['RESULTAT_REPONSE']) {
            $reponse_logo['RESULTAT_REPONSE'] = 'Résultat : VRAI';
        } else {
            $reponse_logo['RESULTAT_REPONSE'] = 'Résultat : FAUX';
        }

        if (is_null($reponse_logo['REPONSE_REPONDUE'])) {
            $reponse_logo['REPONSE_REPONDUE'] = "Vous n''avez pas répondu à cette question";
            $reponse_logo['RESULTAT_REPONSE'] = "";
        } else {
            $reponse_logo['REPONSE_REPONDUE'] = "Votre réponse : ".$reponse_logo['REPONSE_REPONDUE'];
        }
        //var_dump($_SESSION['logos_choisis']);
        echo "<br /><br /><table>
            <tr>
                <img class='logo' src=".$logos_choisis[$reponse_logo['ID_LOGO']].">
            </tr>
            <tr>
                <td><label>".$reponse_logo['REPONSE_REPONDUE']."</label></td><br />
                
            </tr>
            <tr>
                <td><label>" .$reponse_logo['RESULTAT_REPONSE']. "</label></td>
            </tr>";
        echo "</table>";
    }
    echo "<button type='submit' id='btn_valider'><img src='../../img/valider_icon.svg' alt='VALIDER'></button>";
    echo "</form>";
    echo "</div>";
}
?>