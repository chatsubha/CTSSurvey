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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <c:url var="home" value="/" scope="request" />
  
<link rel="stylesheet" href="../css/jquery-ui.css">
<script src="../js/applicationScripts.js?V=0.1"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
  
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.10.4/css/jquery.dataTables.min.css">
	<style type="text/css">
	.dropbtn {
    background-color: rgba(51, 122, 183, 1);
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f1f1f1;
    min-width: 160px;
    width:250px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #ddd}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: rgba(51, 122, 183, 1);
}

#dialog-confirm {
	height: auto !important;
	
}
.upload-file {
    outline: 2px dashed #92b0b3;
    outline-offset: -10px;
    -webkit-transition: outline-offset .15s ease-in-out, background-color .15s linear;
    transition: outline-offset .15s ease-in-out, background-color .15s linear;
    padding: 120px 0px 85px 35%;
    text-align: center !important;
    margin: 0;
    width: 100% !important;
}

	</style>
</head>
<body>
	<form:form action="admin/allCategory" method="POST"
		modelAttribute="adminForm" name="categoryFormSub">
		<input type="hidden" name="checkPage" id="checkPage" />
		<nav class="navbar navbar-inverse">
			<div class="container-fluid"
				style="background-color: rgba(51, 122, 183, 1);">
				<div class="navbar-header">
					<a class="navbar-brand" href="#"
						style="color: rgba(245, 245, 245, 1);">Assessment Portal</a>
				</div>

				<div class="dropdown">
					<button class="dropbtn" disabled="disabled">
						Service<span class="caret"></span>
					</button>
					<div class="dropdown-content">
						<a href="/admin">
						<span class="glyphicon glyphicon-question-sign"></span>
						Category/Questions
						</a>
						<a href="#"
							onclick="javascript:getCntForQuestPerAttempts()">
							<span class="glyphicon glyphicon-cog"></span>
							Configure
								Questions/Attempts</a>
						<a href="#"
							onclick="javascript:getUserActivityForm()">
							<span class="glyphicon glyphicon-user"></span>
							User Activity
							</a>
						<a href="#"
							onclick="javascript:getUploadForm()">
							<span class="glyphicon glyphicon-circle-arrow-up"></span>
							Bulk upload from Excel
							</a>
					</div>
				</div>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
					<a style="opacity:2;font-size:large;color:white" href="#" class="dropdown-toggle" data-toggle="dropdown">
					<span
							class="glyphicon glyphicon-user">
							</span>
							<b class="caret"></b>
					</a>	
					<ul class="dropdown-menu">
					<li align="left">
					<a href="#" class="btn btn-sm btn-default">
					<span class="glyphicon glyphicon-user"></span>
					  ${sessionScope.CN}
					 </a>
					</li>
					<li align="left">
					<a href="/assessment" class="btn btn-sm btn-default">
					<span class="glyphicon glyphicon-home"></span>
					 Home
					 </a>
					</li>
					<li align="left">
					<a href="/logout" class="btn btn-sm btn-default"><span class="glyphicon glyphicon-log-out"></span> Log Out</a>
					</li>
					</ul>
					
				    </li>
				</ul>
			</div>
		</nav>
	</form:form>
<div style="visibility:hidden;display:none" id="fileUploadDiv" >
<div class="row">
<div class="col-sm-25 col-sm-offset-2 col-md-20 col-md-offset-0">
<div class="form-group files">
<form id="frmUploadExcel" action="" onsubmit="return submitExcelForm()" enctype="mutipart/form-data" >
<input id="fileExcel"  onchange="return appendData($(this))" class="upload-file" type="file" name="excelFile" value="Upload"/>
<center>
<button type="submit" value="Upload" class="btn btn-sm btn-primary start">
<i class="glyphicon glyphicon-upload"></i>
<span>Upload</span>
</button>
<%--&nbsp;<button type="button" value="Cancel" onclick='$(".ui-dialog").hide();$(".ui-widget-overlay").hide();' class="btn btn-sm btn-warning cancel"> 
<i class="glyphicon glyphicon-ban-circle"></i>
<span >Cancel</span>
</button>
--%>
<br/><br/>
<label id="maxIdForQstn" title="Note: 1> same id with different question won't be allowed 2> Same id with same question will replace the options and other attributes from current file" style="float: center" class="label label-warning"></label>
<br/><br/>
<span  class="alert alert-danger errorUpload" style="visibility: hidden"></span>
</center>
</form>
</div>
<div>
<span  class="imgShow"></span>
</div>
</div>
</div>
</div>
</body>

<script type="text/javascript">
var content;
function getCntForQuestPerAttempts() {
	document.categoryFormSub.action ="admin/allCategory";
	document.forms["categoryFormSub"].submit();
}
function getUserActivityForm() {	
	jQuery.ajax({
		type : "POST",
		url : "admin/allUsersActivity",		
		data: '',
		success : function(response) {
			$("#adminCategory").hide();
			$("#usersHistoryField").empty().append(response);
		}
	});
}
function fetchMaxId() {
	jQuery.ajax({
		type : "POST",
		url : "/admin/fetchMaxId",
		success : function(response) {
        	$("#maxIdForQstn").empty().append(response);
        }
	});
}

var formData;
function getUploadForm()
{
	formData=null;
	
	fetchMaxId();
	 popDialog({
	        title: 'Excel File Upload',
	        message: content,
	        width:600
	    });
	 
}

function appendData(file){
	formData=new FormData();
	if(file.prop('files').length > 0)
    {
        file =file.prop('files')[0];
        formData.append("excelFile", file);
    }
	else {
		formData=null;
	}
	return true;	
}
function submitExcelForm() {
	//formData=new FormData($("#frmUploadExcel")[0]);
	$("#errorUpload").css("visibility","hidden");
	$("#errorUpload").empty();
	$("#errorUpload").removeAttr("class").attr("class","alert alert-danger");
	if(formData=="" || formData==undefined || formData==null) {
		$("#errorUpload").css("visibility","visible");
		$("#errorUpload").empty().append("Please select a file");
		return false;
	}
	jQuery.ajax({
		type : "POST",
		enctype: 'multipart/form-data',
		url : "/admin/uploadFile",
		data: formData,
		processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        beforeSend: function() {
        	$("#errorUpload").css("visibility","visible");
        	$(".form-group").hide();
        	$(".imgShow").empty().append("<center><img src='../css/images/giphy.gif' alt='Processing..'/></center>");
        	$(".imgShow").show();
        },
		success : function(response) {
			$(".imgShow").hide(500);
			$(".form-group").show(1000);
			$("#errorUpload").css("visibility","visible");
			if ("Invalid file size".match(response)) {
				$("#errorUpload").empty().append("Size of the file should not greater that 5Mb");
			}
			else if ("Invalid file type".match(response)) {
				$("#errorUpload").empty().append("File should be in xlsx/xls format");
			}
			else if ("File upload was not successful".match(response)) {
				$("#errorUpload").empty().append("File upload was not successful");
			}
			else if ("you have successfully uplad the file".match(response)) {
				fetchMaxId();
				$("#errorUpload").removeAttr("class").attr("class","alert alert-success");
				$("#errorUpload").empty().append("<span class='glyphicon glyphicon-ok'/>&nbsp;File has been uploaded successfully");
			}
			else if (response==null) {
				$("#errorUpload").empty().append("File upload was not successful");
			}
			else {
				$("#errorUpload").empty().append(response);
			}
				
			
			
		}
	});
	return false;
}

$(document).ready(function() {
    $('.dropdown-toggle').dropdown();
    $("#fileUploadDiv .errorUpload").attr("id","errorUpload");
	content = $("#fileUploadDiv").html();
	$("#fileUploadDiv #errorUpload").removeAttr("id");
	$("#fileUploadDiv #maxIdForQstn").removeAttr("id");
    
});

</script>


</html>