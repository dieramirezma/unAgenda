
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

    var borrarTitulo = document.getElementById("title");
    var borrarContenedor = document.getElementById("editDeckForm2");
    var borrarBoton = document.getElementById("editButtonAccept");
    var divEnBlanco = document.getElementById("editDeckForm");


    borrarTitulo.parentNode.removeChild(borrarTitulo);
    borrarContenedor.parentNode.removeChild(borrarContenedor);
    borrarBoton.parentNode.removeChild(borrarBoton);
    

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

        fechaEstudio.textContent = totalFlashcards[contador][3] + "/" + totalFlashcards[contador][4] + "/" + totalFlashcards[contador][5] 

    }

    cargarTarjetas(totalFlashcards);

  }

}

function cargarTarjetas(totalFlashcards)
{

  var editDeckForm = document.getElementById("editDeckForm");
  var nombreMazo = document.getElementById("nombreMazo");

  var title = document.createElement("h1");
  title.textContent = "Editar Mazo";
  title.id = "title"
  editDeckForm.appendChild(title);

  var editDeckForm2 = document.createElement("div");
  editDeckForm2.className = "editDeckForm2";
  editDeckForm2.id = "editDeckForm2";
  editDeckForm.appendChild(editDeckForm2);

  for (var i = 0; i < totalFlashcards.length; i++)
  {

    var subDiv = document.createElement("div");

    var subtitle = document.createElement("h3");
    var editButton = document.createElement("button");
    editButton.textContent = "EDITAR";
    
    

    subtitle.className = "subtitle";
    editButton.className = "editButton";
    subDiv.className = "subDiv";

    var deleteButton = document.createElement("button");
    deleteButton.textContent = "ELIMINAR";
    deleteButton.className = "deleteButton";


    if (totalFlashcards[i][0] == nombreMazo.textContent)
    {
      

      subtitle.textContent = totalFlashcards[i][1];
      deleteButton.id = i + "edit";
      subtitle.id = i + "editsubtitle";

      

      deleteButton.addEventListener("click", function () 
      {
        var preguntaText = document.getElementById(this.id + "subtitle").textContent;
        window.location.href = "/deleteFlashcard?nombreMazo=" + nombreMazo.textContent + "&pregunta=" + preguntaText;
        
      });
      
      subDiv.appendChild(subtitle);
      subDiv.appendChild(editButton);
      subDiv.appendChild(deleteButton);

      editDeckForm2.appendChild(subDiv);

    }

    

  }

  var gobackButton = document.createElement("button");
  gobackButton.id = "editButtonAccept";
  gobackButton.textContent = "VOLVER";
  gobackButton.addEventListener("click", function()
  {

    var ventanaEmergente = document.getElementById("editDeckWindow");
    ventanaEmergente.style.display = "none";

  });
  editDeckForm.appendChild(gobackButton);

}

//<button id="formButtonAccept" type="button" onclick="ocultarVentana('editDeckWindow')">VOLVER</button>