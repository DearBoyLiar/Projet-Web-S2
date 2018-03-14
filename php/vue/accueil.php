<!DOCTYPE html>
<html lang="fr">
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="../../css/style.css">
		<title>QUIZZ : Accueil</title>
	</head>
    <header>
        <a href="../vue/accueil.php"><img src="../../img/logo.png" alt="LOGO"></a> <!-- Resize l'image-->
    </header>
	<body>
		<div class="wrapper">
			<?php
				if (!isset($_SESSION) || empty($_SESSION['pseudo'])) {  // utilisateur pas connecté => affichage module connexion
					// affichage du module de connexion
					include "connexion_vue.php";
				} else {   // utilisateur connecté => doit choisir un quizz
                    include "menu.php";
				}
			?>
		</div>
	</body>
</html>
