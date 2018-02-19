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

<?php include ('header.php');?>

<div class="inscription accueil">
    <form method="post" action="../controleur/InscriptionControleur.php" onsubmit="return verifierFormulaire()">
        <h1>S'inscrire</h1>
        <div class="msg-erreur" id="err-pseudo"></div>
        <input type="text" placeholder="Pseudo" name="pseudo" onBlur="verifierPseudo()"/>
        <div class="msg-erreur" id="err-pass"></div>
        <input type="password" placeholder="Mot de passe" name="password"/>
        <input type="password" placeholder="Confirmation du mot de passe" name="confirmed_password" onBlur="verifierPass()"/>
        <button>S'INSCRIRE</button>

    </form>

</div>
</body>
</html>
