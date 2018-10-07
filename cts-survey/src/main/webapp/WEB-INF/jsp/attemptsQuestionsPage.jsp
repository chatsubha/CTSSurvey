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

<style>
div.a {
	position: relative;
	text-align: center;
	color: black;
	font-family: "Book Antiqua", Times, Serif;
	font-style: bold;
	font-size: 48px;
}

.line1 {
	width: 40%;
	height: 2px;
	background-color: DodgerBlue;
	margin: 0 auto;
}
</style>
</head>
<body style='background-color: rgba(245, 245, 245, 1);'>
	<%@include file="adminMenu.jsp"%>
	<div style="margin: 0px auto; padding: 10px; display: table;">
		<form:form method="POST" action="admin/getAttemptsByCategory"
			modelAttribute="assessment">
			<div>
				<table>
					<tr>
						<td><h4 style="margin: 0px;">Please Select Category &nbsp;</h4></td>
						<td><form:select id="mySelect" path="category"
								class="form-control"
								onchange="javascript:getMaxAttemptsPerPriorities(this)">
								<form:option value="0">Select Assessment</form:option>
								<c:forEach items="${categoryObjs}" var="lstCategories">
									<form:option label="${lstCategories.categoryName}"
										value="${lstCategories.categoryId},${lstCategories.categoryDesc},${lstCategories.cutOff}" />.
							 </c:forEach>
							</form:select></td>

					</tr>
				</table>
			</div>
		</form:form>
	</div>

	<div id="AttemptsListId"></div>


	<script>
		function getMaxAttemptsPerPriorities(object) {

			var selectBox = document.getElementById("mySelect");
			var selectedValue = selectBox.options[selectBox.selectedIndex].value;
			if(selectedValue.indexOf(',')!=-1) {
			$("#categoryId").val(selectedValue.split(',')[0]);
			var categoryId = selectedValue.split(',')[0];
			jQuery.ajax({
				type : "POST",
				url : "${home}admin/getAttemptsByCategory",
				data : {
					"categoryId" : categoryId
				},
				success : function(response) {
					$("#AttemptsListId").html(response);
				},
				error : function(e) {
					console.log("ERROR: ", e);
				}
			});
			} else {
				document.forms[0].action ="/admin/allCategory";
			    document.forms[0].submit();
			}
		}
	</script>
</body>
</html>