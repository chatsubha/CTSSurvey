<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
<head>
<title>Assessment Portal</title>
</head>
<style>

body {
    background: #488;
}

.content {
    max-width: 500px;
    margin: auto;
    background: white;
    padding: 10px;
}

h2 {
	text-align:center;
	color: blue;
}

#box
{
   	align: center;
   	width: 1500px;
    height: 650px;
   	border: 1px solid rgb(200, 200, 200);
	box-shadow: rgba(0, 0, 0, 0.1) 0px 5px 5px 2px;
	background: rgba(200, 200, 200, 0.1);
	border-radius: 10px;
	top:100px;
}

</style>
<body>
<div class="content">
     <h1>Assessment Portal Application</h1>
      
     <div style="border:1px solid black">
     <h2>User Dashboard</h2>
     
  
	 Welcome ${username}!! Please select your assessment.


     <br/>
        <form method="post" action = "/assessment/result">
        <br>
        
        <input type="submit" value= "View Result"/> <br>
        <font color="red">${errorMessage}</font>
     </form>
     </div>
</div>
</body>
</html>