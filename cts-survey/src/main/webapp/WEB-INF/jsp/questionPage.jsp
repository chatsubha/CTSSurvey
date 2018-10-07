<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="customtag" uri="/WEB-INF/tld/lookuptabledesc.tld"%>
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

<link rel="stylesheet" href="../css/jquery-ui.css">
<script src="../js/applicationScripts.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style type="text/css">

/* Modal Content/Box */
.modal-content-questions {
	background-color: #fefefe;
	margin: 10% auto 15% auto;
	width: 41%; //
	margin: 5% auto 15% auto;
	/* 5% from the top, 15% from the bottom and centered */ //
	border: 1px solid #888;
	/* width: 60%; */
	/*width: 35%;
	border-color: black;
	border-style: solid;
	border-width: medium;*/
}

.headerText {
	padding-top: 1px;
}
</style>

</head>
<body>
	<div align="left">
		<table>
			<tr>
				<td><h5>List of Questions for the selected Category &nbsp;</h5> </td>
				<td><h4 id="categoryName"></h4></td>
			</tr>
		</table>
	</div>
	
	<button onclick="window.location='/admin';" type="button"
			style="margin-right: 2%; float: right; width: 115px" class="btn btn-primary">
			<span class="glyphicon glyphicon-backward"></span>&nbsp;
			Back</button></br></br></br>
<div class="panel panel-info">
 <div class="panel-heading"><p><span class="glyphicon glyphicon-eye-open"></span>&nbsp;View questions </p>	</div>
    <div class="panel-body">			
	<form:form action="admin/deleteQuestion" method="post"
		modelAttribute="adminForm">
		<input type="hidden" name="questionId" id="questionId">
		<table id="question" class="table table-hover">
			<tr>
			    <th>Question ID </th>
				<th>Question Description</th>
				<th>Answer Type</th>
				<th>Complexity</th>
				<th>Action</th>
			</tr>

			<c:forEach items="${adminForm.questionList}" var="question">
				<tr>
				    <td>${question.questionId}</td>
					<td>${question.questionDesc}</td>
					<td>
						<%--${question.answerType}--%> <customtag:lookupDesc
							whereCondition="ANSWER_TYPE_ID = ${question.answerType}"
							columnName="ANSWER_TYPE" tableName="AP.TBLANSWERTYPELOOKUP" />
					</td>
					<td>
						<%--${question.complexity}--%>
						<customtag:lookupDesc
							whereCondition="COMPLEXITY = ${question.complexity}"
							columnName="DESCRIPTION" tableName="AP.TBLCOMPLEXITY" />
					</td>
					<td><a href="#assa"
						onclick="javascript:onClickViewOptionDetails(${question.questionId},'${question.questionDesc}')">
						<span class="glyphicon glyphicon-eye-open"></span>&nbsp;View Options</a> | <a href="#"
						onclick="javascript:loadQuestionDetails(${question.questionId},'${question.questionDesc}')">
						<span class="glyphicon glyphicon-pencil"></span>&nbsp;Edit</a> | 
						<a href="#"
						onclick="javascript:onClickDeleteQuestion(${question.questionId},'${question.questionDesc}')">
						<span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</a></td>
				</tr>
			</c:forEach>
		</table>
		<button onclick="javascript:loadQuestionDetails('','')" type="button"
			style="margin-right: 2%; float: right;" class="btn btn-primary">Add
			Question</button>
	</form:form>
	</div></div>
	<div id="questionDiv" class="modal">
		<form:form class="modal-content-questions" action="admin/addQuestion"
			method="POST" modelAttribute="adminForm" id="questionFormId"
			name="questionForm">

			<form:hidden path="question.questionId" id="questionFormQuestionId" />
			<form:hidden path="question.categoryId" id="questionFormCategoryId" />
			<div class="headerText" align="center"
				style="color: white; background-color: rgba(51, 122, 183, 1);">
				<span class="glyphicon glyphicon-remove"
					onclick="document.getElementById('questionDiv').style.display='none'"
					style="float: right; cursor: pointer;"></span>
				<h3 style="display: inline;">Question Form</h3>

			</div>
			<div align="center">
				<table>

					<!-- <tr>
						<td colspan="2"><span id="questionDescErr"
							style="color: red;"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span id="answerTypeErr" style="color: red;"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span id="complexityTypeErr"
							style="color: red;"></span></td>
					</tr> -->

					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="question.questionDesc">Question Description </form:label></td>
						<td><form:textarea path="question.questionDesc"
								class="form-control" id="questionFormQuestionDesc"
								data-toggle="popover"
								data-content="Question Description required" maxlength="500"
								style="margin-bottom: 5px;margin-top: 5px;" /></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="question.answerType">Answer Type </form:label></td>
						<td><form:select path="question.answerType"
								class="form-control" style="margin-bottom: 5px;margin-top: 5px;"
								id="questionFormAnswerType" data-toggle="popover"
								data-content="Please choose an Answer type">
								<form:option value="0" selected="">Please Select</form:option>
								<form:options items="${ansTypeList}" itemValue="answerTypeId"
									itemLabel="answerTypeDesc" />
							</form:select></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="question.complexity">Complexity Type </form:label></td>
						<td><form:select path="question.complexity"
								class="form-control" style="margin-bottom: 5px;margin-top: 5px;"
								id="questionFormComplexityType" data-toggle="popover"
								data-content="Please choose a complexity">
								<form:option value="0" selected="">Please Select</form:option>
								<form:options items="${complexityList}" itemValue="complexityId"
									itemLabel="complexityName" />
							</form:select></td>
					</tr>
				</table>
			</div>

			<div style="background-color: #f1f1f1; padding-right: 10px;" align="right">
				<button class="btn btn-primary" type="button"
					onclick="document.getElementById('questionDiv').style.display='none'"
					style="margin-bottom: 5px; margin-top: 5px;">Cancel</button>
				<button class="btn btn-primary"
					style="margin-bottom: 5px; margin-top: 5px;">Submit</button>
			</div>
		</form:form>
	</div>

</body>
<script type="text/javascript">

	function onClickDeleteQuestion(questionId,questionDesc) {
		var categoryName = $("#categoryNameId").val();
		var categoryId = $('#categoryId').val();
		var content = "Do you want to delete Question: " + questionDesc;
		popDialog({
			title: 'Confirmation',
			message : content,
			buttons : {
				"Continue" : function() {
					$(this).dialog('close');
					jQuery.ajax({
						type : "POST",
						url : "${home}admin/deleteQuestion",
						data: {
							questionId: questionId,
							categoryId:categoryId
					    },
						success : function(response) {
							 $("#optionsListId").html("");
							 $("#questionDesc").html("");
							 $("#questionsListId").html(response);  
							 $("#categoryName").html(categoryName);
						},
						error : function(e) {
							console.log("ERROR: ", e);
						}
					});
				},
				"Cancel" : function() {
					$(this).dialog('close');
					document.assessementForm.action = "finishAssessement";
					document.assessementForm.submit();
				}
			}
		});
	}
	
	//Get the modal
	var questionModal = document.getElementById('questionDiv');
	
	//When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	    if (event.target == questionModal) {
	    	questionModal.style.display = "none";
	    }
	}
	$(document).ready(function(){
		$('[data-toggle="popover"]').click(function(){
			$("#questionFormQuestionDesc").popover('destroy');
			$("#questionFormAnswerType").popover('destroy');
			$("#questionFormComplexityType").popover('destroy');
		});
		
		$('#questionFormId').submit(function(e) {
			var quesDesc = document.getElementById("questionFormQuestionDesc").value;
			var ansType = document.getElementById("questionFormAnswerType").value;
			var complexityType = document.getElementById("questionFormComplexityType").value;
			var validationflag =false; 
			
			if(quesDesc.trim() =='') {
				//document.getElementById("questionFormQuestionDesc").style.border = "1px solid red";
				//$("#questionDescErr").html("Question Description required");
				//validationflag = true;
				$("#questionFormQuestionDesc").popover('show');
				return false;
			}
			 
			if(ansType==0) {
				//document.getElementById("questionFormAnswerType").style.border = "1px solid red";
				//$("#answerTypeErr").html("Answer type required");
				//validationflag = true;
				$("#questionFormAnswerType").popover('show');
				return false;
			}
			
			if(complexityType==0) {
				/*document.getElementById("questionFormComplexityType").style.border = "1px solid red";
				$("#complexityTypeErr").html("Question Description required");
				validationflag = true;*/
				$("#questionFormComplexityType").popover('show');
				return false;
			}
			
			var categoryId = $("#categoryId").val();
			
			$("#questionFormCategoryId").val(categoryId);
		    // reference to form object
			var form = this;
		    // for stopping the default action of element
		    e.preventDefault();
		    // mapthat will hold form data
		    var formData = {}
			//iterate over form elements   
		    $.each(this, function(i, v){
		    	var input = $(v);
		    	// populate form data as key-value pairs with the name of input as key and its value as value
		    	formData[input.attr("name")] = input.val();
		   	});
		    
		    var questionIDVal = $("#questionFormQuestionId").val();
		    var urlAction = "admin/addQuestion";
		    if(questionIDVal != ""){
		    	urlAction = "admin/editQuestion";
		    }
		    
		   	$.ajax({
			    type : "POST",
				url : "${home}"+urlAction,
		        data : formData,
		        success : function(response) {
					var categoryName = $("#categoryName").html();
					$("#optionsListId").html("");
					 $("#questionDesc").html("");
					 $("#questionsListId").html(response);  
					 $("#categoryName").html(categoryName);
					document.getElementById('questionDiv').style.display='none';
				},
				error : function(e) {
					console.log("ERROR: ", e);
				}
		    });
		});
	});
	
	function onClickViewOptionDetails(questionId,questionDesc){
		$("#questionId").val(questionId);
		jQuery.ajax({
			type : "POST",
			url : "${home}admin/getOptionsByQuestionId",
			data : { "questionId" : questionId},
			success : function(response) {
				 $("#optionsListId").html(response);
				 $('html, body').animate({
				        'scrollTop' : $("#optionsListId").position().top
				    });
				 $("#questionDesc").html("");
				 $("#questionDesc").html(questionDesc);
			},
			error : function(e) {
				console.log("ERROR: ", e);
			}
		});
	}
	
	
	/*function clearQuestionForm(){
		
		document.getElementById("questionFormQuestionDesc").style.border = "1px solid black";
		document.getElementById("questionFormAnswerType").style.border = "1px solid black";
		document.getElementById("questionFormComplexityType").style.border = "1px solid black";
		
		$("#questionDescErr").html("");
		$("#answerTypeErr").html("");
		$("#complexityTypeErr").html("");
	}*/
 
function loadQuestionDetails(questionId,questionDesc) {
			//clearQuestionForm();
			jQuery.ajax({
				type : "POST",
				url : "${home}admin/loadQuestionDetails",
				data: {
					questionId: questionId,
			    },
				success : function(response) {
					document.getElementById('questionDiv').style.display='block';
					var obj = response;
					$('#questionFormQuestionId').val(obj.questionId);
					$('#questionFormCategoryId').val(obj.categoryId);
					$('#questionFormQuestionDesc').val(obj.questionDesc);
					$('#questionFormAnswerType').val(obj.answerType);
					$('#questionFormComplexityType').val(obj.complexity);
					
				},
				error : function(e) {
					console.log("ERROR: ", e);
				}
			});
			
}
</script>

</html>