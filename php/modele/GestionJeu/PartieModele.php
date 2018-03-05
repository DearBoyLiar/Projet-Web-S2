<?php

// Création de la partie
function creer_partie($niveau,$pseudo,$connexion) {
    $query = "begin creer_partie(:niveau,:pseudo,:id_collection,:id_partie); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':pseudo', $pseudo,255);
    oci_bind_by_name($stid, ':niveau', $niveau,255);
    oci_bind_by_name($stid, ':id_collection', $id_collection,255);
    oci_bind_by_name($stid, ':id_partie', $id_partie,255);

    if ( ! oci_execute($stid)){
        $e = oci_error($stid);
        echo $e['message'];        // Si le trigger sur l'expérience ne passe pas
        return NULL;
    }
    oci_close($connexion);
    $_SESSION['partie'] = $id_partie; // récupération de l'id_partie
    return $id_collection;
}


// Récupération de 10 logos (au hasard) appartenant à cette collection
function recup_logo($collection,$connexion) {

    $query = "SELECT ID_LOGO,LIEN_LOGO,REPONSE FROM LOGO WHERE ID_COLLECTION ='".$collection."'";

    $stid = oci_parse($connexion, $query);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        $tab_logo = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($tab_logo,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);


        $_SESSION['logos'] = $tab_logo;
        return true;
    }

}