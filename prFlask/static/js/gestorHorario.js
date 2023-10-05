const COLORES = [
  "#FFC0CB",
  "#87CEEB",
  "#98FB98",
  "#FFFF99",
  "#E6E6FA",
  "#AFEEEE",
  "#FFD700",
  "#00FFFF",
  "#FFDAB9",
  "#FFFACD",
  "#D8BFD8",
  "#98FF98",
  "#FFF0F5",
  "#DFFFBF",
  "#D3D3D3",
  "#A1CAF1",
  "#FFFFB3",
  "#FFF0F5",
  "#DFFFBF",
  "#FF6F61",
];

var horaInicio;
var horaFin;

// Ocultar menús de agregar, quitar y editar evento al cargar la página.
document.addEventListener("DOMContentLoaded", function () {
  var divAgregarEvento = document.getElementById("addEventWindow");
  divAgregarEvento.style.display = "none";

  var divQuitarEvento = document.getElementById("removeEventWindow");
  divQuitarEvento.style.display = "none";

  var divEditarEvento = document.getElementById("editEventWindow");
  divEditarEvento.style.display = "none";
});

//% AGREGAR EVENTO

//$ CONTROL VENTANA EMERGENTE

//  Mostrar ventana de agregar evento
function mostrarVentana() {
  horaInicio = document.getElementById("horaInicio");
  horaFin = document.getElementById("horaFin");
  var ventanaEmergente = document.getElementById("addEventWindow");

  ventanaEmergente.style.display = "flex";

  horaInicio.addEventListener("change", function () {
    let opcionesHoraFin = horaFin.options;
    let horaInicioSel = parseInt(horaInicio.value);
    for (let i = 0; i < opcionesHoraFin.length; i++) {
      if (parseInt(opcionesHoraFin[i].value) <= horaInicioSel) {
        opcionesHoraFin[i].style.display = "none";
      } else {
        opcionesHoraFin[i].style.display = "";
      }
    }

    horaFin.value = toString(horaInicioSel + 1);
  });
}

// Ocultar ventana de agregar evento
function ocultarVentana() {
  var ventanaEmergente = document.getElementById("addEventWindow");
  ventanaEmergente.style.display = "none";
}

function editarCelda(evento, diaSemanaList, horaInicioList, horaFinList, j) {
  let nombre = evento[j];
  let dia = diaSemanaList[j];
  const horaInicioVal = horaInicioList[j];
  const horaFinVal = horaFinList[j];

  const diferencia = horaFinVal - horaInicioVal;
  const colorRandom = COLORES[Math.floor(Math.random() * COLORES.length)];

  for (let i = 0; i < diferencia; i++) {
    let celda = schedule.rows[horaInicioVal - 6 + i].cells[dia];
    celda.style.backgroundColor = colorRandom;
    celda.style.color = "black";
    celda.textContent = nombre;
  } 
}

// % DESCARGAR HORARIO
function html2canvasFunc() {
  html2canvas(document.querySelector("table")).then(function (canvas) {
    // Convertir el canvas en una imagen PNG
    var imgData = canvas.toDataURL("image/png");
    var img = new Image();
    img.src = imgData;
    document.getElementById("imagen").appendChild(img);
  });
}


// SECCIÓN DEDICADA A BORRAR EVENTO

//MOSTRAR LA VENTANA DE BORRAR UN EVENTO

function mostrarVentanaRemove() 
{

  var ventanaEmergente = document.getElementById("removeEventWindow");

  ventanaEmergente.style.display = "flex";
  displayEventos();

  };

//GENERAR LOS DIVS DE LA VENTANA DE ELIMINAR

function createEventRemovalGUI(eventTitle, eventDetailsDay, evento, diaSemana, horaInicio, horaFin, j, eventDetailsBegin, eventDetailsGuion)
{

  let nombre = evento[j];
  let diaP;
  const horaInicioVal = horaInicio[j];
  const horaFinVal = horaFin[j];

  switch (diaSemana[j])
  {

    case "1":
      diaP = "LUNES";
      break;
    case "2":
      diaP = "MARTES";
      break;
    case "3":
      diaP = "MIÉRCOLES";
      break;
    case "4":
      diaP = "JUEVES";
      break;
    case "5":
      diaP = "VIERNES";
      break;
    case "6":
      diaP = "SÁBADO";
      break;
    case "7":
      diaP = "DOMINGO";
      break;

  }

  eventTitle.textContent = nombre;
  eventDetailsDay.textContent = diaP + " ";
  eventDetailsBegin.textContent = horaInicioVal;
  eventDetailsGuion.textContent = ":00 - " + horaFinVal +":00";
}

//SECCIÓN DEDICADA A EDITAR EVENTO

function mostrarVentanaEdit() 
{

  var ventanaEmergente = document.getElementById("editEventWindow");

  ventanaEmergente.style.display = "flex";
  displayEventosEdit();

  };




