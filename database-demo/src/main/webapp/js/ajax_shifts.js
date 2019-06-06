// ********* SELECT SHIFT *******************************************
var ss_project = document.getElementById("project3");
var ss_project_uuid = [];
var ss_task = document.getElementById("task3");
var ss_task_uuid = [];
var ss_employee = document.getElementById("employee3");
var ss_employee_uuid = [];

var uuids3 = [null];

var timeSlotToBeSent = new Object();

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/project",
  success: displayProjects3
});

function displayProjects3(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}

	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].project.title;
		uuids3.push(list[i].project.uuid);
		ss_project.add(option);
	}

}

// *************************** SELECT TASK *****************************

$('#project3').change(function(){
	
	var sel = document.getElementById("project3");
	var tsk = $("#task3");
	tsk.find('option').remove();
	var ind = sel.selectedIndex;
	console.log(ind);
	console.log(uuids3[ind]);
	
	// Ajax request
	$.ajax({
	  contentType: "application/json; charset=utf-8",
	  url: "rest/project/" + uuids3[ind] + "/task",
	  success: function(data)	{
		// Log error message
		if (data.message != null){
			console.log(data.message);
			console.log(data.message.error-code);
			console.log(data.message.error-details);
		}
			
		var select = document.getElementById("task3");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var option = document.createElement("option");
			option.text = list[i].task.name + " - level " + list[i].task.level;
			select.add(option);
		}
	  }
	});
	
});

// *************************** SELECT EMPLOYEE 3 *****************************

// Ajax request
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/employee",
  success: displayEmployees3
});

function displayEmployees3(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var select = document.getElementById("employee3");
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].employee.name + " " + list[i].employee.surname;
		select.add(option);
	}

}	

var empuuids = [];

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
		empuuids.push(list[i].employee.fiscalcode);
		select.add(option);
	}

}

// *************************** SHOW SHIFTS TABLE *****************************

$('#employee').change(function()	{
	
	var sel = document.getElementById("employee");
	var tsk = $("#shifts");
	//tsk.find('option').remove();		CHECK REMOVE TABLE
	var ind = sel.selectedIndex;
	console.log(ind);
	console.log(empuuids[ind]);
	
	// Ajax request
	$.ajax({
	  contentType: "application/json; charset=utf-8",
	  url: "rest/employee/timeslot/" + empuuids[ind] + "/fromdate/" + startdate + "/todate/" + enddate,
	  success: function(data)	{
		// Log error message
		if (data.message != null){
			console.log(data.message);
			console.log(data.message.error-code);
			console.log(data.message.error-details);
		}
			
		var table = document.getElementById("shifts");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var row = table.insertRow(1);
			var cell1 = row.insertCell(0);
			var cell2 = row.insertCell(1);
			var cell3 = row.insertCell(2);
			var cell4 = row.insertCell(3);
			var cell5 = row.insertCell(4);
			var cell6 = row.insertCell(5);
			cell1.innerHTML = list[i].timeslot.title;
			cell2.innerHTML = list[i].timeslot.template;
			cell3.innerHTML = list[i].timeslot.time;
			cell4.innerHTML = list[i].timeslot.notes;
			cell5.innerHTML = list[i].timeslot.hourlywage;
			cell6.innerHTML = list[i].timeslot.hours;
		}
	  }
	});
	
});