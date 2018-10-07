<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${isAjax eq 'no'}">
<html lang="en">
<head>
<title>Assessment Portal</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <script>
 function closePopup(form) {
	 form.submit();
	 window.close();
	 window.onunload = refreshParent;
	    
	}
 function refreshParent() {
     window.opener.location.reload();
 }
 </script> 
<style>

#resultPage {
	position:absolute;
	left:35px;
	top:50px;
	width:500px;
	padding:25px;
	height:150px;	
	/* border:1px solid green;
	background-color:#F7F7F7; */
}
#exit{
	position:absolute;
	left:240px;
	width:80px;
}
 /* Remove the navbar's default rounded borders and increase the bottom margin */ 
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;      
    }
    
    /* Remove the jumbotron's default bottom margin */ 
     .jumbotron {
      margin-bottom: 0;
    }
   
    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }

	#assessemnetForm{
		position:absolute;
		left:35px;
		top:15px;	
	}
}
</style>
</head>

<body>		
	<nav class="navbar navbar-inverse">
	<div class="container-fluid" style="background-color: rgba(51, 122, 183, 1);">
	  <div class="navbar-header">
	      <a class="navbar-brand" href="/chooseAssessment" style="color: rgba(245, 245, 245, 1);">Assessment Portal</a>
	  </div>
	    <%-- <ul class="nav navbar-nav navbar-right">
	      <li><a href="/logout" style="color: rgba(245, 245, 245, 1);"><span class="glyphicon glyphicon-user"></span> Log Out</a></li>
	    </ul> --%> 
	</div>
	</nav>
</c:if>
<br/><br/><br/>

<div class="container" style="width:500px" >    
  <div class="row">    
     <div class="col-sm-0"> 
     <div>
						<c:set var="marks" value="${assessementObj.assessementPercentage}" />
						<c:choose>
							<c:when test="${marks > assessementObj.categoryCutOff}">
								<h3 align="center">Congratulation! You have scored ${marks}%</h3>
								<br/>
							</c:when>
							<c:otherwise>
								<h3 align="center">You have scored ${marks}%. Better luck next time!!</h3>
								<br/>			
							</c:otherwise>
						</c:choose>
		</div>
      <div class="panel panel-primary" style="width:500px;">     	
        <div class="panel-heading">Assessment Summary</div>
        	<div class="panel-body">        			     
        		<form:form method="POST" onsubmit="closePopup(this)" commandName="assessementObj"  action="/Exit">					
					<table class="table">
						<thead>
							<tr>
								<th>Question Id</th>
								<th>Status</th>									
							</tr>								
						</thead>
						<tbody>
							<c:forEach items="${assessementObj.resultPageMap}" var="obj">
							<c:set var="status" value="${fn:split(obj.value,':')}"/>
								<c:if test="${obj.value eq 'Correct'}">
									<tr>
										<td>${obj.key}</td>
										<td style ='color: green; font-size: 15px;'>${obj.value}</td>						
									</tr>
								</c:if>
								<c:if test="${status[0] eq  'Wrong'}">
									<tr>
										<td>${obj.key}</td>
										<td style ='font-size:15px;color: red;'>
										${status[0]} &nbsp;
										<span style="color:blue">
										<a style="cursor:pointer;"   onclick="return loadCorrectQstn(${status[1]},${obj.key})">
										Click here</a>&nbsp; for correct answer</span> 
										</td>
									</tr>
								</c:if>
								<c:if test="${obj.value eq 'Unanswered'}">
									<tr>
										<td>${obj.key}</td>
										<td style ='font-size:15px; color: DarkTurquoise;	'>${obj.value}</td>
									</tr>
								</c:if>
							</c:forEach>								
						</tbody>
						</table>
						<input type="submit" value="Exit" name="Exit" style="left: 180px; width: 90px; position: relative;"  class="btn btn-primary">					
				</form:form>
        </div>        
      </div>
    </div>   
  </div>
  
    <c:if test="${isAjax eq 'no'}">
</body>
</html>
</c:if>