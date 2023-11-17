
function ocultarVentana(elementId) {
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "none";
  }

function mostrarVentana(elementId) 
{ 
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "flex";
}

function alterarInterfaz(selectorVar, totalFlashcards)
{
  const selector = document.getElementById(selectorVar);
  if (selector.options[selector.selectedIndex].text == "CREAR UN NUEVO MAZO...")
    {

      var ventanaEmergente = document.getElementById("newDeckWindow");
      ventanaEmergente.style.display = "flex";

    }
  else
  {

    console.log(totalFlashcards);

    var nombreMazo = document.getElementById("nombreMazo");
    var numeroTarjetas = document.getElementById("numeroTarjetas");
    var fechaEstudio = document.getElementById("dateText");

    nombreMazo.textContent = selector.options[selector.selectedIndex].text;

    var contador = 0;
    for (var i = 0; i < totalFlashcards.length; i++)
    {

        if (totalFlashcards[i][0] == nombreMazo.textContent)
        {
          contador ++;
        }

    }

    numeroTarjetas.textContent = contador + " Tarjetas";

    contador = 0;
    for (var i = 0; i < totalFlashcards.length; i++)
    {

        if (totalFlashcards[i][0] == nombreMazo.textContent)
        {
          contador = i;
        }

    }

    if (totalFlashcards[contador][3]== 0)
    {

        fechaEstudio.textContent = "Nunca"

    }
    else
    {

        fechaEstudio.textContent = totalFlashcards[0][3] + "/" + totalFlashcards[0][4] + "/" + totalFlashcards[0][5] 

    }

  }

}
