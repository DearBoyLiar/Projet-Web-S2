/*
 * Vérifie que la chaine passée en paramètre peut correspondre à un pseudo (sup à 5 caractères)
 */
function verifierPseudo() {
    pseudo = document.getElementsByName("pseudo").item(0);

    if (pseudo.value.length < 5) {
        pseudo.style.backgroundColor = "rgb(255,98,98)";
		document.getElementById("err-pseudo").innerHTML = "Veuillez entrer un pseudo valide (au moins 5 caractères)";
        return false;
    } else {
        pseudo.style.backgroundColor = "rgb(112, 186, 241)";
		document.getElementById("err-pseudo").innerHTML = "";
    }

    return true;
}

/*
 * Vérificaition du mot de passe et de la confirmation
 */
function verifierPass() {
    pass = document.getElementsByName("password").item(0);
    confirm_pass = document.getElementsByName("confirmed_password").item(0);

    if (pass.value.length < 5 || (pass.value != confirm_pass.value)) {
        pass.style.backgroundColor = "rgb(255,98,98)";
        confirm_pass.style.backgroundColor = "rgb(255,98,98)";
		document.getElementById("err-pass")
		        .innerHTML = "Veuillez saisir un mot de passe valide (au moins 5 caractères).<br>Vérifiez la correspondance des deux mots de passe";
        return false;
    } else {
        pass.style.backgroundColor = "rgb(112, 186, 241)";
        confirm_pass.style.backgroundColor = "rgb(112, 186, 241)";
		document.getElementById("err-pass")
		        .innerHTML ="";
    }
    return true;
}

function verifierFormulaire() {
    return (verifierPseudo() && verifierPass());
}
