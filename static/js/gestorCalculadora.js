const addBtnGroup = document.querySelector('#addGroupNotes');
const ul = document.querySelector('#groupNotes');
const btns_edit = document.querySelectorAll('.editNote');
const btns_add_note = document.querySelectorAll('.addNote');
const btn_edit_group = document.querySelector("#editGroupNotes");
const modal_container = document.querySelector("#modal-container");
const btn_close_edit = document.querySelector("#close");
const btns_edit_group = document.querySelectorAll(".edit-group")
const btns_confirm_group = document.querySelectorAll(".confirm-group")
const btns_confirm = document.querySelectorAll('.confirmNote');
const btn_delete_group = document.querySelector('#deleteGroupNotes');
const modal_container_delete = document.querySelector("#modal-container-eliminar");
const btn_close_delete = document.querySelector("#close-eliminar");
// console.log(document.querySelectorAll('.confirmNote'));

let varId = Number(document.querySelector('#group-id').textContent) + 1;

let isUpdate = 0;
let isUpdateGroup = 0;

function generateUUID() { // Public Domain/MIT
    var d = new Date().getTime();//Timestamp
    var d2 = ((typeof performance !== 'undefined') && performance.now && (performance.now()*1000)) || 0;//Time in microseconds since page-load or 0 if unsupported
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random() * 16;//random number between 0 and 16
        if(d > 0){//Use timestamp until depleted
            r = (d + r)%16 | 0;
            d = Math.floor(d/16);
        } else {//Use microseconds since page-load if supported
            r = (d2 + r)%16 | 0;
            d2 = Math.floor(d2/16);
        }
        return (c === 'x' ? r : (r & 0x3 | 0x8)).toString(16);
    });
}

console.log(generateUUID())

addBtnGroup.addEventListener('click', (e) => {
    const li = document.createElement('li');
    const li_notes = document.createElement('li');
    const ul_notes = document.createElement('ul');
    const div_container_note_percentage = document.createElement('div');
    const div_percentage = document.createElement('div');
    const div_container_notes = document.createElement('div');
    const div_container_button_notes = document.createElement('div');
    // const div_notes = document.createElement('div');
    const form_note = document.createElement("form");
    const input_note = document.createElement("input");
    const button_edit_note = document.createElement('button');
    const img_edit = document.createElement('img');
    const button_delete_note = document.createElement('button');
    const img_delete = document.createElement('img');
    const button_add_note = document.createElement('button');
    const img_confirm = document.createElement('img');
    const button_confirm_note = document.createElement("button");

    div_container_note_percentage.classList.add('container-note-percentage');
    
    li.classList.add('li-group-notes');
    li.setAttribute("id", "li" + varId.toString());

    li.classList.add('li-notes');

    addBtnGroup.disabled = "true";
    
    div_percentage.classList.add('percentage');
    div_percentage.textContent = '40%';

    div_container_notes.classList.add("container-notes");

    div_container_button_notes.classList.add("container-button-notes");

    // div_notes.classList.add("note");
    // div_notes.contentEditable = "true";
    // div_notes.textContent = '4.5';
    form_note.method = 'post';

    input_note.type = 'number';
    input_note.step = "0.001";
    input_note.min = "0";
    input_note.max = "5";
    input_note.required = true;
    input_note.placeholder = "Ingrese una nota..."
    input_note.classList.add("note");

    button_edit_note.classList.add("editNote");

    img_edit.classList.add("img-editNote");
    img_edit.src = 'static/img/icons/editarNota.png';
    button_edit_note.style.display = "none";

    button_delete_note.classList.add("deletNote");

    img_delete.classList.add("img-editNote");
    img_delete.src = 'static/img/icons/borrarNota.png';

    button_confirm_note.className = "confirmNote";
    button_confirm_note.style.display = "block";
    
    img_confirm.classList.add("img-editNote");
    img_confirm.src = 'static/img/icons/Confirm_note.png';

    button_confirm_note.addEventListener('click', (ev) => {
        ev.preventDefault();

        let note = 0;
        let percentage = 0

        // console.log(this.nextSibling.nextSibling);
        // .textContent.split('%')[0]
        console.log(div_percentage.textContent.split('%')[0]);
        // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
        note = input_note.value;
        percentage = Number(div_percentage.textContent.split('%')[0]);
        // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode)
        id_group = Number(button_confirm_note.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
        // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling);

        button_add_note.disabled = false;
        addBtnGroup.disabled = false;
        button_edit_note.style.display = "block";
        button_confirm_note.style.display = "none";
        input_note.readOnly = true;

        // alert(note + " " + percentage + " " + id_group)
        window.location.href = "/calculator?note=" + note + "&percentage=" + percentage + "&id_group=" + id_group + '&uuid=' + generateUUID() + "&isUpdate=" + isUpdate;
        // console.log(e);
    });

    button_add_note.classList.add("addNote");
    button_add_note.textContent = "Añadir Nota"
    button_add_note.disabled = "true";

    button_edit_note.appendChild(img_edit);
    button_delete_note.appendChild(img_delete);
    button_confirm_note.appendChild(img_confirm);
    form_note.appendChild(input_note);
    form_note.appendChild(button_confirm_note);
    form_note.appendChild(button_edit_note);
    form_note.appendChild(button_delete_note);
    div_container_button_notes.appendChild(form_note);
    li_notes.appendChild(div_container_button_notes);
    ul_notes.appendChild(li_notes)
    div_container_notes.appendChild(ul_notes);
    div_container_notes.appendChild(button_add_note);
    div_container_note_percentage.appendChild(div_percentage);
    div_container_note_percentage.appendChild(div_container_notes);

    li.appendChild(div_container_note_percentage);

    ul.appendChild(li);

    // console.log(document.getElementById("groupNotes").childNodes.length);
    // console.log(document.getElementById("groupNotes").childNodes);

    // console.log(document.querySelectorAll('.confirmNote'));
    // btns_confirm = document.querySelectorAll('.confirmNote');
    varId++;
});

const editNoteFun = function(e) {
    e.preventDefault();
    this.previousSibling.previousSibling.previousSibling.previousSibling.readOnly = false;
    this.previousSibling.previousSibling.style.display = "block";
    // console.log(this.previousSibling.previousSibling.previousSibling.previousSibling);
    // console.log(this.previousSibling.previousSibling);
    this.style.display = "none";
    isUpdate = 1;
}

btns_edit.forEach(boton => {
    boton.addEventListener('click', editNoteFun);
});

const add_note_event = function(e) {
    const div_parent = this.parentNode.parentNode;
    // console.log(this.parentNode.parentNode);
    // const div_notes = document.createElement('div');
    const form_note = document.createElement("form");
    const input_note = document.createElement("input");
    const div_container_button_notes = document.createElement('div');
    const button_edit_note = document.createElement('button');
    const img_edit = document.createElement('img');
    const button_delete_note = document.createElement('button');
    const img_delete = document.createElement('img');
    const img_confirm = document.createElement('img');
    const button_confirm_note = document.createElement("button");
    const li_notes = document.createElement('li');
    // console.log(div_parent.firstChild);

    this.disabled = "true";
    addBtnGroup.disabled = "true";

    div_container_button_notes.classList.add("container-button-notes");
    
    form_note.method = 'post';

    input_note.type = 'number';
    input_note.step = "0.001";
    input_note.min = "0";
    input_note.max = "5";
    input_note.placeholder = "Ingrese una nota..."
    input_note.required = true;
    input_note.classList.add("note");
    // div_notes.classList.add("note");
    // div_notes.contentEditable = "true";
    // div_notes.textContent = '4.5';

    button_edit_note.classList.add("editNote");
    button_edit_note.style.display = "none"

    img_edit.classList.add("img-editNote");
    img_edit.src = 'static/img/icons/editarNota.png'
    

    button_delete_note.classList.add("deletNote");

    img_delete.classList.add("img-editNote");
    img_delete.src = 'static/img/icons/borrarNota.png';

    button_confirm_note.className = "confirmNote";
    button_confirm_note.style.display = "block";

    img_confirm.classList.add("img-editNote");
    img_confirm.src = 'static/img/icons/Confirm_note.png';

    button_confirm_note.addEventListener('click', (e) => {
        e.preventDefault();
        console.log(this);
        console.log(button_confirm_note.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);

        note = input_note.value;
        // console.log(note);
        percentage = Number(button_confirm_note.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);
        // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode)
        id_group = Number(button_confirm_note.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
        // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling);

        this.disabled = false;
        addBtnGroup.disabled = false;
        button_edit_note.style.display = "block";
        button_confirm_note.style.display = "none";
        input_note.readOnly = true;

        // alert(note + " " + percentage + " " + id_group)
        window.location.href = "/calculator?note=" + note + "&percentage=" + percentage + "&id_group=" + id_group + '&uuid=' + generateUUID() + "&isUpdate=" + isUpdate;
    
    });

    button_edit_note.appendChild(img_edit);
    button_delete_note.appendChild(img_delete);
    button_confirm_note.appendChild(img_confirm);
    form_note.appendChild(input_note);
    form_note.appendChild(button_confirm_note);
    form_note.appendChild(button_edit_note);
    form_note.appendChild(button_delete_note);
    div_container_button_notes.appendChild(form_note);
    li_notes.appendChild(div_container_button_notes);
    // console.log(div_parent.firstChild.nextSibling);
    div_parent.firstChild.nextSibling.appendChild(li_notes);

    btns_confirm = document.querySelectorAll('.confirmNote');

    console.log("Hola");
}

btns_add_note.forEach(boton => {
    boton.addEventListener('click', add_note_event);
});

const confirm_event = function(event) {
    event.preventDefault();

    const button_add_note = this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling;
    const input_note = this.previousSibling.previousSibling;
    const button_edit_note = this.nextSibling.nextSibling;

    

    let note = 0;
    let percentage = 0

    // console.log(this.nextSibling.nextSibling);
    // .textContent.split('%')[0]
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
    note = input_note.value;
    percentage = Number(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode)
    id_group = Number(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
    id_nota = input_note.id.split("nota ")[1]
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling);

    button_add_note.disabled = false;
    addBtnGroup.disabled = false;
    button_edit_note.style.display = "block";
    this.style.display = "none";
    input_note.readOnly = true;

    let _isUpdate = isUpdate;
    isUpdate = 0;

    // alert(note + " " + percentage + " " + id_group)
    window.location.href = "/calculator?note=" + note + "&percentage=" + percentage + "&id_group=" + id_group + '&uuid=' + generateUUID() + "&isUpdate=" + _isUpdate + "&id_nota=" + id_nota;
    // console.log(e);
}

btns_confirm.forEach(btn => {
    btn.addEventListener('click', confirm_event);
});

btn_edit_group.addEventListener('click', () => {
    modal_container.classList.add('show');
});

btn_close_edit.addEventListener('click', () => {
    modal_container.classList.remove('show');
});

btn_delete_group.addEventListener('click', () => {
    modal_container_delete.classList.add('show');
});

btn_close_delete.addEventListener('click', () => {
    modal_container_delete.classList.remove('show');
});

const edit_group_event = function(e) {
    e.preventDefault();
    // console.log(this.nextSibling.nextSibling)
    // console.log(this.previousSibling.previousSibling.previousSibling)
    const confirm_group = this.nextSibling.nextSibling;
    const input_group = this.previousSibling.previousSibling.previousSibling;

    confirm_group.style.display= "block";
    this.style.display = "none"
    input_group.readOnly = false;
    isUpdateGroup = 1;
}

btns_edit_group.forEach(boton => {
    boton.addEventListener('click', edit_group_event);
}); 

const confirm_group_event = function(e) {
    e.preventDefault();
    id_group = Number(this.parentNode.previousSibling.previousSibling.textContent.split('Grupo ')[1]) - 1
    percentage = this.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling.value
    // console.log(this.parentNode.previousSibling.previousSibling.textContent.split('Grupo ')[1]);
    // console.log(this.previousSibling.previousSibling.previousSibling.previousSibling.previousSibling);
    isUpdate = 0;
    let _isUpdateGroup = isUpdateGroup;
    isUpdateGroup = 0;
    window.location.href = "/calculator?note=" + "None" + "&percentage=" + percentage + "&id_group=" + id_group + '&uuid=' + generateUUID() + "&isUpdate=" + isUpdate + "&id_nota=" + "None" + "&isUpdateGroup=" + _isUpdateGroup;
}

btns_confirm_group.forEach(boton => {
    boton.addEventListener('click', confirm_group_event);
});


{/* <div class="container-note-percentage" >
    <div contenteditable="true" class="percentage">
        40%
    </div>
    <div class="container-notes">
        <ul>
            <li>
                <div class="container-button-notes">
                    <form method="post">
                        <input type="number">
                        <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                        <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                    </form>
                    <div contenteditable="true" class="note">
                        4.5
                    </div>
                    <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                    <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                </div>    
            </li>
            <li>
                <div class="container-button-notes">
                    <div contenteditable="true" class="note">
                        4.5
                    </div>
                    <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                    <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                </div>  
            </li>
            <li>
                <div class="container-button-notes">
                    <div contenteditable="true" class="note">
                        4.5
                    </div>
                    <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                    <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                </div>
            </li>  
        </ul>
        <div>
            <button class="addNote">Añadir nota</button>
        </div>
    </div>
</div> */}
