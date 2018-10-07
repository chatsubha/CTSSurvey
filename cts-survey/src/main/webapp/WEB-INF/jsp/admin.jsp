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
<style type="text/css">

/* The Modal (background) */
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
	padding-top: 60px;
}

.modalContainer {
	
}

/* Modal Content/Box */
.modal-content {
	background-color: #fefefe;
	margin: 10% auto 15% auto;
	/*margin: auto;*/
	/* 5% from the top, 15% from the bottom and centered */
	/*border: 1px solid #888;*/
	/* width: 60%; */
	width: 41%;
	/*border-color: black;
	border-style: solid;
	border-width: medium;*/
}

/* The Close Button (x) */
.close {
	position: absolute;
	right: 25px;
	top: 0;
	color: #000;
	font-size: 35px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: red;
	cursor: pointer;
}

.popUpSubmitBtn {
	background-color: #4CAF50;
	color: white;
	padding: 8px 10px;
	margin: 8px 0;
	border: none;
	cursor: pointer;
	width: 11%;
}

.headerText {
	padding-top: 1px;
}
.panel
{
margin-left:5%;width:90%
}
</style>

</head>
<body>
	<%@include file="adminMenu.jsp"%>
	<div id="adminCategory">
		<form:form action="admin/deleteCategory" method="post"
			modelAttribute="adminForm" name="categoryForm">
			<input type="hidden" name="categoryId" id="categoryId" />
			<input type="hidden" name="categoryNameId" id="categoryNameId">
			<div class="panel panel-info">
 <div class="panel-heading"><p><span class="glyphicon glyphicon-info-sign"></span>&nbsp;Course details </p>	</div>
    <div class="panel-body">
			<table id="category" class="table table-hover">
				<thead>
					<tr>
						<th>Course Name</th>
						<th>Course Description</th>
						<th>Pass Mark (%)</th>
						<th>Maximum Number of Attempts</th>
						<th>Action</th>
					</tr>
				</thead>
				<c:forEach items="${adminForm.categories}" var="category">
					<tr>
						<td>${category.categoryName}</td>
						<td>${category.categoryDesc}</td>
						<td>${category.cutOff}</td>
						<td>${category.maximumAttempts}</td>
						<td><a href="#"
							onclick="javascript:onClickViewQuestionDetails(${category.categoryId},'${category.categoryName}')">
							<span class="glyphicon glyphicon-eye-open"></span>
							&nbsp;View Questions</a> | <a href="#"
							onclick="javascript:loadCategoryDetails(${category.categoryId},'${category.categoryName}')">
							<span class="glyphicon glyphicon-pencil"></span>
							&nbsp;Edit</a> | 
							<a href="#"
							onclick="javascript:onClickDeleteCategory(${category.categoryId},'${category.categoryName}')">
							<span class="glyphicon glyphicon-trash"></span>&nbsp;Delete</a></td>
					</tr>
				</c:forEach>
			</table>
			</div></div>
			<button onclick="javascript:loadCategoryDetails('','')"
				class="btn btn-primary" style="margin-right: 2%; float: right;"
				type="button">
				<span class="glyphicon glyphicon-plus"></span>&nbsp;Add Course</button>
		</form:form>
	</div>
	<div id="usersHistoryField"></div>
	<div id="questionsListId"></div>

	<div id="optionsListId"></div>


	<div id="categoryDiv" class="modal">

		<form:form class="modal-content" action="admin/addCategory"
			method="POST" modelAttribute="adminForm" id="categoryFormId"
			name="addCategoryForm" onsubmit="return submitAllCategoryValues();">

			<form:hidden path="category.categoryId" id="categoryFormCategoryId" />
			<div class="headerText" align="center"
				style="color: white; background-color: rgba(51, 122, 183, 1);">
				<span class="glyphicon glyphicon-remove"
					onclick="document.getElementById('categoryDiv').style.display='none'"
					style="float: right; cursor: pointer;"></span>
				<h3 style="display: inline;">Category Form</h3>

			</div>
			<div class="modalContainer" align="center">

				<table>
					<!-- <tr>
						<td colspan="2"><span id="categoryNameErr"
							style="color: red;"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span id="categoryDescErr"
							style="color: red;"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span id="cutOffErr" style="color: red;"></span></td>
					</tr>
					<tr>
						<td colspan="2"><span id="maxNoOfAttemptErr"
							style="color: red;"></span></td>
					</tr> -->
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="category.categoryName">Course Name   </form:label></td>
						<td><form:input path="category.categoryName"
								id="categoryFormCategoryName" class="form-control"
								placeholder="Enter Category Name" maxlength="45"
								data-toggle="popover" data-content="Category Name required"
								style="margin-bottom: 5px;margin-top: 5px;" /></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="category.categoryDesc">Course Description </form:label></td>
						<td><form:textarea path="category.categoryDesc"
								id="categoryFormCategoryDesc" class="form-control"
								placeholder="Enter Category Description" maxlength="500"
								data-toggle="popover"
								data-content="Category Description required"
								style="margin-bottom: 5px;margin-top: 5px;" /></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="category.cutOff">Pass Mark (%) </form:label></td>
						<td><form:input path="category.cutOff"
								id="categoryFormCategoryCutOff" class="form-control"
								placeholder="Enter Category CutOff"
								onkeypress="return validatenumerics(event);"
								data-toggle="popover" data-content="Category cut-off required"
								style="margin-bottom: 5px;margin-top: 5px;" /></td>
					</tr>
					<tr>
						<td align="right" style="padding-right: 10px;"><form:label path="category.maximumAttempts">Maximum Number Of Attempts </form:label></td>
						<td><form:input path="category.maximumAttempts"
								id="categoryFormMaxNoOfAttempt" class="form-control"
								placeholder="Enter Maximum Number Of Attempt"
								onkeypress="return validatenumerics(event);"
								data-toggle="popover" data-content="Max-Attempt required"
								style="margin-bottom: 5px;margin-top: 5px;" /></td>

					</tr>
				</table>
			</div>

			<div class="modalContainer" style="background-color: #f1f1f1; padding-right: 10px;"
				align="right">
				<button class="btn btn-primary" type="button"
					onclick="document.getElementById('categoryDiv').style.display='none'"
					style="margin-bottom: 5px; margin-top: 5px;">Cancel</button>
				<button class="btn btn-primary" id="btnSubmit"
					style="margin-bottom: 5px; margin-top: 5px;">Submit</button>
			</div>

		</form:form>
	</div>

</body>
<script type="text/javascript">

$('[data-toggle="popover"]').click(function(){
	$("#categoryFormCategoryName").popover('destroy');
	$("#categoryFormCategoryDesc").popover('destroy');
	$("#categoryFormCategoryCutOff").popover('destroy');
	$("#categoryFormMaxNoOfAttempt").popover('destroy');
});

function validatenumerics(key) {
    var keycode = (key.which) ? key.which : key.keyCode;

    if (keycode > 31 && (keycode < 48 || keycode > 57)) {
        return false;
    }
    else return true;


}

function submitAllCategoryValues() {
	var categoryName = document.getElementById("categoryFormCategoryName").value;
	var categoryDesc= document.getElementById("categoryFormCategoryDesc").value;
	var categoryCutoff= document.getElementById("categoryFormCategoryCutOff").value;
	var maxNoOfAttempt= document.getElementById("categoryFormMaxNoOfAttempt").value;
	var validationflag =false; 
	if(categoryName.trim() =='') {
		$("#categoryFormCategoryName").popover('show');
		return false;
	}
	
	if(categoryDesc.trim()=='' ){
		$("#categoryFormCategoryDesc").popover('show');
		return false;
	}
	
	if(categoryCutoff.trim()=='' ){
		$("#categoryFormCategoryCutOff").attr({
    		"data-content" : "CutOff required (1 - 100)"
  		});
		$("#categoryFormCategoryCutOff").popover('show');
		return false;
	}else if(categoryCutoff > 100 || categoryCutoff < 1) {
		$("#categoryFormCategoryCutOff").attr({
    		"data-content" : "Cutoff must be with in (1 - 100)"
  		});
		$("#categoryFormCategoryCutOff").popover('show');
		return false;
	}
	
	if(maxNoOfAttempt.trim() =='' ){
		$("#categoryFormMaxNoOfAttempt").attr({
    		"data-content" : "Max-Number Of Attempt required(1 - 5)"
  		});
		$("#categoryFormMaxNoOfAttempt").popover('show');
		return false;
	}else if(maxNoOfAttempt > 5 || maxNoOfAttempt < 1) {
		$("#categoryFormMaxNoOfAttempt").attr({
    		"data-content" : "Attempt must be with in (1 - 5)"
  		});
		$("#categoryFormMaxNoOfAttempt").popover('show');
		return false;
	}
	return true;
}

/*function clearCategoryForm(){
	$("#categoryNameErr").html("");
	$("#categoryDescErr").html("");
	$("#cutOffErr").html("");
	$("#maxNoOfAttemptErr").html("");
}*/

function onClickDeleteCategory(categoryId,categoryName){
		var content = "Do you want to delete category: " + categoryName +" ? ";
		 popDialog({
		        title: 'Confirmation',
		        message: content,
		        buttons: {
		        	"Continue": function(){ $(this).dialog('close');
		        	deleteCategory(categoryId)},
		            "Cancel": function(){ $(this).dialog('close') }
		        }
		    });
}

function deleteCategory(categoryId){
	$('#categoryId').val(categoryId);
	document.categoryForm.action ="admin/deleteCategory";
	document.categoryForm.submit();
}

//Get the modal
var modal = document.getElementById('categoryDiv');

//When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

function onClickViewQuestionDetails(categoryId,categoryName){
	$("#categoryId").val(categoryId);
	$("#categoryNameId").val(categoryName);
	
	jQuery.ajax({
		type : "POST",
		url : "${home}admin/getQuestionByCategory",
		data : { "categoryId" : categoryId},
		success : function(response) {
			 $("#adminCategory").hide();
			 $("#questionsListId").html(response);  
			 $("#categoryName").html(categoryName);
			 $("#optionsListId").html("");
		},
		error : function(e) {
			console.log("ERROR: ", e);
		}
	});
}

function loadCategoryDetails(categoryId,categoryName){
	 
		jQuery.ajax({
			type : "POST",
			url : "${home}admin/loadCategoryDetails",
			data: {
				categoryId: categoryId,
		    },
			success : function(response) {
				document.getElementById('categoryDiv').style.display='block';
				var obj = response;
				$('#categoryFormCategoryId').val(obj.categoryId);
				$('#categoryFormCategoryName').val(obj.categoryName);
				$('#categoryFormCategoryDesc').val(obj.categoryDesc);
				$('#categoryFormCategoryCutOff').val(obj.cutOff);
				$('#categoryFormMaxNoOfAttempt').val(obj.maximumAttempts);
				
			},
			error : function(e) {
				console.log("ERROR: ", e);
			}
		});
		
}

$(document).ready(function(){
	
	$('#categoryFormId').submit(function(e) {
		
		var questionId = $("#questionId").val();
		
		$("#optionFormQuestionId").val(questionId);
		
		var categoryIDVal = $("#categoryFormCategoryId").val();
	    var urlAction = "admin/addCategory";
	    if(categoryIDVal != ""){
	    	urlAction = "admin/editCategory";
	    }
	    
	    $('#categoryFormId').attr("action",urlAction);
	     
	});
});

</script>

</html>