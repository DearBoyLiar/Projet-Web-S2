<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-ui-1.12.1/jquery-ui.css">
    <title>QUIZZ : Inscription</title>
</head>

<body>
<!-- Script controle saisie -->
<script type="text/javascript" src='../../js/script_inscription.js'></script>

<script type="text/javascript" src='../../js/jquery-3.1.1.min.js'></script>
<script type="text/javascript" src='../../js/jquery-ui-1.12.1/jquery-ui.js'></script>
<script>
    $(function(){
        $("#datepicker").datepicker({
            dateFormat: 'dd/mm/yy'
        });
    });
</script>

<div  class="accueil">
    <form method="post" action="../controleur/ConnexionControleur.php" onsubmit="return verifierFormulaire()">
        <h1>Se connecter</h1>
        <div class="msg-erreur" id="err-pseudo"></div>
        <input type="text" placeholder="Pseudo" name="pseudo" onBlur="verifierPseudo()"/>
        <div class="msg-erreur" id="err-pass"></div>
        <input type="password" placeholder="Mot de passe" name="password"/>
        <button>SE CONNECTER</button>
		<a href="inscription_vue.php">Pas encore inscrit ? S'inscrire</a>
    </form>

</div> 
</body>
</html>