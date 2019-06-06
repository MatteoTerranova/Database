// *************************** SELECT PROJECT 1 *****************************

var uuids = [];

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/project",
  success: displayProjects
});

function displayProjects(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var select = document.getElementById("project");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].project.title;
		uuids.push(list[i].project.uuid);
		select.add(option);
	}

}

// *************************** SELECT TASK 1 *****************************

$('#project').change(function()	{
	
	var sel = document.getElementById("project");
	var tsk = $("#task");
	tsk.find('option').remove();
	var ind = sel.selectedIndex;
	console.log(ind);
	console.log(uuids[ind]);
	
	// Ajax request
	$.ajax({
	  contentType: "application/json; charset=utf-8",
	  url: "rest/project/" + uuids[ind] + "/task",
	  success: function(data)	{
		// Log error message
		if (data.message != null){
			console.log(data.message);
			console.log(data.message.error-code);
			console.log(data.message.error-details);
		}
			
		var select = document.getElementById("task");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var option = document.createElement("option");
			option.text = list[i].task.name;
			select.add(option);
		}
	  }
	});
	
});

// *************************** SELECT PROJECT 2 *****************************

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/project",
  success: displayProjects2
});

function displayProjects2(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var select = document.getElementById("project2");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].project.title;
		select.add(option);
	}

}

// *************************** SELECT EMPLOYEE 2 *****************************

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/employee",
  success: displayEmployees2
});

function displayEmployees2(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var select = document.getElementById("employee2");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].employee.name + " " + list[i].employee.surname;
		select.add(option);
	}

}	