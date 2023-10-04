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

// Ocultar menú de agregar evento al cargar la página
document.addEventListener("DOMContentLoaded", function () {
  var divAgregarEvento = document.getElementById("addEventWindow");
  divAgregarEvento.style.display = "none";
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
