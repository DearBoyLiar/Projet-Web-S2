<?php
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-ui-1.12.1/jquery-ui.css">
    <title>QUIZZ : Choix du niveau</title>
</head>

<body>
<!-- Script controle saisie -->
<script type="text/javascript" src='../../js/script_connexion.js'></script>

<script type="text/javascript" src='../../js/jquery-3.1.1.min.js'></script>
<script type="text/javascript" src='../../js/jquery-ui-1.12.1/jquery-ui.js'></script>

<?php include ('header.php');?>

<div  class="accueil">
    <form method="post" action="../controleur/ChoixNiveauControleur.php">
        <button>Choisir votre niveau</button>
    </form>
</div>
</body>
</html>
