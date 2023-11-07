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

function cargarEventosSee(containerParent, containerChildren, nombreRecordatorio, year, month, day, hour, minute)
{
    
    var displayDiv = document.createElement("div");
    displayDiv.className = "alertBoxEventDiv";
    displayDiv.id = "alertFullContent";

    var seeEventsContent = document.getElementById(containerChildren);
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

        var individualEventDiv = document.createElement("div");
        individualEventDiv.className = "individualEventDiv";
        
        var eventTitle = document.createElement("h3");
        eventTitle.id = j + "evento";

        var eventDetails = document.createElement("span");
        eventDetails.className = "alertBoxContentDetails";
        eventDetails.id = j + "details";

        eventTitle.textContent = nombreRecordatorio[j];
        eventDetails.textContent = "PROGRAMADO PARA EL " + day[j] + "/" + month[j] + "/" + year[j] + " A LAS " + hour[j] + ":" + extraMinutes + minute[j];

        individualEventDiv.appendChild(eventTitle);
        individualEventDiv.appendChild(eventDetails);
        dataDiv.appendChild(individualEventDiv)
        
        
        displayDiv.appendChild(dataDiv);
        j++;


    }

    var acceptButton = document.createElement("button");
    acceptButton.className = "acceptButton";
    acceptButton.type = "button";
    acceptButton.textContent = "VOLVER"
         
    var seeAlertsWindowDiv = document.getElementById(containerChildren);
    seeAlertsWindowDiv.appendChild(acceptButton);
         
    acceptButton.addEventListener("click", function () {
         
        var ventanaEmergente = document.getElementById(containerParent);
        ventanaEmergente.style.display = "none";
         
         
         
        });

}


function cargarEventosDelete(containerParent, containerChildren, nombreRecordatorio, year, month, day, hour, minute)
{
    
    var displayDiv = document.createElement("div");
    displayDiv.className = "alertBoxEventDiv";
    displayDiv.id = "alertFullContent";

    var seeEventsContent = document.getElementById(containerChildren);
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

        var individualEventDiv = document.createElement("div");
        individualEventDiv.className = "individualEventDiv";
        
        var eventTitle = document.createElement("h3");
        eventTitle.id = j + "remind";

        var eventDetails = document.createElement("span");
        eventDetails.className = "alertBoxContentDetails";
        eventDetails.id = j + "detailsRemind";

        eventTitle.textContent = nombreRecordatorio[j];
        eventDetails.textContent = "PROGRAMADO PARA EL " + day[j] + "/" + month[j] + "/" + year[j] + " A LAS " + hour[j] + ":" + extraMinutes + minute[j];

        individualEventDiv.appendChild(eventTitle);
        individualEventDiv.appendChild(eventDetails);
        dataDiv.appendChild(individualEventDiv)
        
        //  Add remove buttons
        var removeButton = document.createElement("button");
        removeButton.className = "removeButton";
        removeButton.id = j;
        removeButton.type = "button";
        removeButton.textContent = "ELIMINAR"
        dataDiv.appendChild(removeButton);

        removeButton.addEventListener("click", function () {
            console.log(document.getElementById(this.id + "remind").textContent);
            console.log(document.getElementById(this.id + "detailsRemind").textContent);

            var remindSTR = document.getElementById(this.id + "remind").textContent;
            var detailSTR = document.getElementById(this.id + "detailsRemind").textContent;

            var splitDetails = detailSTR.split(" ");

            let dateSTR = splitDetails[3];
            let timeSTR = splitDetails[6];

            let splitDate = dateSTR.split("/");
            let splitTime = timeSTR.split(":");

            let yearSTR = splitDate[2];
            let monthSTR = splitDate[1];
            let daySTR = splitDate[0];

            let hourSTR = splitTime[0];
            let minuteSTR = splitTime[1];

            if (minuteSTR === "00") {
                minuteSTR = "0";
            }

            console.log("yearSTR: " + yearSTR);
            console.log("monthSTR: " + monthSTR);
            console.log("daySTR: " + daySTR);
            console.log("hourSTR: " + hourSTR);
            console.log("minuteSTR: " + minuteSTR);

            window.location.href = "/remindRemove?yearSTR=" + yearSTR + "&monthSTR=" + monthSTR + "&daySTR=" + daySTR + "&hourSTR=" + hourSTR + "&minuteSTR=" + minuteSTR + "&remindSTR=" + remindSTR;
            
        });
        
        
        displayDiv.appendChild(dataDiv);
        j++;


    }

    var acceptButton = document.createElement("button");
    acceptButton.className = "acceptButton";
    acceptButton.type = "button";
    acceptButton.textContent = "VOLVER"
         
    var seeAlertsWindowDiv = document.getElementById(containerChildren);
    seeAlertsWindowDiv.appendChild(acceptButton);
         
    acceptButton.addEventListener("click", function () {
         
        var ventanaEmergente = document.getElementById(containerParent);
        ventanaEmergente.style.display = "none";
         
         
         
        });

}


function cargarEventosEdit(containerParent, containerChildren, nombreRecordatorio, year, month, day, hour, minute)
{
    
    var displayDiv = document.createElement("div");
    displayDiv.className = "alertBoxEventDiv";
    displayDiv.id = "alertFullContent";

    var seeEventsContent = document.getElementById(containerChildren);
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

        var individualEventDiv = document.createElement("div");
        individualEventDiv.className = "individualEventDiv";
        
        var eventTitle = document.createElement("h3");
        eventTitle.id = j + "remind";

        var eventDetails = document.createElement("span");
        eventDetails.className = "alertBoxContentDetails";
        eventDetails.id = j + "detailsRemind";

        eventTitle.textContent = nombreRecordatorio[j];
        eventDetails.textContent = "PROGRAMADO PARA EL " + day[j] + "/" + month[j] + "/" + year[j] + " A LAS " + hour[j] + ":" + extraMinutes + minute[j];

        individualEventDiv.appendChild(eventTitle);
        individualEventDiv.appendChild(eventDetails);
        dataDiv.appendChild(individualEventDiv)
        
        //  Add remove buttons
        var editButton = document.createElement("button");
        editButton.className = "editButton";
        editButton.id = j;
        editButton.type = "button";
        editButton.textContent = "EDITAR"
        dataDiv.appendChild(editButton);

        editButton.addEventListener("click", function () {
            ocultarVentana(containerParent);
            mostrarVentana("editRemindWindow");


            var inputDateEdit = document.getElementById("fechaEdit");
            var inputTimeEdit = document.getElementById("horaEdit");
            var inputNameRemindEdit = document.getElementById("nameRemindEdit"); 
            
            console.log(document.getElementById(this.id + "remind").textContent);
            console.log(document.getElementById(this.id + "detailsRemind").textContent);

            var remindSTR = document.getElementById(this.id + "remind").textContent;
            var detailSTR = document.getElementById(this.id + "detailsRemind").textContent;

            var splitDetails = detailSTR.split(" ");

            let dateSTR = splitDetails[3];
            let timeSTR = splitDetails[6];

            
            let splitDate = dateSTR.split("/");
            let splitTime = timeSTR.split(":");
            
            let yearSTR = splitDate[2];
            let monthSTR = splitDate[1];
            let daySTR = splitDate[0];
            
            let hourSTR = splitTime[0];
            let minuteSTR = splitTime[1];
            
            if (minuteSTR === "00") {
                minuteSTR = "0";
            }
            if (daySTR.length == 1) {
                daySTR = "0"+daySTR;
            }

            console.log(yearSTR + "-" + monthSTR + "-" + daySTR);
            inputDateEdit.value = yearSTR + "-" + monthSTR + "-" + daySTR;
            inputTimeEdit.value = timeSTR;
            inputNameRemindEdit.value = remindSTR;
            
            document.getElementById("yearSTR").value = yearSTR;
            document.getElementById("monthSTR").value = monthSTR;
            document.getElementById("daySTR").value = daySTR;
            document.getElementById("hourSTR").value = hourSTR;
            document.getElementById("minuteSTR").value = minuteSTR;
            document.getElementById("remindSTR").value = remindSTR;


        });
        
        
        displayDiv.appendChild(dataDiv);
        j++;


    }

    var acceptButton = document.createElement("button");
    acceptButton.className = "acceptButton";
    acceptButton.type = "button";
    acceptButton.textContent = "VOLVER"
         
    var seeAlertsWindowDiv = document.getElementById(containerChildren);
    seeAlertsWindowDiv.appendChild(acceptButton);
         
    acceptButton.addEventListener("click", function () {
         
        var ventanaEmergente = document.getElementById(containerParent);
        ventanaEmergente.style.display = "none";
         
         
         
        });

}