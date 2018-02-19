<!-- LOGO + nom utilisateur + bouton déconnexion -->

<header>
	<a href="accueil.php"><img src="../../img/logo.png" alt="LOGO"></a>
	<?php
		if (isset($_SESSION) && !empty($_SESSION['pseudo'])) {
			echo "<a href='monprofil.php'><div id ='nomuser'>".$_SESSION['pseudo']."</a><a href='deconnexion.php' title='Se déconnecter'>";
			echo "<img src='img/logout.png' alt='deconnexion'></a></div>";
		}
	?>
</header>