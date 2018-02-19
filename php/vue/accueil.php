<!DOCTYPE html>
<html lang="fr">
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="../../css/style.css">
		<title>QUIZZ : Accueil</title>
	</head>
	
	<body>
		<?php
			session_start();

			// Connexion si la variable $_POST contient un pseudo et mdp
			if (isset($_POST) && !empty($_POST['pseudo'])) {
					//if  si le compte existe =>pseudo et mdp alors on ajoute dans la variable session pseudo $_SESSION
					$_SESSION['pseudo'] = $_POST['pseudo'];
					/*} else {
						// avertissement si les données de connexions sont incorrectes
						echo "<script>alert('La connexion a échoué, veuillez re-essayer')</script>";
					}*/
			}
			include "header.php";
		?>
		<div class="wrapper">
			<?php

				if (!isset($_SESSION) || empty($_SESSION['pseudo'])) {  // utilisateur pas connecté => affichage module connexion
					// affichage du module de connexion
					include "connexion_vue.php";
				} else {   // utilisateur connecté => doit choisir un quizz
					
				}
			?>
		</div>
	</body>
</html>
