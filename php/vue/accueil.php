<!DOCTYPE html>
<html lang="fr">
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="../../css/style.css">
		<title>QUIZZ : Accueil</title>
	</head>
	
	<body>
		<?php
        include ('header.php');
			if (isset($_POST) && !empty($_POST['pseudo'])) {
					//if  si le compte existe =>pseudo et mdp alors on ajoute dans la variable session pseudo $_SESSION
					$_SESSION['pseudo'] = $_POST['pseudo'];
			}
		?>
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
