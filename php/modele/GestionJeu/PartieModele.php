<?php

// Création de la partie
function creer_partie($niveau,$pseudo,$connexion) {
    $query = "begin creer_partie(:niveau,:pseudo); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':pseudo', $pseudo);
    oci_bind_by_name($stid, ':niveau', $niveau);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui s'exécute mal
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
    }
    oci_close($connexion);
}

// Récupération de la collection
function recup_collection($niveau,$connexion) {

    // récuupère les logos
}

// Récupération de 10 logos (au hasard) appartenant à cette collection
function recup_logo($collection,$connexion) {

    $query = "select id_logo,lien_logo,reponse(:collection); end;";

    $stid = oci_parse($connexion, $query);

    // On lie les marqueurs avec les variables
    oci_bind_by_name($stid, ':collection', $collection);

    if ( ! oci_execute($stid)){
        // En cas de soucie sur la requête qui s'exécute mal
        $e = oci_error($stid);
        echo $e['message'];
        echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
    }
    oci_close($connexion);

}