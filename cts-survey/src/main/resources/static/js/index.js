function init() {
  

  window.survey = new Survey.Model(json);
  survey.onComplete.add(function(result) {
    //document.querySelector("#surveyResult").innerHTML =
      //"result: " + JSON.stringify(result.data);
	
	  exportCSVFile('',result.data,"sample");
	  $("#jsonField").val(JSON.stringify(result.data));
	  $("#survey").submit();
  });

  $("#surveyElement").Survey({
    model: survey
  });
}

if (!window["%hammerhead%"]) {
  init();
}

function convertToCSV(objArray) {
    
    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
    var str = '';
    
	var line = '';
	for(item in array) {
	
	if (line != '') line += ',';
	line +=  item;
	 
	}
	str += line + '\r\n';
    line = '';	
	for(item in array) {
	 
	if (line != '') line += ',';
	
	if (typeof array[item] != 'object') {
	line +=  array[item];
	} else {
	line += convertObjectToJson(array[item]);
	}
	
	 
	};
    str += line + '\r\n';   

    return str;
}

function convertObjectToJson(objArray) {
    
    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
    var str = '';
    
	var line = '';
	
	
	for(item in array) {
	 
	if (line != '') line += ',';
	
	if (typeof array[item] != 'object') {
	line +=  item+':'+array[item];
	} else {
	line += convertToCSV(array[item]);
	}
	
	 
	};
    str += line;

    return str;
}

var headers = {
    model: 'Phone Model'.replace(/,/g, ''), // remove commas to avoid errors
    chargers: "Chargers",
    cases: "Cases",
    earphones: "Earphones"
};

function exportCSVFile(headers, items, fileTitle) {
    if (headers) {
        items.unshift(headers);
    }

    // Convert Object to JSON
    var jsonObject = JSON.stringify(items);;
    alert(jsonObject);
    var csv = this.convertToCSV(jsonObject);

    var exportedFilenmae = fileTitle + '.csv' || 'export.csv';

    var blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    if (navigator.msSaveBlob) { // IE 10+
        navigator.msSaveBlob(blob, exportedFilenmae);
    } else {
        var link = document.createElement("a");
        if (link.download !== undefined) { // feature detection
            // Browsers that support HTML5 download attribute
            var url = URL.createObjectURL(blob);
            link.setAttribute("href", url);
            link.setAttribute("download", exportedFilenmae);
            link.style.visibility = 'hidden';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
    }
}
