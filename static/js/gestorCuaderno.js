const btn_save = document.querySelector(".btn-guardar");
const btn_change = document.querySelector(".btn-cambiar");
const nombre_cuaderno = document.querySelector("#encabezado-nombre");
const id_cuaderno = document.querySelector("#id-cuaderno");


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
    console.log(nombre, id)

    let url = '/cuaderno?contenido=' + content + '&nombre=' + nombre + '&id=' + id;
    console.log(nombre.length);

    try {

        const reponse = await fetch(url);
        console.log(reponse);

    } catch (error) {
        console.error("Error: ", error);
    }

    console.log("Han pasado 60 segundos")
}

function change_notebook() {
    tinymce.get("mytextarea").setContent(globalContent)
    console.log("---------- Funcionó ----------")
}

btn_save.addEventListener('click', save_notebook);
btn_change.addEventListener('click', change_notebook);
// window.addEventListener('beforeunload', save_notebook)