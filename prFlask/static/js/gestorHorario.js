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

//$ EDITAR TABLA

//  Cambiar de color las celdas de la tabla
function editarCelda() {
  let diaSemana = document.getElementById("diaSemana");
  let nombre;
  let schedule = document.getElementById("schedule");
  let dia = parseInt(diaSemana.value);

  const horaInicioVal = parseInt(horaInicio.value);
  const horaFinVal = parseInt(horaFin.value);

  const diferencia = horaFinVal - horaInicioVal;

  const colorRandom = COLORES[Math.floor(Math.random() * COLORES.length)];

  for (let i = 0; i < diferencia; i++) {
    let celda = schedule.rows[horaInicioVal - 6 + i].cells[dia];
    celda.style.backgroundColor = colorRandom;
    celda.style.color = "black";
    celda.textContent = nombreEvento.value;
  }




  console.log(horaInicio.value, horaFin.value);
}

//$ VALIDAR FORMULARIO

function crearEvento() {
  if (validarFormulario()) {
    editarCelda();
    ocultarVentana();
  }
}

function validarFormulario() {
  let nombreEvento = document.getElementById("nombreEvento").value;
  let diaSemana = document.getElementById("diaSemana").value;
  let horaInicio = document.getElementById("horaInicio").value;
  let horaFin = document.getElementById("horaFin").value;

  if (nombreEvento == "") {
    alert("El nombre del evento no puede estar vacío");
    return false;
  } else if (diaSemana == "") {
    alert("Debe seleccionar un día de la semana");
    return false;
  } else if (horaInicio == "") {
    alert("Debe seleccionar una hora inicial");
    return false;
  } else if (horaFin == "") {
    alert("Debe seleccionar una hora final");
    return false;
  }
  return true;
}
