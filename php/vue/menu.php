<?php
session_start();
?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" type="text/css" href="../../css/style.css">
    <link rel="stylesheet" type="text/css" href="../../js/jquery-ui-1.12.1/jquery-ui.css">
    <title>QUIZZ : Menu</title>
</head>
<header>
    <?php
    session_start();
    if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
        echo "<a href='../vue/menu.php'><img src='../../img/logo.png' alt='LOGO'></a> ";
        echo "<div id ='nomuser'>" . $_SESSION['pseudo'] . "<a href='../vue/deconnexion.php' title='Se déconnecter'>";
        echo "<img src='../../img/logout.png' alt='deconnexion'></a></div>";
    }
    ?>
</header>
<body>
<!-- Script controle saisie -->
<script type="text/javascript" src='../../js/script_connexion.js'></script>

<script type="text/javascript" src='../../js/jquery-3.1.1.min.js'></script>
<script type="text/javascript" src='../../js/jquery-ui-1.12.1/jquery-ui.js'></script>

<div  class="accueil">
    <form method="post" action="../controleur/ChoixNiveauControleur.php">
        <button name="choix" value=0>Choisir votre niveau</button>
        <br />
        <button name="choix" value=1>Voir vos parties jouées</button>
    </form>
</div>
</body>
</html>
