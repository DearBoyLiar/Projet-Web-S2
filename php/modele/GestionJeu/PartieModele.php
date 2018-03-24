<?php

// Création de la partie
function creer_partie($niveau,$pseudo,$connexion) {
    $query = "begin ZZW2090A.creer_partie(:niveau,:pseudo,:id_collection,:id_partie,:temps,:retour); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':pseudo', $pseudo,255);
    oci_bind_by_name($stid, ':niveau', $niveau,255);
    oci_bind_by_name($stid, ':id_collection', $id_collection,255);
    oci_bind_by_name($stid, ':id_partie', $id_partie,255);
    oci_bind_by_name($stid, ':temps', $temps,255);
    oci_bind_by_name($stid, ':retour', $retour,255);

    oci_execute($stid);
    oci_close($connexion);

    if ($retour == 0) {
        // Si aucun trigger ne se déclenche
        $_SESSION['id_partie'] = $id_partie; // récupération de l'id_partie
        $_SESSION['temps'] = $temps;
        return intval($id_collection);
    } else {
        // Si le trigger sur l'expérience ou le celui du blocage de partie ne passe pas
        return intval($retour);
    }
}


// Récupération de 10 logos (au hasard) appartenant à cette collection
function recup_logo($collection,$connexion) {

    $query = "SELECT ID_LOGO,LIEN_LOGO,REPONSE FROM ZZW2090A.LOGO WHERE ID_COLLECTION ='".$collection."'";

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

function get_parties($pseudo,$niveau,$connexion) {
    $query = "SELECT ID_PARTIE,DATE_PARTIE,STATUT,SCORE FROM ZZW2090A.PARTIE WHERE PSEUDO = '".$pseudo."' AND NIVEAU ='".$niveau."' ORDER BY ID_PARTIE DESC";

    $stid = oci_parse($connexion, $query);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        $tab_parties = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($tab_parties,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);

        $_SESSION['parties'] = $tab_parties;
        return true;
    }
}

function get_reponse_partie_choisie($id_partie,$connexion) {
    $query = "SELECT ID_LOGO,RESULTAT_REPONSE,REPONSE_REPONDUE FROM ZZW2090A.REPOND WHERE ID_PARTIE = '".$id_partie."' ORDER BY DATE_REPONSE ASC";

    $stid = oci_parse($connexion, $query);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        $tab_partie_choisie = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($tab_partie_choisie,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);

        $_SESSION['partie_choisie'] = $tab_partie_choisie;
        return true;
    }
}

function recup_logos_choisis($id_logo,$connexion) {
    $query = "SELECT LIEN_LOGO FROM ZZW2090A.LOGO WHERE ID_LOGO = '".$id_logo."'";

    $stid = oci_parse($connexion, $query);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui ne s'exécute mal
        oci_close($connexion);
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
        return false;
    } else {
        $tab_logo_choisi = array();
        while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
            array_push($tab_logo_choisi,$row);
        }
        oci_free_statement($stid);
        oci_close($connexion);

        $_SESSION['logos_choisis'][$id_logo] = $tab_logo_choisi[0]['LIEN_LOGO'];
        return true;
    }
}