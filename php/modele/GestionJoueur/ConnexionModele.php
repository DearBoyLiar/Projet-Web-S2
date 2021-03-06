<?php


function connexion($pseudo,$password,$connexion)
{
    // Taille du pseudo >= 5  et les deux mots de passe se correspondent
    if (isset($pseudo) and isset($password) and strlen($pseudo) > 4 and strlen($password) > 4)
    {
        $query = "begin ZZW2090A.connexion(:pseudo,:password); end;";

        // Hashage du mot de passe avant ajout dans la BD
        $password = hash("sha256",$password);

        // Prépare la requête
        $stid = oci_parse($connexion, $query);


        // On lie les marqueurs avec les variables
        oci_bind_by_name($stid, ':pseudo', $pseudo);
        oci_bind_by_name($stid, ':password', $true_password,255);

        // Execution de la requête et récupération d'un message d'erreur si erreur
        if ( ! oci_execute($stid)){
            // En cas de soucie sur la requête qui s'exécute mal
            oci_close($connexion);
            echo "<h2>Impossible de vous connecter, car nous ne trouvons pas vos identifiants</h2>".'<br />';
            return false;
        } else {
            oci_close($connexion);
            if ($password == $true_password) {
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

