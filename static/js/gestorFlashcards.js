
function ocultarVentana(elementId) {
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "none";
  }

function mostrarVentana(elementId, number = 0, nombreMazo = null, pregunta = null, respuesta = null) 
{ 
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "flex";

    var form = document.getElementById("actualForm1");
    var title = document.getElementById("newDeckTitle");
    var label1 = document.getElementById("labelFirstQuestion");
    var label2 = document.getElementById("labelFirstAnswer");
    var input0 = document.getElementById("nameDeck");
    var input1 = document.getElementById("questionFirstCard");
    var input2 = document.getElementById("answerFirstCard");

    var hiddeninput1 = document.getElementById("questionFirstCard1");
    var hiddeninput2 = document.getElementById("answerFirstCard1");
    var hiddeninput3 = document.getElementById("nameDeck1");

    //#DBDBDB

    form.action = "/newDeck"
    title.textContent = "Agregar Mazo:"
    input0.value = "";
    input0.disabled = false;
    input0.style.backgroundColor = "#DBDBDB"
    label1.textContent = "Pregunta de la Primera Tarjeta:"
    label2.textContent = "Respuesta de la Primera Tarjeta:"
    input1.value = "";
    input2.value = "";
    hiddeninput1.value = "";
    hiddeninput2.value = "";
    hiddeninput3.value = "";
    
    if (number == 1)
    {

      form.action = "/editFlashcard"
      title.textContent = "Edita la Carta:"
      input0.value = nombreMazo;
      input0.disabled = true;
      input0.style.backgroundColor = "#FFFFFF"
      label1.textContent = "Nueva Pregunta:"
      label2.textContent = "Nueva Respuesta:"
      input1.value = pregunta;
      input2.value = respuesta;

      hiddeninput1.value = pregunta;
      hiddeninput2.value = respuesta;
      hiddeninput3.value = nombreMazo;

    }
}

function alterarInterfaz(selectorVar, totalFlashcards)
{
  const selector = document.getElementById(selectorVar);
  if (selector.options[selector.selectedIndex].text == "CREAR UN NUEVO MAZO...")
    {

      var ventanaEmergente = document.getElementById("newDeckWindow");
      ventanaEmergente.style.display = "flex";

      var form = document.getElementById("actualForm1");
      var title = document.getElementById("newDeckTitle");
      var label1 = document.getElementById("labelFirstQuestion");
      var label2 = document.getElementById("labelFirstAnswer");
      var input0 = document.getElementById("nameDeck");
      var input1 = document.getElementById("questionFirstCard");
      var input2 = document.getElementById("answerFirstCard");

      //#DBDBDB

      form.action = "/newDeck"
      title.textContent = "Agregar Mazo:"
      input0.value = "";
      input0.disabled = false;
      input0.style.backgroundColor = "#DBDBDB"
      label1.textContent = "Pregunta de la Primera Tarjeta:"
      label2.textContent = "Respuesta de la Primera Tarjeta:"
      input1.value = "";
      input2.value = "";
      hiddeninput1.value = "";
      hiddeninput2.value = "";
      hiddeninput3.value = "";

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
      
      //FUNCIONAMIENTO BOTÓN DE BORRAR

      subtitle.textContent = totalFlashcards[i][1];
      deleteButton.id = i ;
      subtitle.id = i + "subtitle";

      deleteButton.addEventListener("click", function () 
      {
        var preguntaText = document.getElementById(this.id + "subtitle").textContent;
        window.location.href = "/deleteFlashcard?nombreMazo=" + nombreMazo.textContent + "&pregunta=" + preguntaText;
        
      });

      //FUNCIONAMIENTO BOTÓN DE EDITAR

      subtitle.textContent = totalFlashcards[i][1];
      editButton.id = i;
      subtitle.id = i + "subtitle";

      editButton.addEventListener("click", function () 
      {

        var preguntaText = document.getElementById(this.id + "subtitle").textContent;
        var answerText = "notFound";
        for (var i = 0; i < totalFlashcards.length; i++)
        {

          if(totalFlashcards[i][0] == nombreMazo.textContent && totalFlashcards[i][1] == preguntaText)
          {

            answerText = totalFlashcards[i][2];

          }

        }

        ocultarVentana("editDeckWindow");
        mostrarVentana("newDeckWindow", 1, nombreMazo.textContent, preguntaText, answerText);
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