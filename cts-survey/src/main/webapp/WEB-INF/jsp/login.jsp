<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Assessment Portal - Login</title>
<link rel="stylesheet" type="text/css" href="styles.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script>
	$(document).ready(function() {
		function disableBack() {
			window.history.forward()
		}
		window.onload = disableBack();
		window.onpageshow = function(evt) {
			if (evt.persisted)
				disableBack()
		}
	});
	function checkUserId() {
		if(!$('#name').val().includes("@cognizant.com")) {
			$('#name').val($('#name').val()+'@cognizant.com')
		}	
	}
	
</script>
</head>
<style>
body {
	background: #488;
}

label {
	display: inline-block;
	max-width: 100%;
	margin-bottom: 5px;
	font-family: "Book Antiqua", Times, Serif;
	font-weight: 700;
	font-size: larger;
}

input {
	line-height: normal;
	width: 250px;
	height: 25;
}
a {
    color: #337ab7;
    text-decoration: none;
    font-size: medium;
    font-family: "Book Antiqua", Times, Serif;
    }
.btn {
	padding: 8px 16px;
	font-size: 16px;
	width: 200;
	height: 35;
}

div.a {
	position: relative;
	text-align: center;
	color: black;
	font-family: "Book Antiqua", Times, Serif;
	font-style: bold;
	font-size: 48px;
}

.content {
	max-width: 800px;
	margin: auto;
	background: white;
	padding: 10px;
}

h2 {
	text-align: center;
}

#box {
	margin: 0px auto;
	width: 500px;
	height: 300px;
	border: 1px solid rgb(23, 53, 97);
	box-shadow: 5px 5px 5px 2px rgba(0, 0, 0, 0.5);
	background: rgba(200, 200, 200, 0.1);
	border-radius: 10px;
	top: 100px;
}

form {
	align-content: center;
	text-align: center;
	margin-left: 100px;
}
input::placeholder{
	color:#999;
}
</style>
<body>
	<div style="height: 100%; background-color: rgba(245, 245, 245, 1);">
		<div class="container-fluid text-center"
			style="background-color: rgba(51, 122, 183, 1);">
			<div class="container" style="margin-left:-28%">
				<h3 style="color: rgba(245, 245, 245, 1);">Assessment Portal</h3>
			</div>
		</div>

		<div style="margin: 150px;">
			<h2>Login</h2>
			<form:form class="form-horizontal" action="login" method="post" id="box"
				commandName="userForm" onsubmit="return checkUserId()">
				<br>
				<br>
				<fieldset>
				<div class="form-group">
					<label class="control-label col-md-5" for="name" align="right" >User Name </label>
					<div class="col-md-5">
					<input id="name" type="text" name="name" required
						data-toggle="popover" data-content="Category Name required" placeholder="Enter Cognizant id" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-5" for="password" align="right">Password </label>
					<div class="col-md-5">
					<input id="password" type="password" name="password" required
						data-toggle="popover" data-content="Category Name required" placeholder="Enter Password" class="form-control" />
					</div>
				</div>
				<br>
				<div class="form-group">
				<input type="submit" value="Login" class="btn btn-primary"/>
				</div>
				<div class="panel-header">
					<br>
					<%-- <ul class="list-inline" align="right">
						<li><a href="registrationForm">Register</a></li>
						<%-- <li><a href="forgetPassword">Forgot Password?</a></li>--%>
					<%--</ul>--%>
				</div>

				<div align="center">
					<font color="red">${errorMessage}</font>
					<c:if test="${not empty successMsg}">
						<p style="color: green; font-style: italic; font-weight: bold;">${successMsg}
							Please login to continue.</p>
					</c:if>
					<c:if test="${not empty pwdchanged}">
						<p style="color: green; font-style: italic; font-weight: bold;">${pwdchanged}
							Please login.</p>
					</c:if>
				</div>
				</fieldset>
			</form:form>

		</div>


	</div>
</body>


<script type="text/javascript">
	$('[data-toggle="popover"]').click(function() {
		$("#name").popover('destroy');
		$("#password").popover('destroy');
	});
</script>
</html>
