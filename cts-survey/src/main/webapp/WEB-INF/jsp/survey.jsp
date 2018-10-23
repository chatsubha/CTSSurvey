<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en">

<head>
    <title>Welcome to CTS survey </title>
    <script src="/js/jquery.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
</script>
   <script src="/js/survey.jquery.js"></script>
        <link href="/css/survey.css" type="text/css" rel="stylesheet"/>
        <link rel="stylesheet" href="/css/index.css">
		 <link href="/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/narrow.css" rel="stylesheet">
    <!-- <link rel="stylesheet" href="https://unpkg.com/bootstrap@3.3.7/dist/css/bootstrap.min.css"> -->
</head>

<body>
   <div class="container">
      <div class="header clearfix" style="width:100%">
        <nav>
          <ul class="nav nav-pills float-right">
            <li class="nav-item">
              <a class="nav-link active" href="welcomePage.html">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">About</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Contact</a>
            </li>
          </ul>
        </nav>
        <h3 class="text-muted">Cognizant Survey App - Demo V0.1</h3>
      </div>
      <form id="survey" method="post" action="/endSurvey"> 
      
      
    <div id="surveyElement">
    
    </div>
    <input type="hidden" id="jsonField" name="jsonField"/>
    </form> 
	 <div id="surveyResult"></div>
	 
	 </div>
	 <script> 
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
			      }
			      <c:if test="${sessionScope.contactForm.role eq 'TL' }">
			      ,
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
			      </c:if>
			    ]
			  };
	 </script>
	 
    <script src="/js/index.js?v=0.1"></script>
</body>

</html>