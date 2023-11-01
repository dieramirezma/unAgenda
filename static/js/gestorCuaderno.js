const btn_save = document.querySelector(".btn-guardar");

const save_notebook = function() {
    let myContent = tinymce.get("mytextarea").getContent();
    console.log(myContent.split('\n'));

    console.log(fetch('/cuaderno?hola='+myContent));
}

btn_save.addEventListener('click', save_notebook);