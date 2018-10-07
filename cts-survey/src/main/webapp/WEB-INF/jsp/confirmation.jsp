<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<c:if test="${isAjax eq 'no'}">
<html lang="en">
<head>
<title>Assessment Portal</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%
String timer = request.getParameter( "countdown" );
if( timer == null ) timer = "0";
%>
<style>
#resultPage {
	position: absolute;
	left: 35px;
	top: 50px;
	width: 500px;
	padding: 25px;
	height: 150px;
	/* border:1px solid green;
	background-color:#F7F7F7; */
}

#exit {
	position: absolute;
	left: 240px;
	width: 80px;
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

#assessemnetForm {
	position: absolute;
	left: 35px;
	top: 15px;
}
}
</style>
</head>

<body>
	<nav class="navbar navbar-inverse">
	<div class="container-fluid"
		style="background-color: rgba(51, 122, 183, 1);">
		<div class="navbar-header">
			<a class="navbar-brand" href="/chooseAssessment"
				style="color: rgba(245, 245, 245, 1);">Assessment Portal</a>
		</div>
		<%-- <ul class="nav navbar-nav navbar-right">
			<li><a href="/logout" style="color: rgba(245, 245, 245, 1);"><span
					class="glyphicon glyphicon-user"></span> Log Out</a></li>
		</ul>--%>
	</div>
	</nav>

	<br />
	<br />
	<br />
	<div class="container" style="width: 500px">
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-0">
				<div class="panel panel-primary" style="width: 500px;">
					<div class="panel-heading">Assessment Summary</div>
					<div class="panel-body">
						<form:form method="POST" commandName="assessementObj" action="finishAssessement" name="confirmPage">
						<input type="hidden" name="timer" id="timer">		
						<input type="hidden" name="countdown" class="countdown" id="countdown" readonly>
							<table class="table">
								<thead>
									<tr>
										<th>Question Id</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${assessementObj.userAnsMap}" var="obj">
										<tr>
											<td>
											<form id="frm${obj.key}" action="finishAssessement">
											<a href="#" onclick="submitEq(${obj.key})">${obj.key}</a>
											<input type="hidden" value="BTEQL" name="action"/>
											<input type="hidden" value="${obj.key}" name="questionNumber"/>
											</form>
											</td>
											<td>
												<c:if test="${empty obj.value}">
									   				<span  style ='font-size:15px;color: red;'>Not Answered</span>
										        </c:if> 
										        <c:if test="${not empty obj.value}">
									   			 <span  style ='font-size:15px;'>Answered</span>
										        </c:if>
										    </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="error">
							<center><p style="color: red">${error}</p></center>
							</div>
							<input type="submit" name="action" value="Submit" class="btn btn-primary" style="float:right;"/>
							<input type="submit" name="action" value="Go Back" class="btn btn-primary"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
<script>

//Time Format : "01:01:08";
var timer2 = "<%=timer%>"; // write time to javascript

if(timer2 ==0){
	timer2 = document.getElementById("time").value;
}

document.confirmPage.countdown.value = timer2; 
document.getElementById("countdown1").innerText = timer2;
</script>
</body>
</html>
</c:if>
<c:if test="${isAjax eq 'yes'}">
<div class="container" style="width: 500px">
		<div class="row">
			<div class="col-sm-4"></div>
			<div class="col-sm-0">
				<div class="panel panel-primary" style="width: 500px;margin-top:25%">
					<div class="panel-heading">Assessment Summary</div>
					<div class="panel-body">
						<form:form method="POST" onsubmit="return submitHandle()" commandName="assessementObj" id="confirmPage" action="finishAssessement" name="confirmPage">
						<input type="hidden" name="timer" id="timer">		
						<input type="hidden" name="countdown" class="countdown" id="countdown" readonly>
							<table class="table">
								<thead>
									<tr>
										<th>Question Id</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${assessementObj.userAnsMap}" var="obj">
										<tr>
											<td>
											<label class="label label-warning" style="cursor:pointer;" onclick="return submitEq(${obj.key})"><a href="#">${obj.key}</a></label>
											</td>
											<td>
												<c:if test="${empty obj.value}">
									   				<span  style ='font-size:15px;color: red;'>Not Answered</span>
										        </c:if> 
										        <c:if test="${not empty obj.value}">
									   			 <span  style ='font-size:15px;'>Answered</span>
										        </c:if>
										    </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="error">
							<center><p style="color: red">${error}</p></center>
							</div>
							<input type="submit" onclick="submitForm2($(this))" name="action" value="Submit" class="btn btn-primary" style="float:right;"/>
							<input type="submit" onclick="submitForm2($(this))" name="action" value="Go Back" class="btn btn-primary"/>
						</form:form>
					</div>
				</div>
			</div>
		</div>
		</div>
</c:if>