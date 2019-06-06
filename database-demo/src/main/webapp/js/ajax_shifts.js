// ********* SELECT SHIFT *******************************************
// Input elements
var ss_project = document.getElementById("project3");
var ss_task = document.getElementById("task3");
var ss_employee = document.getElementById("employee3");
var ss_wage = document.getElementById("hourlywageinput");
var ss_hours = document.getElementById("hoursinput");
var ss_notes = document.getElementById("notesinput");


// Empty text note
ss_notes.value = "";

// Auxiliary elements
var ss_project_uuid = [];
var ss_task_uuid = [];
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
		
		ss_task_uuid = [];
		var select = document.getElementById("task3");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var option = document.createElement("option");
			option.text = list[i].task.name + " - level " + list[i].task.level;
			select.add(option);
			ss_task_uuid.push(list[i].task.taskuuid);
		}
		
		console.log(ss_task_uuid);
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
		ss_employee_uuid.push(list[i].employee.fiscalcode);
	}

}	

// Button function
$('#ss-button-1').click(function()	{
	
	// Retrieve all the data from the inputs
	var fcemployee = ss_employee_uuid[ss_employee.selectedIndex];
	var taskuuid = ss_task_uuid[ss_task.selectedIndex];
	var note = ss_notes.value;
	var h = ss_hours.value;
	var hwage = ss_wage.value;
	
	// Build Timestamp
	var date = new Date();
	var sec = date.getSeconds();
	if (sec < 10){
		sec = "0"+sec;
	}
	var min = date.getMinutes();
	if (min < 10){
		min = "0"+min;
	}
	var hour = date.getHours();
	if (hour < 10){
		hour = "0"+hour;
	}
	
	var year = date.getFullYear();
	var month = date.getMonth()+1;
	
	if (month < 10){
		month = "0"+month;
	}
	
	var day = date.getDate();
	if (day < 10){
		day = "0"+day;
	}
	
	var tsres = year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + sec + "+01";
	
	// DEBUG
	console.log(tsres);
	console.log(fcemployee);
	console.log(taskuuid);
	console.log(note);
	console.log(h);
	console.log(hwage);
	
	// Build Object to be sent
	innerObj = new Object();
	innerObj.fiscalcode = fcemployee;
	innerObj.taskuuid = taskuuid;
	innerObj.timestamp = tsres;
	innerObj.note = note;
	innerObj.hourlywage = hwage*1.0;
	innerObj.hours = h*1.0;
	timeSlotToBeSent.timeslot = innerObj;
	
	var jsonResTs = JSON.stringify(timeSlotToBeSent);
	
	console.log(jsonResTs);
	
	// Ajax request
	$.ajax({
		type: "POST",
		dataType: "json",
		data: jsonResTs,
		contentType: "application/json; charset=utf-8",
		url: "rest/employee/timeslot",
		success: function(data)	{
			// Log error message
			if (data.message != null){
				console.log(data.message);
				console.log(data.message.error-code);
				console.log(data.message.error-details);
			}
		}
	});
	
});



// *************************** SELECT EMPLOYEE *****************************
// All the action element
var s_startDate = document.getElementById('start-date');
var s_endDate = document.getElementById('end-date');
var s_employee = document.getElementById('employee');
var b_listShift = document.getElementById('ss-button-2');

// Save additional informations
var empuuids = [];

// Ajax request to populate project select
$.ajax({
  contentType: "application/json; charset=utf-8",
  url: "rest/employee",
  success: displayEmployees
});

// Function to populate employees
function displayEmployees(data) {
	
	// Log error message
	if (data.message != null){
		console.log(data.message);
		console.log(data.message.error-code);
		console.log(data.message.error-details);
	}
		
	var list = data["resource-list"];
	for (i = 0; i < list.length; i++) {
		var option = document.createElement("option");
		option.text = list[i].employee.name + " " + list[i].employee.surname;
		s_employee.add(option);
		
		// Fill the array with all the employee's fiscal codes
		empuuids.push(list[i].employee.fiscalcode);
	}

}


// *************************** SHOW SHIFTS TABLE *****************************

// Button function
$('#ss-button-2').click(function()	{
	
	$("#shifts tr").remove();
	$("#shifts").append("<tr><th>Project</th><th>Task</th><th>Time</th><th>Notes</th><th>Hourly Wage</th><th>Hours</th></tr>");
	var fcemp = empuuids[s_employee.selectedIndex];
	var sDate = s_startDate.value;
	var eDate = s_endDate.value;
	console.log(fcemp);
	console.log(sDate);
	console.log(eDate);
	
	// Ajax request
	$.ajax({
		contentType: "application/json; charset=utf-8",
		url: "rest/employee/timeslot/" + fcemp + "/fromdate/" + sDate + "/todate/" + eDate,
		success: function(data)	{
			// Log error message
			if (data.message != null){
				console.log(data.message);
				console.log(data.message.error-code);
				console.log(data.message.error-details);
			}
				
			var total = 0;
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
				cell3.innerHTML = list[i].timeslot.timestamp;
				cell4.innerHTML = list[i].timeslot.note;
				cell5.innerHTML = parseFloat(list[i].timeslot.hourlywage).toFixed(2);
				cell6.innerHTML = list[i].timeslot.hours;
				total += list[i].timeslot.hourlywage * list[i].timeslot.hours;	
			}
			var displayHours = document.getElementById("totalhours");
			displayHours.innerHTML = "Total wage: " + parseFloat(total).toFixed(2);;
		}
	});
	
});