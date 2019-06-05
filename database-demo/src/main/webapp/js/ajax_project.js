// *************************** SELECT PROJECT 1 *****************************

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
		select.add(option);
	}

}	

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


// *************************** SELECT EMPLOYEE *****************************

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/employee",
  success: displayEmployees
});

function displayEmployees(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var select = document.getElementById("employee");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].employee.name + " " + list[i].employee.surname;
		select.add(option);
	}

}	

// *************************** TABLE ACTIVE PROJECTS *****************************

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/project/active",
  success: displayActiveProjects
});

function displayActiveProjects(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var table = document.getElementById("activeprojects");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var row = table.insertRow(1);
		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);
		var cell5 = row.insertCell(4);
		var cell6 = row.insertCell(5);
		cell1.innerHTML = list[i].project.title;
		cell2.innerHTML = list[i].project.location;
		cell3.innerHTML = list[i].project.startdate;
		cell4.innerHTML = list[i].project.deadline;
		cell5.innerHTML = list[i].project.estimatedhours;
		cell6.innerHTML = list[i].project.hoursspent;
	}

}	