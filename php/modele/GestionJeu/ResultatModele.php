<?php

    function inserer_repond($resultat_reponse,$reponse,$id_logo,$id_partie,$connexion) {
        $query = "begin creer_repond(:resultat_reponse,:reponse,:id_logo,:id_partie); end;";

        $stid = oci_parse($connexion, $query);


        var_dump($id_logo);


        // On lie les marqueurs avec les variables
        oci_bind_by_name($stid, ':resultat_reponse', $resultat_reponse);
        oci_bind_by_name($stid, ':reponse', $reponse,255);
        oci_bind_by_name($stid, ':id_logo', $id_logo,255);
        oci_bind_by_name($stid, ':id_partie', $id_partie,255);

        if ( ! oci_execute($stid)){
            // Si le trigger sur l'expérience ne passe pas
            $e = oci_error($stid);
            return $e['message'];
        }
        return 'ok';
    }