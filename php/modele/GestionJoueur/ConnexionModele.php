<?php


function connexion($pseudo,$password,$connexion)
{
    // Taille du pseudo >= 5  et les deux mots de passe se correspondent
    if (isset($pseudo) and isset($password) and strlen($pseudo) > 4 and strlen($password) > 4)
    {
        $query = "SELECT connexion(':pseudo') AS :password FROM dual;";

        // Hashage du mot de passe avant ajout dans la BD
        //$password = hash("sha256",$password);

        // Prépare la requête
        $stid = oci_parse($connexion, $query);


        // On lie les marqueurs avec les variables
        oci_bind_by_name($stid, ':pseudo', $pseudo);
        oci_bind_by_name($stid, ':password', $true_password);

        // Execution de la requête et récupération d'un message d'erreur si erreur
        if ( ! oci_execute($stid)){
            // En cas de soucie sur la requête qui ne s'exécute mal
            oci_close($connexion);
            $e = oci_error($stid);
            echo $e['message'];
            echo "<h2>Une erreur est survenue, merci de réessayer ultérieurement</h2>".'<br />';
            return false;
        } else {
            oci_close($connexion);
            if ($password == $true_password) {
                // Si le mot de passe BD correspond à celui renseigné alors il est connecté
                echo  "<h2>Vous êtes connecté !</h2>".'<br />';
                return true;
            } else {
                // Pas le bon mot de passe renseigné => renvoie à l'accueil
                echo "<h2>Impossible de vous connecter, car nous ne trouvons pas vos identifiants</h2>".'<br />';
                return false;
            }
        }
    } else {
        echo "<h2>Le pseudo et le mot de passe doivent au moins faire 5 caractères...</h2>".'<br />';
        return false;
    }
}

