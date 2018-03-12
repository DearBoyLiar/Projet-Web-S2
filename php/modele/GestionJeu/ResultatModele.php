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
    $period = 1; // correspond à la période que l'on retire à la date en fonction du mode choisi
    if ($mode == 'min') {
        // Requête pour les highscore_minute
        $query = "SELECT PSEUDO,DATE_PARTIE,extract(HOUR from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS') as timestamp)) as HOURS,extract(minute from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS')as timestamp)) as MINUTES,SCORE FROM PARTIE WHERE NIVEAU = :niveau AND DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '".$period."' minute) ORDER BY SCORE DESC";
    } else if ($mode == 'hour') {
        // Requête pour les highscore_hour
        $query = "SELECT PSEUDO,DATE_PARTIE,extract(HOUR from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS') as timestamp)) as HOURS,extract(minute from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS')as timestamp)) as MINUTES,SCORE FROM PARTIE WHERE NIVEAU = :niveau AND DATE_PARTIE >= (CURRENT_TIMESTAMP - interval '".$period."' hour ) ORDER BY SCORE DESC";
    } else {
        // Requête pour les highscore_global
        $query = "SELECT PSEUDO,DATE_PARTIE,extract(HOUR from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS') as timestamp)) as HOURS,extract(minute from cast(to_char(DATE_PARTIE, 'DD-MON-YYYY HH24:MI:SS')as timestamp)) as MINUTES,SCORE FROM PARTIE WHERE NIVEAU = :niveau ORDER BY SCORE DESC";
    }

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':niveau', $niveau);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        return  $e['message'];
    } else {
        $high_score = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($high_score,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);

        return $high_score;
    }

}