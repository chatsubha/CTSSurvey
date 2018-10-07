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
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<c:url var="home" value="/" scope="request" />

<link rel="stylesheet" href="../css/jquery-ui.css">
<script src="../js/applicationScripts.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

</head>
<body>
<br/><br/><br/>
<div class="panel panel-info">
 <div class="panel-heading"><p><span class="glyphicon glyphicon-eye-open"></span>&nbsp;View Options</p>	</div>
    <div class="panel-body">
    <p style="cursor:pointer;font-color:#337ab7;font-size:14px; float: right;"  onclick="$('html, body').animate({'scrollTop' : $('#question').position().top});">
			<span class="glyphicon glyphicon-arrow-up"></span>&nbsp;Go to question</p>
	<div align="left">
		<table id="optionDisaplyTbl">
		<tr><th><h5>Selected Question &nbsp;</h5></th></tr>
			<tr>
				
				<td><label style="background-color:#d9edf7" id="questionDesc"></label></td>
			</tr>
		</table>
	</div>

	<form:form action="admin/deleteOption" method="post" modelAttribute="adminForm">
		<input type="hidden" name="optionsId" id="optionsId">
		<table id="options" class="table table-hover">
			<tr>
				<th>Option Description</th>
				<th>Correct Answer</th>
				<th>Action</th>
			</tr>

			<c:forEach items="${adminForm.optionsList}" var="options">
				<tr>
					<td>${options.optionsDesc}</td>
					<td>${options.correctAnswer}</td>
					<td><a href="#"
						onclick="javascript:loadOptionDetails(${options.optionsId},'${options.optionsDesc}')">
						<span class="glyphicon glyphicon-pencil"></span>&nbsp;Edit</a> | 
						<a href="#"
						onclick="javascript:onClickDeleteOption(${options.optionsId},'${options.optionsDesc}')">
						<span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</a></td>
				</tr>
			</c:forEach>
		</table>
		<button onclick="javascript:loadOptionDetails('','')" type="button"
			style="margin-right: 2%; float: right;" class="btn btn-primary">Add
			Options</button>
	</form:form>

	<div id="optionDiv" class="modal">
		<form:form class="modal-content" action="admin/addOption" method="POST"
			modelAttribute="adminForm" id="optionFormId" name="optionForm">

			<form:hidden path="option.questionId" id="optionFormQuestionId" />
			<form:hidden path="option.optionsId" id="optionFormOptionId" />
			<div class="headerText" align="center"
				style="color: white; background-color: rgba(51, 122, 183, 1);">
				<span class="glyphicon glyphicon-remove"
					onclick="document.getElementById('optionDiv').style.display='none'"
					style="float: right; cursor: pointer;"></span>
				<h3 style="display: inline;">Option Form</h3>

			</div>
			<div align="center">
				<table>

					<!-- <tr>
						<td colspan="2"><span id="optionsDescErr" style="color: red;"></span></td>
					</tr> -->

					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="option.optionsDesc">Options Description </form:label></td>
						<td><form:textarea path="option.optionsDesc" name="optionsDesc" class="form-control"
								id="optionFormOptionsDesc" style="margin-bottom: 5px;margin-top: 5px;"
								data-toggle="popover" data-content="Option Description required" maxlength="500"/></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="option.correctAnswer">Is Correct Answer </form:label></td>
						<td><form:checkbox path="option.correctAnswer" value="Yes"
								id="optionFormCorrectAnswer" /></td>
					</tr>
				</table>
			</div>

			<div style="background-color: #f1f1f1; padding-right: 10px;" align="right">
				<button class="btn btn-primary" type="button"
					onclick="document.getElementById('optionDiv').style.display='none'" style="margin-bottom: 5px; margin-top: 5px;">Cancel</button>
				<button class="btn btn-primary" style="margin-bottom: 5px; margin-top: 5px;">Submit</button>
			</div>
		</form:form>
	</div>
</div>
</div>


</body>


<script type="text/javascript">

//Get the modal
var modal = document.getElementById('optionDiv');

//When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
$(document).ready(function(){
	$('[data-toggle="popover"]').click(function(){
		$("#optionFormOptionsDesc").popover('destroy');
	});
	$('#optionFormId').submit(function(e) {
		
		
		var optionDesc = document.getElementById("optionFormOptionsDesc").value;
		if(optionDesc=='') {
			//document.getElementById("optionFormOptionsDesc").style.border = "1px solid red";
			//$("#optionsDescErr").html("Option Description required");.
			$("#optionFormOptionsDesc").popover('show');
			return false;
		}
		 
		var questionId = $("#questionId").val();
		
		$("#optionFormQuestionId").val(questionId);
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
	    	if(input[0].type == 'checkbox'){
	    		if(input[0].checked == true){
	    			formData[input.attr("name")] = input.val();
	    		}else{
	    			formData[input.attr("name")] = "No";
	    		}
	    	}else{
	    		formData[input.attr("name")] = input.val();
	    	}
	   	});
	    var optionIDVal = $("#optionFormOptionId").val();
	    var urlAction = "admin/addOption";
	    if(optionIDVal != ""){
	    	urlAction = "admin/editOption";
	    }
	   	$.ajax({
		    type : "POST",
			url : "${home}"+urlAction,
	        data : formData,
	        success : function(response) {
				var questionDesc = $("#questionDesc").html();
				$("#optionsListId").html(response);  
				$("#questionDesc").html(questionDesc);
				document.getElementById('optionDiv').style.display='none';
			},
			error : function(e) {
				console.log("ERROR: ", e);
			}
	    });
	});
});


/*function clearOptionsForm(){
	document.getElementById("optionFormOptionsDesc").style.border = "1px solid black";
	$("#optionsDescErr").html("");
}*/

function onClickDeleteOption(optionsId,optionsDesc){
		var questionId = $("#questionId").val();
		var content = "Do you want to delete category: " + optionsDesc;
		popDialog({
			title: 'Confirmation',
			message : content,
			buttons : {
				"Continue" : function() {
					$(this).dialog('close');
					jQuery.ajax({
						type : "POST",
						url : "${home}admin/deleteOption",
						data: {
							optionId: optionsId,
							questionId: questionId
					    },
						success : function(response) {
							var questionDesc = $("#questionDesc").html();
							$("#optionsListId").html(response);  
							$("#questionDesc").html(questionDesc);
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

function loadOptionDetails(optionsId,optionsDesc){
			//clearOptionsForm();
			
			jQuery.ajax({
				type : "POST",
				url : "${home}admin/loadOptionDetails",
				data: {
					optionId: optionsId,
			    },
				success : function(response) {
					document.getElementById('optionDiv').style.display='block';
					var obj = response;
					$('#optionFormQuestionId').val(obj.questionId);
					$('#optionFormOptionId').val(obj.optionsId);
					$('#optionFormOptionsDesc').val(obj.optionsDesc);
					if(obj.correctAnswer == 'Yes'){
						$('#optionFormCorrectAnswer').prop('checked', true);	
					}else{
						$('#optionFormCorrectAnswer').prop('checked', false);
					}
					
					
				},
				error : function(e) {
					console.log("ERROR: ", e);
				}
			});
			
}

</script>

</html>