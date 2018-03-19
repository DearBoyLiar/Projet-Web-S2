
function rebour() {
    if (document.getElementById('compteur').innerHTML > 0 ) {
        document.getElementById('compteur').innerHTML = document.getElementById('compteur').innerHTML -1;
    } else {
        confirm('Le temps est écoulé ! ');
        this.validation_partie.submit();
        clear(setInterval());
    }
}
