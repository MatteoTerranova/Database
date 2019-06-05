/* (function() {
  var httpRequest;
  document.getElementById('ajaxButton').addEventListener('click', makeRequest);

  function makeRequest() {

    var salary = document.getElementsByName('project')[0].value;

    var url = 'http://localhost:8080/ennedue-demo-1.00/rest/project' + salary;

    httpRequest = new XMLHttpRequest();

    if (!httpRequest) {
      alert('Giving up :( Cannot create an XMLHTTP instance');
      return false;
    }
    httpRequest.onreadystatechange = alertContents;
    httpRequest.open('GET', url);
    httpRequest.send();
  }

  function alertContents() {
    if (httpRequest.readyState === XMLHttpRequest.DONE) {
      
      if (httpRequest.status == 200) {


        var div = document.getElementById('results');
        var table = document.createElement('table');

        var thead = document.createElement('thead');

        var tr = document.createElement('tr');

        var th = document.createElement('th');
        th.appendChild(document.createTextNode('Badge'));
        tr.appendChild(th);

        var th = document.createElement('th');
        th.appendChild(document.createTextNode('Surname'));
        tr.appendChild(th);

        var th = document.createElement('th');
        th.appendChild(document.createTextNode('Age'));
        tr.appendChild(th);

        var th = document.createElement('th');
        th.appendChild(document.createTextNode('Salary'));
        tr.appendChild(th);

        thead.appendChild(tr);
        table.appendChild(thead);

        var tbody = document.createElement('tbody');
        
        
        var jsonData = JSON.parse(httpRequest.responseText);
        var resource = jsonData['resource-list'];

        for (var i = 0; i < resource.length; i++) {
          var employee = resource[i].employee;

          var tr = document.createElement('tr');

          var td_badge = document.createElement('td');
          td_badge.appendChild(document.createTextNode(employee['badge']));
          tr.appendChild(td_badge);

          var td_surname = document.createElement('td');
          td_surname.appendChild(document.createTextNode(employee['surname']));
          tr.appendChild(td_surname);

          var td_age = document.createElement('td');
          td_age.appendChild(document.createTextNode(employee['age']));
          tr.appendChild(td_age);

          var td_salary = document.createElement('td');
          td_salary.appendChild(document.createTextNode(employee['salary']));
          tr.appendChild(td_salary);

          tbody.appendChild(tr);
        }

        table.appendChild(tbody);

        div.appendChild(table);

      } else {
        alert('There was a problem with the request.');
      }
    }
  }
})(); */