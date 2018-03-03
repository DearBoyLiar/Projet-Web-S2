<?php
/**
 * Created by PhpStorm.
 * User: l3sid
 * Date: 03/03/18
 * Time: 16:24
 */
session_start();
function getExperience($pseudo,$connexion) {
    $query = "begin recup_experience(:pseudo,:experience); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':pseudo', $pseudo);
    oci_bind_by_name($stid, ':experience', $experience);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        oci_close($connexion);
        $_SESSION['experience'] = $experience;
        return true;
    }
}

function getNiveau($connexion) {
    $query = "SELECT * from niveau";

    $stid = oci_parse($connexion, $query);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        $tab_niveaux = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($tab_niveaux,$row['NIVEAU']);
        }
        oci_free_statement($_SESSION['niveaux']);
        oci_close($connexion);


        $_SESSION['niveaux'] = $tab_niveaux;
        return true;
    }
}

