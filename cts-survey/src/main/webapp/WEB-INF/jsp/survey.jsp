<!DOCTYPE html>
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
      <form id="survey" method="get" action="/endSurvey"> 
      
      
    <div id="surveyElement">
    
    </div>
    <input type="hidden" id="jsonField" name="jsonField"/>
    </form> 
	 <div id="surveyResult"></div>
	 
	 </div>
    <script src="/js/index.js"></script>
</body>

</html>