const btn_save = document.querySelector(".btn-guardar");
const btn_change = document.querySelector(".btn-cambiar");

let globalContent;

let identificador = setInterval(save_notebook, 60000)

async function save_notebook() {
    let myContent = tinymce.get("mytextarea").getContent();
    globalContent = myContent;
    myContent = myContent.replaceAll('"', "'");
    myContent = myContent.replaceAll('&', '5hjis6754');
    myContent = myContent.replaceAll(',', '5hjdf4754');

    content = myContent.split('\n');
    console.log(content)

    try {

        const reponse = await fetch('/cuaderno?contenido=' + content);
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