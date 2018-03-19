<?php
/**
 * Created by PhpStorm.
 * User: l3sid
 * Date: 03/03/18
 * Time: 16:24
 */
session_start();

function getNiveau($connexion) {
    $query = "SELECT * from ZZW2090A.NIVEAU";

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
            array_push($tab_niveaux,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);


        $_SESSION['niveaux'] = $tab_niveaux;
        return true;
    }
}

