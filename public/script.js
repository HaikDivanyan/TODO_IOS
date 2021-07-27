window.onload = showTasks();

async function addTask() {    
    const URL = "http://localhost:3000/create";
    var taskName = document.getElementById("new-task-name").value;
    console.log(taskName);
    console.log("in the function");

    const res = await fetch(URL, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            name: taskName,
        }),
    });
    var task_name = await res.json();
    console.log(task_name);

    var ul = document.getElementById("ul");
    var listItem = document.createElement("li");
    ul.appendChild(listItem);
    listItem.classList.add("list-group-item");
    var div = document.createElement("div");
    listItem.appendChild(div);
    div.className = "form-check form-switch";
    var input = document.createElement("input");
    div.appendChild(input);
    input.classList.add("form-check-input");
    input.type = "checkbox";
    input.id = "flexSwitchCheckDefault";
    input.setAttribute('list-id', task_name._id)
    input.setAttribute('onclick', 'updateTask(this);');
    var label = document.createElement("label");
    div.appendChild(label);
    label.classList.add("form-check-label");
    label.setAttribute("for", "flexSwitchCheckDefault");
    label.innerHTML = " " + task_name.name;
    var deleteButton = document.createElement('button');
    div.appendChild(deleteButton);
    deleteButton.className = 'btn btn-primary'
    deleteButton.type = 'button';
    deleteButton.setAttribute("onclick", 'deleteTask(this);');
    deleteButton.setAttribute('list-id', task_name._id)
    deleteButton.innerHTML = 'delete';

    document.getElementById('new-task-name').value = "";

}

async function showTasks() {

    const URL = "http://localhost:3000/get-tasks";

    const res = await fetch(URL, {
        method: "GET",
    });
    var tasks = await res.json();
    for (let i = 0; i < tasks.length; i++) {
        var ul = document.getElementById("ul");
        var listItem = document.createElement("li");
        ul.appendChild(listItem);
        listItem.className = "list-group-item";
        var div = document.createElement("div");
        listItem.appendChild(div);
        div.className = "form-check form-switch";
        var input = document.createElement("input");
        div.appendChild(input);
        input.classList.add("form-check-input");
        input.type = "checkbox";
        input.id = "flexSwitchCheckDefault";
        input.setAttribute('list-id', tasks[i]._id)
        input.setAttribute('onclick', 'updateTask(this);');
        var label = document.createElement("label");
        div.appendChild(label);
        label.classList.add("form-check-label");
        label.setAttribute("for", "flexSwitchCheckDefault");
        label.innerHTML = " " + tasks[i].name;
        var deleteButton = document.createElement('button');
        div.appendChild(deleteButton);
        deleteButton.className = 'btn btn-primary'
        deleteButton.type = 'button';
        deleteButton.setAttribute("onclick", 'deleteTask(this);');
        deleteButton.setAttribute('list-id', tasks[i]._id)
        deleteButton.innerHTML = 'delete';
    }
}

async function updateTask(task) {
    var id = task.getAttribute('list-id');
    console.log(id);
    const URL = `http://localhost:3000/update-task/${id}`;
    var status;
    if (task.checked == false) {
        status = false;
    } else {
        status = true;
    }
    const res = await fetch(URL, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify({
            status: status,
        }),
    });
    console.log('checkbox')
    console.log(await res.json())
}

async function deleteTask(task) {
    var id = task.getAttribute('list-id');
    const URL = `http://localhost:3000/delete-task/${id}`;
    const res = await fetch(URL, {
        method: "DELETE",
    });
    removeAllChildNodes(document.getElementById('ul'))
    showTasks();
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}