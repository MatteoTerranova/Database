// *************************** SELECT PROJECT *****************************

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
		option.text = list[i].title;
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
		option.text = list[i].name + " " + list[i].surname;
		select.add(option);
	}

}	