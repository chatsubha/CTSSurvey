function init() {
  var json = {
    title: "Cognizant Survey Sample question",
    showProgressBar: "top",
    pages: [
      {
        questions: [
          {
            type: "matrix",
            name: "Quality",
            title:
              "Please indicate if you agree or disagree with the following statements",
            columns: [
              { value: 1, text: "Strongly Disagree" },
              { value: 2, text: "Disagree" },
              { value: 3, text: "Neutral" },
              { value: 4, text: "Agree" },
              { value: 5, text: "Strongly Agree" }
            ],
            rows: [
              { value: "affordable", text: "Product is affordable" },
              {
                value: "does what it claims",
                text: "Product does what it claims"
              },
              {
                value: "better then others",
                text: "Product is better than other products on the market"
              },
              { value: "easy to use", text: "Product is easy to use" }
            ]
          },
          {
            type: "rating",
            name: "satisfaction",
            title: "How satisfied are you with the Product?",
            mininumRateDescription: "Not Satisfied",
            maximumRateDescription: "Completely satisfied"
          },
          {
            type: "rating",
            name: "recommend friends",
            visibleIf: "{satisfaction} > 3",
            title:
              "How likely are you to recommend the Product to a friend or co-worker?",
            mininumRateDescription: "Will not recommend",
            maximumRateDescription: "I will recommend"
          },
          {
            type: "comment",
            name: "suggestions",
            title: "What would make you more satisfied with the Product?"
          }
        ]
      },
      {
        questions: [
          {
            type: "radiogroup",
            name: "price to competitors",
            title: "Compared to our competitors, do you feel the Product is",
            choices: [
              "Less expensive",
              "Priced about the same",
              "More expensive",
              "Not sure"
            ]
          },
          {
            type: "radiogroup",
            name: "price",
            title: "Do you feel our current price is merited by our product?",
            choices: [
              "correct|Yes, the price is about right",
              "low|No, the price is too low for your product",
              "high|No, the price is too high for your product"
            ]
          },
          {
            type: "multipletext",
            name: "pricelimit",
            title: "What is the... ",
            items: [
              {
                name: "mostamount",
                title: "Most amount you would every pay for a product like ours"
              },
              {
                name: "leastamount",
                title: "The least amount you would feel comfortable paying"
              }
            ]
          }
        ]
      },
      {
        questions: [
          {
            type: "text",
            name: "email",
            title:
              "Thank you for taking our survey. Your survey is almost complete, please enter your email address in the box below if you wish to participate in our drawing, then press the 'Submit' button."
          }
        ]
      }
    ]
  };

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
