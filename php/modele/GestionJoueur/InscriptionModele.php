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
        $query = 'begin ZZW2090A.inscription(:pseudo, :password); end;';

        // Prépare la requête
        $stid = oci_parse($connexion, $query);

        // On lie les marqueurs avec les variables
        oci_bind_by_name($stid, ':pseudo', $pseudo);
        oci_bind_by_name($stid, ':password', $password);

        // Execution de la requête et récupération d'un message d'erreur si erreur
        if ( ! oci_execute($stid) ){
            oci_close($connexion);
            echo "<h2>Un compte avec ce pseudo existe déjà, merci d'en choisir un autre</h2>".'<br />';
            return false;
        } else {
            oci_close($connexion);
            echo  "<h2>Bienvenue dans le jeu du Quizz des Logos ! </h2>".'<br />';
            return true;
        }

    } else {
        include ('../../vue/inscription_vue.php');
        return  "Le pseudo doit comporter au moins 5 caractères et les champs mots de passe doivent se correspondre";
    }
}

?>
