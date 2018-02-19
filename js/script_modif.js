/*
 * Vérifie que la chaine passée en paramètre peut correspondre à un pseudo (sup à 5 caractères)
 */
function verifierPseudo() {
    pseudo = document.getElementsByName("pseudo").item(0);

    if (pseudo.value.length < 5 && pseudo.value.length != 0) {
        pseudo.style.backgroundColor = "rgb(255,98,98)";
		    document.getElementById("err-pseudo").innerHTML = "Veuillez entrer un pseudo valide (au moins 5 caractères)";
        return false;
    } else if (pseudo.value.length != 0) {
        pseudo.style.backgroundColor = "rgb(112, 186, 241)";
		    document.getElementById("err-pseudo").innerHTML = "";
    } else {
        pseudo.style.backgroundColor = "";
    }

    return true;
}

/*
 * Vérifie la validité d'une adresse mail
 */
function verifierMail() {
    mail = document.getElementsByName("mail").item(0);

    if ((mail.value.length < 5 || mail.value.indexOf('@') == -1) && mail.value.length != 0) {
        mail.style.backgroundColor = "rgb(255,98,98)";
        confirm_pass.style.backgroundColor = "rgb(255,98,98)";
		    document.getElementById("err-mail").innerHTML = "Le mail est invalide";
        return false;
    } else if (mail.value.length != 0) {
        mail.style.backgroundColor = "rgb(112, 186, 241)";
        document.getElementById("err-mail").innerHTML ="";
    } else {
      mail.style.backgroundColor = "";
    }

    return true;
}

/*
 * Vérificaition du mot de passe et de la confirmation
 */
function verifierPass() {
    pass = document.getElementsByName("motdepasse").item(0);
    confirm_pass = document.getElementsByName("motdepasse_verif").item(0);

    if (   (pass.value.length != 0 || confirm_pass.value.length != 0)
        && (pass.value != confirm_pass.value)) {
        pass.style.backgroundColor = "rgb(255,98,98)";
        confirm_pass.style.backgroundColor = "rgb(255,98,98)";
		    document.getElementById("err-pass").innerHTML = "Veuillez saisir un mot de passe valide (au moins 5 caractères).<br>Vérifiez la correspondance des deux mots de passe";
        return false;
    } else if (pass.value.length != 0 && confirm_pass.value.length != 0 && pass.value == confirm_pass.value) {
        pass.style.backgroundColor = "rgb(112, 186, 241)";
        confirm_pass.style.backgroundColor = "rgb(112, 186, 241)";
		    document.getElementById("err-pass").innerHTML ="";
    } else {
      pass.style.backgroundColor = "";
      confirm_pass.style.backgroundColor = "";
    }

    return true;
}
