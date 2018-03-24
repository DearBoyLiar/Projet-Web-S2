<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-ui-1.12.1/jquery-ui.css">
    <title>QUIZZ : Connexion</title>
</head>
<body>
<?php
session_start();
if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
    echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='../vue/deconnexion.php' title='Se déconnecter'>";
    echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";
}
?>
<!-- Script controle saisie -->
<script src='../../js/script_connexion.js'></script>

<script src='../../js/jquery-3.1.1.min.js'></script>
<script src='../../js/jquery-ui-1.12.1/jquery-ui.js'></script>

<div  class="accueil">
    <form method="post" action="../controleur/ConnexionControleur.php" onsubmit="return verifierFormulaire()">
        <h1>Se connecter</h1>
        <div class="msg-erreur" id="err-pseudo"></div>
        <input type="text" placeholder="Pseudo" name="pseudo" onBlur="verifierPseudo()"/>
        <div class="msg-erreur" id="err-pass"></div>
        <input type="password" placeholder="Mot de passe" name="password" onBlur="verifierPass()"/>
        <button>SE CONNECTER</button>
		<a href="inscription_vue.php">Pas encore inscrit ? S'inscrire</a>
    </form>
</div>
</body>
</html>