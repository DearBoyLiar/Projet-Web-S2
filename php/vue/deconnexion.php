<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-ui-1.12.1/jquery-ui.css">
    <title>QUIZZ : Déconnexion</title>
</head>

<body>
<!-- Script controle saisie -->
<script type="text/javascript" src='../../js/script_inscription.js'></script>

<script type="text/javascript" src='../../js/jquery-3.1.1.min.js'></script>
<script type="text/javascript" src='../../js/jquery-ui-1.12.1/jquery-ui.js'></script>

<?php
session_start();
if (isset($_SESSION['pseudo'])) {
    session_destroy();
    include ('header.php');
    echo "<h2>Vous êtes déconnecté ! </h2>".'<br />';

    echo "<a href='accueil.php'><h3>Retourner à la page d'accueil</h3></a>";

} else {
    echo "<h2>Vous n'avez pas accès à cette page ! </h2>".'<br />';
    echo "<a href='accueil.php'><h3>Retourner à la page d'accueil</h3></a>";
}

?>
</body>
</html>
