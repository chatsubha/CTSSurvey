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

</head>
<style>
#box {
	border: 1px solid rgb(200, 200, 200);
	box-shadow: rgba(0, 0, 0, 0.1) 0px 5px 5px 2px;
	background: rgba(200, 200, 200, 0.1);
	border-radius: 4px;
	top: 80px;
}

.col-md-10 {
	width: 68%;
}

.col-md-2 {
	width: 32%;
}

h2 {
	text-align: center;
}

.error {
	color: red;
	font-style: italic;
	font-weight: unset;
	font-size: smaller;
}

p {
	margin: 0 0 0px;
}

.btn {
    display: inline-block;
    padding: 6px 20px;
    }
</style>
<body>
	<div class="container-fluid text-center"
		style="background-color: rgba(51, 122, 183, 1);">
		<div class="container" style="margin-left:-28%">
			<h3 style="color: rgba(245, 245, 245, 1);">Assessment Portal</h3>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-4 col-md-offset-4" id="box">
				<h2 style="align: center;">Change Password!</h2>
				<hr>


			<form:form id="box2" method="post" action="resetpassword"
				commandName="userForm" onsubmit="return validate();" class="form-horizontal">
				<fieldset>

					<div class="form-group">
						<br> <label class="control-label col-md-2" for="password">New Password :</label>
						<div class="col-md-10" style="padding: 0px 16px 0px 0px;">
						<form:input id="password" path="password" type="password"
							class="form-control" name="password" required="required" />
						<form:errors path="password" cssClass="error" />
						</div>
					</div>

					<br>

					<div id="errorMsg" class="error"></div>

					<div class="form-group">
						<label class="control-label col-md-2" for="password">Confirm Password :</label>
						<div class="col-md-10" style="padding: 0px 16px 0px 0px;">
						<form:input id="confirmpassword" type="password"
							class="form-control" onchange='validate();'
							path="confirmpassword" name="confirmpassword" required="required" />
							</div>
					</div>
					<p id='message' align="right"> </p>

					<form:errors path="securityAns" />
					<br>
					
					<div class="row">
						<div class="col-sm-offset-8 col-xs-6 col-sm-6 col-md-6"
							style="align: right;">
							<button id="submit" type="submit" name="confirm"
								class="btn btn-primary" value="Submit">Submit</button>

							<button id="cancel" type="button" name="confirm" action="action"
								class="btn btn-primary" value="Cancel"
								onClick="window.location='http://localhost:8080/';">Cancel</button>

						</div>
					</div>
					<br>

					
					
				</fieldset>
			</form:form>


			<br>
		</div>


	</div>
</body>

<script>
	function validate() {
		
		if(document.getElementById('password').value == document.getElementById('confirmpassword').value){
			document.getElementById('message').innerHTML = "Passwords matching!";
			document.getElementById('message').style.color = 'green';
			//document.getElementById('message').innerHTML = 'matching';
			document.getElementById('submit').disabled = false;
			return true;
		} else {
			//document.getElementById('errorMsg').innerHTML = "Passwords not match";
			document.getElementById('message').style.color = 'red';
			document.getElementById('message').innerHTML = 'Passwords not matching!';
			document.getElementById('submit').disabled = true;
			return false;
		}
	}

</script>
</html>