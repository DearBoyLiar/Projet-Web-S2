<?php
/**
 * Insertion de la réponse de l'utilisateur dans la table répond en BD
 * @param $resultat_reponse
 * @param $reponse
 * @param $id_logo
 * @param $id_partie
 * @param $connexion
 * @return bool
 */
function inserer_repond($resultat_reponse,$reponse,$id_logo,$id_partie,$connexion) {
    $query = "begin creer_repond(:resultat_reponse,:reponse,:id_logo,:id_partie); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':resultat_reponse', $resultat_reponse);
    oci_bind_by_name($stid, ':reponse', $reponse,255);
    oci_bind_by_name($stid, ':id_logo', $id_logo,255);
    oci_bind_by_name($stid, ':id_partie', $id_partie,255);

    if ( ! oci_execute($stid)){
        // Si erreur
        $e = oci_error($stid);
        echo $e['message'];
    }
    return true;
}
/**
 * Récupération du score minimum pour gagner la partie du niveau demandé
 * @param $niveau
 * @param $connexion
 * @return bool
 */
function get_min_score($niveau,$connexion) {
    $query = "SELECT NB_LOGO_GAGNE FROM NIVEAU WHERE NIVEAU = :niveau";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':niveau', $niveau);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            $min_score = $row;
        }
        oci_free_statement($stid);
        oci_close($connexion);

        // On récupère le minimum de bonne réponse pour ce niveau en session
        $_SESSION['min_score'] = $min_score;
        return true;
    }
}

/**
 * Mise à jour de la partie en cours, du point de vue du score, de son statut
 * Mise à jour également de l'éxpérience de l'utilisateur si ce dernier a gagné le niveau
 * @param $partie
 * @param $statut
 * @param $score
 * @param $pseudo
 * @param $niveau
 * @param $connexion
 * @return bool
 */
function update_partie($partie,$statut,$score,$pseudo,$niveau,$connexion) {
    if ($statut) {
        $statut = 'G';
    } else {
        $statut = 'P';
    }

    $query = "begin update_partie(:id_partie,:statut,:score,:pseudo,:niveau); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':id_partie', $partie);
    oci_bind_by_name($stid, ':statut', $statut);
    oci_bind_by_name($stid, ':score', $score);
    oci_bind_by_name($stid, ':pseudo', $pseudo);
    oci_bind_by_name($stid, ':niveau', $niveau);

    if ( ! oci_execute($stid)){
        // Si erreur
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    }
    return true;
}

/**
 * Récupération de  tous les scores pour ce niveau (en fonction du mode demandé),
 * classés du meilleur score au pire
 * @param $niveau
 * @param $mode
 * @param $connexion
 * @return array
 */
function get_highscore($niveau,$mode,$connexion) {

    // Requête pour les highscore
    $query = 'begin  recup_highscore(:niveau,:mode,:pseudos,:dates,:scores); end;';

    $stid = oci_parse($connexion, $query);

    $pseudos   = oci_new_collection($connexion, 'PSEUDOS','ZZW2090A');
    $dates = oci_new_collection($connexion, 'DATES','ZZW2090A');
    $scores = oci_new_collection($connexion, 'SCORES','ZZW2090A');

    // On lie les marqueurs avec les variables
    if (oci_bind_by_name($stid, ':niveau', $niveau) &
    oci_bind_by_name($stid, ':mode', $mode) &
    oci_bind_by_name($stid, ':pseudos', $pseudos, 5, SQLT_NTY)& // récupération des pseudos
    oci_bind_by_name($stid, ':dates', $dates, 5, SQLT_NTY)&  // récupération des dates
    oci_bind_by_name($stid, ':scores', $scores, 5, SQLT_NTY) // récupération des scores
    ) {
        if ( ! oci_execute($stid)){
            // En cas de soucie sur la requête qui s'exécute mal
            oci_close($connexion);
            $e = oci_error($stid);
            return  $e['message'];
        } else {
            $highscore = array();
            for ($i = 0; $i < 5; $i++) {
                $pseudo   = $pseudos->getElem($i);
                $date = $dates->getElem($i);
                $score = $scores->getElem($i);
                if (!is_bool($pseudo)) {
                    $highscore[$i] = ['PSEUDO' =>$pseudo,'DATE_PARTIE' =>$date,'SCORE' => $score];
                }
            }
            oci_close($connexion);
            return $highscore;
        }
    } else {
      echo 'faux';
    }






}