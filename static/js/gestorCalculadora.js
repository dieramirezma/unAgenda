const addBtnGroup = document.querySelector('#addGroupNotes')
const ul = document.querySelector('#groupNotes')
const addBtnNote = document.querySelector('.addNote')

addBtnGroup.addEventListener('click', (e) => {
    const li = document.createElement('li');
    const div_container_note_percentage = document.createElement('div');
    const div_percentage = document.createElement('div');
    const div_container_notes = document.createElement('div');
    const div_container_button_notes = document.createElement('div');
    const div_notes = document.createElement('div');
    const button_edit_note = document.createElement('button');
    const img_edit = document.createElement('img');
    const button_delete_note = document.createElement('button');
    const img_delete = document.createElement('img');
    const button_add_note = document.createElement('button');

    div_container_note_percentage.classList.add('container-note-percentage');
    
    li.classList.add('li-group-notes');
    
    div_percentage.classList.add('percentage');
    div_percentage.contentEditable = "true";
    div_percentage.textContent = '40%';

    div_container_notes.classList.add("container-notes");

    div_container_button_notes.classList.add("container-button-notes");

    div_notes.classList.add("note");
    div_notes.contentEditable = "true";
    div_notes.textContent = '4.5';

    button_edit_note.classList.add("editNote");

    img_edit.classList.add("img-editNote");
    img_edit.src = 'static/img/icons/editarNota.png'

    button_delete_note.classList.add("deletNote");

    img_delete.classList.add("img-editNote");
    img_delete.src = 'static/img/icons/borrarNota.png'

    button_add_note.classList.add("addNote");
    button_add_note.textContent = "Añadir Nota"

    button_add_note.addEventListener('click', (e) => {
        const div_parent = addBtnNote.parentElement
        const div_notes = document.createElement('div');
        const div_container_button_notes = document.createElement('div');
        const button_edit_note = document.createElement('button');
        const img_edit = document.createElement('img');
        const button_delete_note = document.createElement('button');
        const img_delete = document.createElement('img');
    
        div_container_button_notes.classList.add("container-button-notes");
    
        div_notes.classList.add("note");
        div_notes.contentEditable = "true";
        div_notes.textContent = '4.5';
    
        button_edit_note.classList.add("editNote");
    
        img_edit.classList.add("img-editNote");
        img_edit.src = 'static/img/icons/editarNota.png'
    
        button_delete_note.classList.add("deletNote");
    
        img_delete.classList.add("img-editNote");
        img_delete.src = 'static/img/icons/borrarNota.png';
    
        button_edit_note.appendChild(img_edit);
        button_delete_note.appendChild(img_delete);
        div_container_button_notes.appendChild(div_notes);
        div_container_button_notes.appendChild(button_edit_note);
        div_container_button_notes.appendChild(button_delete_note);
        div_parent.appendChild(div_container_button_notes);
    })
    
    button_edit_note.appendChild(img_edit);
    button_delete_note.appendChild(img_delete);
    div_container_button_notes.appendChild(div_notes)
    div_container_button_notes.appendChild(button_edit_note)
    div_container_button_notes.appendChild(button_delete_note)
    div_container_notes.appendChild(div_container_button_notes);
    div_container_notes.appendChild(button_add_note);
    div_container_note_percentage.appendChild(div_percentage);
    div_container_note_percentage.appendChild(div_container_notes);

    li.appendChild(div_container_note_percentage);

    ul.appendChild(li);
})


{/* <div class="container-note-percentage" >
                    <div contenteditable="true" class="percentage">
                        40%
                    </div>
                    <div class="container-notes">
                        <div class="container-button-notes">
                            <div contenteditable="true" class="note">
                                4.5
                            </div>
                            <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                            <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                        </div>    
                        <div class="container-button-notes">
                            <div contenteditable="true" class="note">
                                4.5
                            </div>
                            <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                            <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                        </div>  
                        <div class="container-button-notes">
                            <div contenteditable="true" class="note">
                                4.5
                            </div>
                            <button class="editNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/editarNota.png')}}" alt="Editar nota"></button>
                            <button class="deletNote"><img class='img-editNote' src="{{url_for('static', filename='img/icons/borrarNota.png')}}" alt="Borrar nota"></button>
                        </div>  
                        <div>
                            <button class="addNote">Añadir nota</button>
                        </div>
                    </div>
</div> */}