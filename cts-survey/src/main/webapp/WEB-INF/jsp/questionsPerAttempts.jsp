<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Assessment Portal</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<c:url var="home" value="/" scope="request" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css">
<c:url var="home" value="/" scope="request" />

</head>
<body style='background-color: rgba(245, 245, 245, 1);'>
	<%
		String categoryId = (String) request.getAttribute("categoryId");
		String checkEntry = (String) request.getAttribute("checkEntry");
	%>
	<form:form action="admin/saveQuestionsPerAttempt" method="POST"
		id="questionsSubId" modelAttribute="adminForm" name="questionsSub">
		<input type="hidden" name="categoryId" id="categoryId"
			value='<%=categoryId%>' />
		<input type="hidden" name="chkEntryId" id="chkEntryId"
			value='<%=checkEntry%>' />
		<table id="attemptsId" class="table table-hover">
			<tr>
				<th>Attempts</th>
				<th>Total Number Of Questions</th>
				<c:forEach items="${adminForm.complexityHeaderLst}"
					var="complexitiesHeader" varStatus="complexitiesStatusHeader">
					<th>${complexitiesHeader.complexityName}</th>
				</c:forEach>
				<th>Time To Complete <br /> Each Attempts (HH:MM:SS)
				</th>
			</tr>

			<c:forEach items="${adminForm.maxAttemptsList}" var="attempts"
				varStatus="attemptStatus">
					<form:hidden path = "totalAttempts" value = "${attempts.attemptsId}" />
				<tr>
					<td>${attempts.attemptsDesc}</td>
					<td>${attempts.questionDesc} <form:input
							path="maxAttemptsList[${attemptStatus.index}].questionsId" id="questionsPerAttemptsID${attemptStatus.index}"/>
					</td>
					<c:forEach items="${adminForm.complexityHeaderLst}"
						var="complexities" varStatus="complexitiesStatus">
						<td><form:input
								path="maxAttemptsList[${attemptStatus.index}].maxComplexity[${ complexitiesStatus.index}].percentageValues" />
							%</td>
					</c:forEach>
					<td><form:input
							path="maxAttemptsList[${attemptStatus.index}].timePerAttempt" /></td>
				</tr>

			</c:forEach>
		</table>
		<div class="modalContainer" style="background-color: #f1f1f1"
			align="center">
			<button class="btn btn-primary" type="button"
				onclick="onClickCancelBtn()">Cancel</button>
			<button class="btn btn-primary" id="btnSubmit" type="submit">Submit</button>
		</div>
	</form:form>

	<div class="modalContainer" id="responseDesc" align="center"></div>

</body>

<script type="text/javascript">
	function onClickCancelBtn() {
		var urlAction = "${home}admin/gotoAdmin";
		$('#questionsSubId').attr("action", urlAction);
		document.forms["questionsSub"].submit();
	}
	$(document).ready(function() {
		$('#questionsSubId').submit(function(e) {

			var form = this;
			e.preventDefault();
			var formData = {}
			$.each(this, function(i, v) {
				var input = $(v);
				formData[input.attr("name")] = input.val();
			});

			jQuery.ajax({
				type : "POST",
				url : "${home}admin/saveQuestionsPerAttempt",
				data : formData,
				success : function(responseObj) {
					if(responseObj.errorCode==200) {
						document.getElementById("responseDesc").style.color = "green";
						document.getElementById("responseDesc").style.fontWeight = "bolder";
					} else {
						document.getElementById("responseDesc").style.color = "red";
						document.getElementById("responseDesc").style.fontWeight = "bolder";
					}
					$("#responseDesc").html(responseObj.responseValue.replace(/\n/g,'<br/>'));
				},
				error : function(e) {
					console.log("ERROR: ", e);
				}
			});
		});
	});
</script>
</html>
