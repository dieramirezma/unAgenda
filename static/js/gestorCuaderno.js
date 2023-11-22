const btn_save = document.querySelector(".btn-guardar");
const btn_change = document.querySelector(".btn-cambiar");
const btn_delete = document.querySelector(".btn-eliminar");
const menu_desplegable = document.querySelector("#menuDesplegable");
const nombre_cuaderno = document.querySelector("#encabezado-nombre");
const id_cuaderno = document.querySelector("#id-cuaderno");
const info_user = document.querySelector("#info-user");


let globalContent;

let identificador = setInterval(save_notebook, 60000)

async function save_notebook() {
    let myContent = tinymce.get("mytextarea").getContent();
    let nombre = nombre_cuaderno.textContent;
    let id = id_cuaderno.textContent;

    id = id.trim()

    globalContent = myContent;
    myContent = myContent.replaceAll('"', "'");
    myContent = myContent.replaceAll('&', '5hjis6754');
    myContent = myContent.replaceAll(',', '5hjdf4754');

    content = myContent.split('\n');
    // console.log(nombre, id)

    let url = '/cuaderno?contenido=' + content + '&nombre=' + nombre + '&id=' + id;
    // console.log(nombre.length);

    try {

        const reponse = await fetch(url);
        console.log(reponse);

        if(reponse.status === 500) {
            info_user.classList.add("info-failure");
            info_user.textContent = reponse.statusText + ".\n\n" + "No se ha podido guardar el cuaderno en la base de datos.";
            setTimeout(function() {
                info_user.classList.remove("info-failure");
            }, 3000);
        } else {
            info_user.classList.add("info-success");
            info_user.textContent = "Guardado con exito"
            setTimeout(function() {
                info_user.classList.remove("info-success");
            }, 3000);
        }

    } catch (error) {
        console.error("Error: ", error);
    }

    console.log("Han pasado 60 segundos")
}

// function change_notebook() {
//     tinymce.get("mytextarea").setContent(globalContent)
//     console.log("---------- Funcionó ----------")
// }

function mostrarVentana(elementId) 
{ 
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "flex";
}

function ocultarVentana(elementId) 
{ 
    var ventanaEmergente = document.getElementById(elementId);
    ventanaEmergente.style.display = "none";
}

function desplegar_menu() {
    if (menu_desplegable.style.display === 'block') {
        menu_desplegable.style.display = 'none';
    } else {
        // Realiza una solicitud AJAX para obtener la lista de cuadernos
        fetch('/obtener_cuadernos')
            .then(response => response.json())
            .then(data => {
                // Borra el contenido anterior del menú desplegable
                menu_desplegable.innerHTML = '';

                // Agrega los cuadernos obtenidos a la lista
                data.forEach(cuaderno => {
                    const li = document.createElement('li');
                    li.textContent = cuaderno.nombreCuaderno;
                    li.setAttribute('data-id', cuaderno.id_cuaderno);
                    // Verifica que el contenido se obtiene correctamente
                    console.log("Contenido:", cuaderno.contenido);
                    console.log("ID JSON: ", cuaderno.id_cuaderno);

                    // Agrega el título y el contenido como atributos de datos en el elemento LI
                    li.setAttribute('data-titulo', cuaderno.nombreCuaderno);
                    li.setAttribute('data-contenido', cuaderno.contenido);

                    li.addEventListener('click', function() {
                       // Cuando se hace clic en un cuaderno, cargar los datos en TinyMCE
                       const id = this.getAttribute('data-id');
                       const titulo = this.getAttribute('data-titulo');

                       eliminar_cuaderno(id, titulo, true);
                       ocultarMenuDesplegable(); // Oculta el menú después de seleccionar un cuaderno
                    });
                   menu_desplegable.appendChild(li);
                    
                });
                

                // Muestra el menú
                menu_desplegable.style.display = 'block';
            })
            .catch(error => {
                console.error('Error al obtener la lista de cuadernos:', error);
            });
    }
}

async function eliminar_cuaderno(id, titulo, borrar) {
    window.location.href = '/cuaderno?id=' + id + '&nombre=' + titulo + "&borrar=" + borrar;
    // console.log(nombre.length);
}

function ocultarMenuDesplegable() {
    menu_desplegable.style.display = 'none';
}

btn_save.addEventListener('click', save_notebook);
btn_delete.addEventListener('click', desplegar_menu);
// btn_change.addEventListener('click', change_notebook);
// window.addEventListener('beforeunload', save_notebook)