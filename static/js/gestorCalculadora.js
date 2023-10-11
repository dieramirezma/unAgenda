const addBtnGroup = document.querySelector('#addGroupNotes');
const ul = document.querySelector('#groupNotes');
const addBtnNote = document.querySelector('.addNote');
const btns_edit = document.querySelectorAll('.editNote');
const btns_add_note = document.querySelectorAll('.addNote');
const btns_confirm = document.querySelectorAll('.confirmNote');

let varId = Number(document.querySelector('#group-id').textContent) + 1;
// window.location.href ='/calculator?note=' + "None" + "&percentage=" + "None" + "&id_group=" + "None";

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
    div_percentage.contentEditable = "true";
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
    input_note.required = "true";
    input_note.placeholder = "Ingrese una nota..."
    input_note.classList.add("note");

    button_edit_note.classList.add("editNote");

    img_edit.classList.add("img-editNote");
    img_edit.src = 'static/img/icons/editarNota.png';
    button_edit_note.style.display = "none";

    button_delete_note.classList.add("deletNote");

    img_delete.classList.add("img-editNote");
    img_delete.src = 'static/img/icons/borrarNota.png';

    button_confirm_note.classList.add("confirmNote");
    button_confirm_note.style.display = "block";
    
    img_confirm.classList.add("img-editNote");
    img_confirm.src = 'static/img/icons/Confirm_note.png';

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

    console.log(document.getElementById("groupNotes").childNodes.length);
    console.log(document.getElementById("groupNotes").childNodes);

    varId++;
});

const editNoteFun = function(e) {
    e.preventDefault();
    this.previousSibling.previousSibling.previousSibling.previousSibling.readOnly = false;
    this.previousSibling.previousSibling.style.display = "block";
    // console.log(this.previousSibling.previousSibling.previousSibling.previousSibling);
    // console.log(this.previousSibling.previousSibling);
    this.style.display = "none";
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
    input_note.required = "true";
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

    button_confirm_note.classList.add("confirmNote");
    button_confirm_note.style.display = "block";

    img_confirm.classList.add("img-editNote");
    img_confirm.src = 'static/img/icons/Confirm_note.png';

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
}

btns_add_note.forEach(boton => {
    boton.addEventListener('click', add_note_event);
});

const confirm_event = function(event) {
    const button_add_note = this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling;
    const input_note = this.previousSibling.previousSibling;
    const button_edit_note = this.nextSibling.nextSibling;

    let note = 0;
    let percentage = 0

    event.preventDefault();

    // console.log(this.nextSibling.nextSibling);
    // .textContent.split('%')[0]
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
    note = input_note.value;
    percentage = Number(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.textContent.split('%')[0]);
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode)
    id_group = Number(this.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.parentNode.id.split('li')[1]);
    // console.log(this.parentNode.parentNode.parentNode.parentNode.parentNode.firstChild.nextSibling.nextSibling.nextSibling.firstChild.nextSibling);

    button_add_note.disabled = false;
    addBtnGroup.disabled = false;
    button_edit_note.style.display = "block";
    this.style.display = "none";
    input_note.readOnly = true;

    window.location.href ='/calculator?note=' + note + "&percentage=" + percentage + "&id_group=" + id_group;
    // console.log(e);
}

btns_confirm.forEach(boton => {
    boton.addEventListener('click', confirm_event);
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