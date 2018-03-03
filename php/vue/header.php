<!-- LOGO + nom utilisateur + bouton déconnexion -->

<header>
	<a href="accueil.php"><img src="../../img/logo.png" alt="LOGO"></a>
	<?php
		if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
			echo "<div id ='nomuser'>".$_SESSION['pseudo']."<a href='deconnexion.php' title='Se déconnecter'></div>";
			echo "<img src='img/logout.png' alt='deconnexion'></a></div>";
		}
	?>
</header>