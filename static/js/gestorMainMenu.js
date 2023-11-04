// Ocultar menús de agregar, quitar y editar evento al cargar la página.
document.addEventListener("DOMContentLoaded", function () {
    var divAgregarEvento = document.getElementById("seeEventsWindow");
    divAgregarEvento.style.display = "none";
});

function createRemindGUI(remindTitle, remindDetailsDay,remindDetailsBegin, remindDetailsBeginMin, remindersList, j, type)
{

    const name = remindersList[j][0];
    const year = remindersList[j][1];
    const month = remindersList[j][2];
    const day = remindersList[j][3];
    const hour = remindersList[j][4];
    const minutes = remindersList[j][5];
    let dayString = "";

    if (type == "today") {
        dayString = "HOY";
    } else if (type == "tomorrow") {
        dayString = "MAÑANA";
    } else if (type == "other") {
        dayString = "EL " + day + "/" + month + "/" + year;
    }
    let extraMinutes = "";
    if (minutes < 10) {
        extraMinutes = "0";
    }

    remindTitle.textContent = name;
    remindDetailsDay.textContent = dayString + " a las ";
    remindDetailsBegin.textContent = hour;
    remindDetailsBeginMin.textContent = ":" + extraMinutes + minutes;
}

function ocultarVentana(elementId) {
  var ventanaEmergente = document.getElementById(elementId);
  ventanaEmergente.style.display = "none";
}

function mostrarVentana(elementId) 
{ 
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "flex";
}

function cargarEventos(nombreRecordatorio, year, month, day, hour, minute)
{

    console.log(nombreRecordatorio);

    var displayDiv = document.createElement("div");
    displayDiv.className = "alertBoxEventDiv";
    displayDiv.id = "alertFullContent";

    var seeEventsContent = document.getElementById("seeEventsContent");
    seeEventsContent.appendChild(displayDiv);

    var j = 0;

    while (j < nombreRecordatorio.length)
    {

        var extraMinutes = "";
        if (minute[j] < 10)
        {

            extraMinutes = "0";

        }

        var dataDiv = document.createElement("div");
        dataDiv.className = "alertBoxContentDiv";

        var eventTitle = document.createElement("h3");
        eventTitle.id = j + "evento";

        var eventDetails = document.createElement("span");
        eventDetails.className = "alertBoxContentDetails";
        eventDetails.id = j + "details";

        eventTitle.textContent = nombreRecordatorio[j];
        eventDetails.textContent = "PROGRAMADO PARA EL " + day[j] + "/" + month[j] + "/" + year[j] + " A LAS " + hour[j] + ":" + extraMinutes + minute[j];

        dataDiv.appendChild(eventTitle);
        dataDiv.appendChild(eventDetails);

        displayDiv.appendChild(dataDiv);
        j++;


    }

    var acceptButton = document.createElement("button");
    acceptButton.className = "acceptButton";
    acceptButton.type = "button";
    acceptButton.textContent = "VOLVER"
         
    var seeAlertsWindowDiv = document.getElementById("seeEventsContent");
    seeAlertsWindowDiv.appendChild(acceptButton);
         
    acceptButton.addEventListener("click", function () {
         
        var ventanaEmergente = document.getElementById("seeEventsWindow");
        ventanaEmergente.style.display = "none";
         
         
         
        });

}