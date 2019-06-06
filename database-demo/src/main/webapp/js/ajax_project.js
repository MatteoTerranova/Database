
// *************************** Convert File into Base64 String *****************************
var base64String;
var contentT = 'application/pdf';
var filename;


function handleFileSelect(evt) {
  var f = evt.target.files[0]; // FileList object
  filename = f.name.substring(0, f.name.length-4);
  var reader = new FileReader();
  // Closure to capture the file information.
  reader.onload = (function(theFile) {
    return function(e) {
      var binaryData = e.target.result;
      //Converting Binary Data to base 64
      base64String = window.btoa(binaryData);
      alert('File '+ filename + ' converted to base64 successfuly!');
    };
  })(f);
  // Read in the image file as a data URL.
  reader.readAsBinaryString(f);

}



function converBase64toBlob(content, contentType) {
  contentType = contentType || '';
  var sliceSize = 512;
  var byteCharacters = window.atob(content); //method which converts base64 to binary
  var byteArrays = [
  ];
  for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
    var slice = byteCharacters.slice(offset, offset + sliceSize);
    var byteNumbers = new Array(slice.length);
    for (var i = 0; i < slice.length; i++) {
      byteNumbers[i] = slice.charCodeAt(i);
    }
    var byteArray = new Uint8Array(byteNumbers);
    byteArrays.push(byteArray);
  }
  var blob = new Blob(byteArrays, {
    type: contentType
  }); //statement which creates the blob
  return blob;
}

// *************************** DOWNLOAD FUNCTION ***************************
var blobGlob;


var downloadButton = document.getElementById("id-button-2");


downloadButton.addEventListener("click", function(){

	//base64String has to be sobstituted with the content of the document
	blobGlob = converBase64toBlob(base64String, 'application/pdf');
	
	
	var saveData = (function () {
    var a = document.createElement("a");
    document.body.appendChild(a);
    a.style = "display: none";
    return function (data, fileName) {

        var blob = data,
            url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = fileName;
        a.click();
        window.URL.revokeObjectURL(url);
    };
}());

//Name of the retrieved file
var fileName = "my-download.pdf";

saveData(blobGlob, fileName);
});



// Check for the File API support.
if (window.File && window.FileReader && window.FileList && window.Blob) {
  document.getElementById('files').addEventListener('change', handleFileSelect, false);
} else {
  alert('The File APIs are not fully supported in this browser.');
}


// *************************** SELECT PROJECT 1 *****************************

var uuids = [null];

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

var ss_task_uuid = [];

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
			
		ss_task_uuid = [];
		var select = document.getElementById("task");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var option = document.createElement("option");
			option.text = list[i].task.name + " - level " + list[i].task.level;
			select.add(option);
			ss_task_uuid.push(list[i].task.taskuuid);
		}
	  }
	});
	
});

// *************************** SELECT EMPLOYEE 2 *****************************

var emp = []

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
		emp.push(list[i].fiscalcode);
		select.add(option);
	}

}

// ****************************** REST DOCUMENT *******************************

// Create object to be sent to the server
var documentToBeSent = new Object();

// Set action on botton click
var id_document = document.getElementById("id-button-1");

// Make ajax call to server
id_document.addEventListener("click", function(event){
	
	var innerEl = new Object();
	
	var taskuuid = ss_task_uuid[document.getElementById("task").selectedIndex];
	innerEl.taskuuid = taskuuid;
	
	var producer = emp[document.getElementById("employee2").selectedIndex];
	innerEl.producer = producer;
	
	innerEl.content = base64String;
	
	innerEl.name = filename;
	
	innerEl.uuid = "-";
	
	documentToBeSent.document = innerEl;
	
	// Prevent default behaviour
	event.preventDefault();
	
	// Check if id missing something!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	var jsonToBeSent = JSON.stringify(documentToBeSent);
	
	$.ajax({
		type: "POST",
		dataType: "json",
		data: jsonToBeSent,
		contentType: "application/json; charset=utf-8",
		url: "rest/document",
		success: alert("Object Sent to server!")
	});
});	

// *************************** SELECT PROJECT 2 *****************************

// Create object to be sent to the server
var documentToBeReceived = new Object();

var uuids2 = [null];

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
		uuids2.push(list[i].project.uuid);
		select.add(option);
	}

}

// *************************** SELECT TASK 2 *****************************

var tsks2 = [];

$('#project2').change(function()	{
	
	var sel = document.getElementById("project2");
	var tsk = $("#task2");
	tsk.find('option').remove();
	var ind = sel.selectedIndex;
	console.log(ind);
	console.log(uuids2[ind]);
	
	// Ajax request
	$.ajax({
	  contentType: "application/json; charset=utf-8",
	  url: "rest/project/" + uuids2[ind] + "/task",
	  success: function(data)	{
		// Log error message
		if (data.message != null){
			console.log(data.message);
			console.log(data.message.error-code);
			console.log(data.message.error-details);
		}
			
		var select = document.getElementById("task2");
		var list = data["resource-list"];
		for (i = 0; i < list.length; i++) {
			var option = document.createElement("option");
			option.text = list[i].task.name + " - level " + list[i].task.level;
			tsks2.push(list[i].task.taskuuid);
			select.add(option);
		}
	  }
	});
	
});

$('#task2').change(function()	{
	
	var sel = document.getElementById("task2");
	var ind = sel.selectedIndex;
	documentToBeReceived.task = tsks2[ind];
	console.log(ind);
	console.log("Selected Task ID: " + tsks2[ind]);
	console.log(documentToBeReceived.task);
	
});

// Set action on botton click
var id_document2 = document.getElementById("id-button-2");

// Make ajax call to server
id_document2.addEventListener("click", function(event){
	
	// Prevent default behaviour
	event.preventDefault();
	
	$.ajax({
		type: "GET",
		contentType: "application/json; charset=utf-8",
		url: "rest/document/" + documentToBeReceived.task,
		success: alert("Object Retrieved from the server!")
	});
});