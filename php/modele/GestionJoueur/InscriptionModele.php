<?php

/**
 * Permet de faire appel à un procédure inscription dans la base de données
 * qui s'occupe de faire l'ajout du nouveau joueur
 * @param $pseudo
 * @param $password
 * @return string
 */
function inscrire($pseudo,$password,$confirmed_password,$connexion)
{
    // Taille du pseudo >= 5  et les deux mots de passe se correspondent
    if (isset($pseudo) and isset($password) and isset($confirmed_password)
        and strlen($pseudo) > 4 and $password == $confirmed_password)
    {
        // Hashage du mot de passe avant ajout dans la BD
        $password = hash("sha256",$password);

        // Requête appelant la procédure
        $query = 'begin inscription(:pseudo, :password); end;';

        // Prépare la requête
        $stid = oci_parse($connexion, $query);

        // On lie les marqueurs avec les variables
        oci_bind_by_name($stid, ':pseudo', $pseudo);
        oci_bind_by_name($stid, ':password', $password);

        // Execution de la requête et récupération d'un message d'erreur si erreur
        if (!oci_execute($stid)) {
            $e = oci_error($stid);
            return $e['message'];
        }
        oci_close($connexion);
        return "Bienvenue dans le jeu du Quizz des Logos ! ";
    } else {
        return "Le pseudo doit comporter au moins 5 caractères et les champs mots de passe doivent se correspondre";
    }
}

?>
