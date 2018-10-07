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
	padding: 6px 19px;
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
				<h2 style="align: center;">Forgot Password?</h2>
				<hr>


				<form:form id="box1" method="post" action="fetchPswd"
					commandName="userForm" class="form-horizontal">
					<fieldset>
						<div class="form-group">
							<label class="control-label col-md-2" for="user_name">User Name
							</label>
							<div class="col-md-10" style="padding: 0px 16px 0px 0px;">
								<form:input path="user_name" type="text" class="form-control"
									onfocusout="test();" name="securityAns"
									placeholder="Enter your User Name" required="required" />
								<form:errors path="user_name" />
							</div>
						</div>

						<div id="errorMsg" class="error"></div>

						<div class="form-group">
							<label class="control-label col-md-2" for="userSecurtiyQuest">Security
								Question </label>
							<div class="col-md-10" style="padding: 0px 16px 0px 0px;">
								<input name="userSecurtiyQuest" type="text" class="form-control"
									name="securityAns" placeholder="Your Security Question"
									value='<c:out value="${userForm.userSecurtiyQuest}"></c:out>'
									disabled="true">
								<p
									style="color: Crimson; font-style: italic; font-weight: bold;">${invalidQuest}</p>
							</div>
						</div>


						<div class="form-group">
							<label class="control-label col-md-2" for="securityAns">Security
								Answer </label>
							<div class="col-md-10" style="padding: 0px 16px 0px 0px;">
								<form:input id="securityAns" type="text" class="form-control"
									path="securityAns" name="securityAns"
									placeholder="Your Security Answer" onchange="invalidAns();" />

								<form:errors path="securityAns" />
							</div>
						</div>

						<div align="right">

							<c:if test="${userForm.validAndFlg == true}">
								<p style="color: red;">Invalid Details. Please fill out the
									required details correctly.</p>
							</c:if>

							<c:if test="${not empty invalidAns}">
								<p align="right" style="color: red;"></p>
							</c:if>
						</div>
						<br>
						<div class="row">
							<div class="col-sm-offset-8 col-xs-6 col-sm-6 col-md-6"
								style="align: right;">
								<button id="confirm" type="submit" name="confirm"
									class="btn btn-primary" value="Submit">Submit</button>

								<button id="confirm" type="button" name="cancel" action="action"
									class="btn btn-primary" value="Cancel"
									onClick="window.location='http://localhost:8080/';">Cancel</button>

							</div>
						</div>
						<p id="invalid"
							style="align: right; color: red; font-style: italic; font-weight: bold; display: none;">${invalidAns}</p>
					</fieldset>
				</form:form>
			</div>
		</div>
	</div>



</body>

<script>
	function myFunction() {
		var id = document.getElementById('user_name').value;
		if (id != "") {
			document.getElementById("box1").action = "/fetchUserQuest";
			document.getElementById('errorMsg').innerHTML = "Click submit";
			return true;
		} else {
			document.getElementById('errorMsg').innerHTML = "Enter a valid User Id";
			return false;
		}
	}

	function clear() {
		document.getElementById("user_name").reset();
		document.getElementById("securityAns").reset();
	}

	function test() {
		document.getElementById("box1").action = "/fetchUserQuest";
		document.getElementById("box1").submit();
	}

	function invalidAns() {

		if (document.getElementById("securityAns").value != document
				.getElementById("secAns").value) {
			document.getElementById("invalid").style.display = 'block';
		} else {
			document.getElementById("invalid").style.display = 'none';
		}
	}
</script>
</html>