function compteARebour()  {
    var temps = document.getElementById('temps');

    while(temps.value > 0) {
        setInterval(temps--, 1000);
        document.getElementById("compteur").innerHTML = temps.value;
    }
}
