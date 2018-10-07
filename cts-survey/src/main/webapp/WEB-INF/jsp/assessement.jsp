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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/3.3.1/jquery-ui.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.1/jquery-confirm.min.css">
<link rel="stylesheet" href="css/questions.css">
<link rel="stylesheet" href="css/bootstrap-directional-buttons.css">
<c:url var="home" value="/" scope="request" />

<link rel="stylesheet" href="../css/jquery-ui.css">
<script src="../js/applicationScripts.js"></script>
<script src="../js/jquery.fullscreen.min.js?V=0.1"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  
<style type="text/css">
  /* Remove the navbar's default rounded borders and increase the bottom margin  
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;      
    }
    
    /* Remove the jumbotron's default bottom margin 
     .jumbotron {
      margin-bottom: 0;
    }
   
     Add a gray background color and some padding to the footer 
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }

	#assessemnetForm{
		position:absolute;
		left:35px;
		top:15px;	
	}
}*/

    
</style>
<script>
function submitForm1(btn) {
	
		var whichClicked=$(btn).attr("value");
		
		jQuery.ajax({
			type : "POST",
			url : "assessementQs",		
			data: $("#assessemnetForm").serialize()+"&action="+whichClicked,
			success : function(response) {
				$("#qstnBody").empty().append(response);
			}
		});
		return false;	
}
function submitForm2(btn) {
	
	var whichClicked=$(btn).attr("value");
	
	jQuery.ajax({
		type : "POST",
		url : "finishAssessement",		
		data: $("#confirmPage").serialize()+"&action="+whichClicked,
		success : function(response) {
			$("#qstnBody").empty().append(response);
		}
	});
	return false;	
}

function submitForm3(btn) {
	
	$("#confirmPage").removeAttr("onsubmit");
	$("#confirmPage").submit();
}

function submitHandle()
{
	
		return false;
	
}
function submitEq(num) {
	jQuery.ajax({
		type : "POST",
		url : "finishAssessement",		
		data: "action=BTEQL&questionNumber="+num,
		success : function(response) {
			$("#qstnBody").empty().append(response);
		}
	});
	return false;
}
function removeSpace(num) {
	num=num.replace(" ","");
	return "frmbteql"+num;
}
function loadCorrectQstn(key,qnumber) {
	
	    var qstn="";
	    var ans="";
	    $.ajax({
	    	type:'POST',
	    	url:'getQuestionById',
	    	data:'id='+key,
	    	success : function(response) {
	    		qstn=response.split(":")[0];
	    		ans=response.split(":")[1];
	    		$.fullscreen.exit();
	   		    popDialog({
	   			 	title: 'Alert',
	   		        message: "<b>"+qnumber+"</b>.&nbsp;"+qstn+"<br/><br/><span style='color:green' class='glyphicon glyphicon-ok'/>&nbsp;"+ans,
	   		        width:'auto',
	   		        buttons: {
	   		        	"Ok": function(){ $(this).dialog('close');
	   		        	
	   		    		},
	   		        }
	   		    });
			}
	    });	   
		
		 
	     return false;
}
$(document).ready(function(){
	
	/*$(document)[0].oncontextmenu = function() {
        return false;
    }*/
    $(".mainDiv").css("overflow","scroll");

	$("body").keydown(function(event) {

	/*evt = event || window.event;
	var isEscape = false;
	    if ("key" in evt) {
	        isEscape = (evt.key == "Escape" || evt.key == "Esc");
	    } else {
	        isEscape = (evt.keyCode == 27);
	    }
	    if (isEscape) {
	        alert("Escape");
			event.preventDefault();
	    }
		*/
	if (event.preventDefault) {
	                event.preventDefault();
	            } else {
	                event.returnValue = false;
	            }
				
				  return false;
	});					
	
	
	$(".open").click(function(){
		
		//var full=$("body .container-fluid").fullscreen();
		
		 
        $("body #mainDiv").fullscreen();
        $(".mainDiv").css("overflow","scroll");
        $("#questionDiv").css("visibility","visible");
		$("#questionDiv").slideDown(2000);
		$("#noteDiv").slideUp(2000);
		return false;
		
		});
	    
	
        
		
		
		/*$('.close').click(function() {
            $.fullscreen.exit();
			window.close();
            return false;
        });*/
		
		
		
			

});

function closeWindow() {
	$.fullscreen.exit();
	window.close();
    return false;
}

function closePopup(form) {
	 form.submit();
	 window.close();
	 window.onunload = refreshParent;
	    
	}
function refreshParent() {
    window.opener.location.reload();
}

</script>
<%
String timer = request.getParameter( "countdown" );
if( timer == null ) timer = "0";
%>
<!-- timer = "01:03:44"; -->
</head>
<body>
<div id="mainDiv" class="mainDiv" style="background-color:white;">
<nav class="navbar navbar-inverse">
<div class="container-fluid" style="background-color: rgba(51, 122, 183, 1);">
  <div class="navbar-header">
      <a class="navbar-brand" href="#" style="color: rgba(245, 245, 245, 1);">Assessment Portal</a>
  </div>
   <%--  <ul class="nav navbar-nav navbar-right">
      <li><a href="/logout" style="color: rgba(245, 245, 245, 1);"><span class="glyphicon glyphicon-user"></span> Log Out</a></li>
    </ul> --%> 
</div>
</nav>
 <div id="qstnBody">
<c:if test="${isFirstPage eq 'y'}"> 
<%-- <div id="noteDiv" class="panel panel-info">
    <div class="panel-heading">Note:</div>
    <div class="panel-body">
	<p> The current assessment will take some of your valuable time and it will open in full screen mode.So please make sure and click on the start button</p>
	<br/>
	<center><a href="#"  class="open">Start Exam</a>  <a href="#" onclick="closeWindow()" class="close">Exit</a>
	</center>
	</div>
  </div>
  --%>
  <script type="text/javascript">
  var content="<table class='table table-striped' style='width: 100%; margin-top: 2%;border-bottom: 1px solid #337ab7' align='center'><tr class='table danger'><td><b>Category Name</b></td><td><b>Max Attempts</b></td><td><b>Available Attempts</b></td></tr><tr class='table success'><td>${assessementObj.categoryName}</td><td>${assessementObj.maxAttempts}</td><td>${assessementObj.pendingAttempts}</td></tr></table>";
   popDialog({
		        title: 'Confirmation',
		        message: content,
		        width:"auto",
		        buttons: {
		        	"Start Exam": function(){ 
		        		    $("body #mainDiv").fullscreen();
		        	        $("#questionDiv").css("visibility","visible");
		        			$("#questionDiv").slideDown(2000);
		        			$("#noteDiv").slideUp(2000);
		        			$(this).dialog('close');
		        	},
		            "Cancel": function(){ $(this).dialog('close');window.close(); }
		        }
		    });
   </script>
 </c:if> 

 <c:if test="${isFirstPage eq ''|| isFirstPage eq null}"> 
  <div id="questionDiv" style="visibility:visible;width:80%;margin-left:10%;margin-right:10%" class="panel panel-info">
  </c:if>
  <c:if test="${isFirstPage eq 'y'}"> 
  <div id="questionDiv" style="visibility:hidden;width:80%;margin-left:10%;margin-right:10%" class="panel panel-info">
  </c:if>
     <a href="#" onclick="closeWindow()" class="close " style="margin-right:0%;color:red"><span class="glyphicon glyphicon-remove"></span></a>
     
    <div class="panel-heading"><p>Question ${assessementObj.questionNumber}</p>	</div>
    <div class="panel-body">
  
    <%-- <div class="row">
      <div class="col-sm-2" style="background-color:lavender;">
      	<p class="question-num">Question ${assessementObj.questionNumber}</p>		
      </div>
        <div class="col-sm-8">--%>
        
		<form:form onsubmit="return submitHandle()" name="assessementForm" commandName="assessementObj" action="assessementQs" id="assessemnetForm" method="POST">					
				
				<input type="hidden" name="timer" id="timer">		
				<input type="hidden" name="time" id="time" value="${assessementObj.courseTime}">				
				<p style='color: #FCFFFF; float: right; color: black;'>Time remaining: <label id="countdown1" class="countdown1"> </label> 
				<input type="hidden" name="countdown" class="countdown" id="countdown" readonly>
				</p>
				<br/><br/>
				<!-- <label id="countdown" class="countdown"> </label>-->
				
				<c:forEach items="${assessementObj.questOption}" var="obj">	
								
				<p class="question">${obj.key}</p>
				
				<c:set var="answerType" value="${assessementObj.answerType}"></c:set>
				<c:choose>   
    				<c:when test="${answerType eq 'SingleOption'}">        
        				<c:forEach items="${obj.value}" var="element">
							<div class="option radio">
								<label>
									<form:radiobutton path="userAnswers" name="options"	id="finalQuestion" value='${element}' />
						    		<c:out value="${element}"></c:out>
						    	</label>
							</div>	
						</c:forEach>
    				</c:when>    
    				<c:otherwise>       
						<c:forEach items="${obj.value}" var="element">
							<div class="option checkbox">
								<label>
									<form:checkbox path="userAnswers" id="finalQuestion" name="options" value='${element}' />
									<c:out value="${element}"></c:out>
								</label>
							</div>	
						</c:forEach>	
					</c:otherwise>
						
				</c:choose>	
				<div class="action-buttons">
					<c:if test="${assessementObj.questionNumber ne 1}"> 
						<button onclick="submitForm1($(this))" type="submit" name="action" value="Previous" class="btn btn-primary btn-arrow-left">Previous</button>
					</c:if>
								
					<c:if test="${assessementObj.questionNumber ne assessementObj.totalQuestions }"> 
						<button onclick="submitForm1($(this))" type="submit" name="action" value="Next" class="btn btn-primary btn-arrow-right" style="float:right;">Next</button>
					</c:if>							
								
					<c:if test="${assessementObj.questionNumber eq assessementObj.totalQuestions }"> 
						<!-- <input type="submit" id="btnFinish" name="action" value="Finish" class="btn btn-primary"/> -->
						<%-- <a href="#" onclick="javascript:getTotalQuestions('${assessementObj}')" class="btn btn-primary" />Finish</a> --%>					
							<button onclick="submitForm1($(this))" type="submit" name="action" value="Finish" class="btn btn-success btn-arrow-right"  style="float:right;">Finish</button>
					</c:if>
				</div>			
				</c:forEach>		
		</form:form>
   <%-- </div>
  </div>--%> 
</div>
	</div>
 </div>		
<script>

//Time Format : "01:01:08";
var timer2 = "<%=timer%>"; // write time to javascript

if(timer2 ==0){
	timer2 = document.getElementById("time").value;
}

document.assessementForm.countdown.value = timer2; 
document.getElementById("countdown1").innerText = timer2;
 
var interval = setInterval(function() {

	  var timer = timer2.split(':');
	  //by parsing integer, I avoid all extra string processing
	  var hours = parseInt(timer[0], 10);
	  var minutes = parseInt(timer[1], 10);
	  var seconds = parseInt(timer[2], 10);
	  --seconds;
	  minutes = (seconds < 0) ? --minutes : minutes;
	  hours = (minutes < 0 && seconds < 0) ? --hours : hours;
	  if (minutes < 0 && hours < 0) clearIntrvl(interval);
	  hours = (hours < 10) ? '0' + hours : hours;
	  minutes = (minutes < 0) ? 59 : minutes;
	  minutes = (minutes < 10) ? '0' + minutes : minutes;
	  seconds = (seconds < 0) ? 59 : seconds;
	  seconds = (seconds < 10) ? '0' + seconds : seconds;
	  //minutes = (minutes < 10) ?  minutes : minutes;	  
	  document.assessementForm.countdown.value = hours + ':' + minutes + ':' + seconds;
	  document.getElementById("countdown1").innerText =  hours + ':' + minutes + ':' + seconds;
	  $('.countdown').html(hours + ':' + minutes + ':' + seconds);
	  document.assessementForm.countdown.value = hours + ':' + minutes + ':' + seconds;
	  document.getElementById("countdown1").innerText =  hours + ':' + minutes + ':' + seconds;
	  timer2 = hours + ':' + minutes + ':' + seconds;  
	}, 1000);

function clearIntrvl(interval){
	
	clearInterval(interval);
	/*var content = "Assessment timed out, Click ok to submit";
	 popDialog({
			title: 'Alert',
	        message: content,
	        buttons: {
	        	"Ok": function(){ 
	        		$(this).dialog('close');
		        	document.assessementForm.action ="finishAssessement";
		        	document.assessementForm.submit(); },
	        }
	    });*/
	document.assessementForm.action ="finishAssessement";
	document.assessementForm.submit();
}

//Below method for question is answered or not
function getTotalQuestions(assessementObj){
		
	jQuery.ajax({
		type : "POST",
		url : "${home}getTotalQuestions",		
		data: $("form").serialize(),
		success : function(response) {
			var obj = response;				
			var totalQs = obj.unselectedQuestions;
	
			if(totalQs!=0){
				var content = "You are not answered for " + totalQs + " questions, Do you want to submit?";
				popDialog({
					title: 'Alert',
					message : content,
					buttons : {
						"Continue" : function() {
							$(this).dialog('close');
							document.assessementForm.action = "finishAssessement";
							document.assessementForm.submit();
						},
						"Cancel" : function() {
							$(this).dialog('close'); 
						}
					}
				});
				
			}else{
					document.assessementForm.action ="finishAssessement";
					document.assessementForm.submit();
			}					
										
			},
			error : function(e) {
				console.log("ERROR: ", e);
				}
			});	
}
</script>
</body>
</html>
</c:if>
<c:if test="${isAjax eq 'yes'}">

<div id="qstnBody">
<c:if test="${isFirstPage eq 'y'}"> 
<div id="noteDiv" class="panel panel-info">
    <div class="panel-heading">Note:</div>
    <div class="panel-body">
	<p> The current assessment will take some of your valuable time and it will open in full screen mode.So please make sure and click on the start button</p>
	<br/>
	<center><a href="#" onclick="closeWindow()" class="close " style="margin-right:0%;color:red"><span class="glyphicon glyphicon-remove"></span></a>
	</center>
	</div>
  </div>
 </c:if> 

 <c:if test="${isFirstPage eq '' || isFirstPage eq null}"> 
  <div id="questionDiv" style="visibility:visible;width:80%;margin-left:10%;margin-right:10%" class="panel panel-info">
  </c:if>
  <c:if test="${isFirstPage eq 'y'}"> 
  <div id="questionDiv" style="visibility:hidden;width:80%;margin-left:10%;margin-right:10%" class="panel panel-info">
  </c:if>
     <a href="#" onclick="closeWindow()" class="close " style="margin-right:0%;color:red"><span class="glyphicon glyphicon-remove"></span></a>
     
    <div class="panel-heading"><p>Question ${assessementObj.questionNumber}</p>	</div>
    <div class="panel-body">
  
    <%-- <div class="row">
      <div class="col-sm-2" style="background-color:lavender;">
      	<p class="question-num">Question ${assessementObj.questionNumber}</p>		
      </div>
        <div class="col-sm-8">--%>
        
		<form:form onsubmit="return submitHandle()" name="assessementForm" commandName="assessementObj" action="assessementQs" id="assessemnetForm" method="POST">					
				
				<input type="hidden" name="timer" id="timer">		
				<input type="hidden" name="time" id="time" value="${assessementObj.courseTime}">				
				<p style='color: #FCFFFF; float: right; color: black;'>Time remaining: <label id="countdown1" class="countdown1"> </label> 
				<input type="hidden" name="countdown" class="countdown" id="countdown" readonly>
				</p>
				<br/><br/>
				<!-- <label id="countdown" class="countdown"> </label>-->
				
				<c:forEach items="${assessementObj.questOption}" var="obj">	
										
				<p class="question">${obj.key}</p>
				
				<c:set var="answerType" value="${assessementObj.answerType}"></c:set>
				<c:choose>   
    				<c:when test="${answerType eq 'SingleOption'}">        
        				<c:forEach items="${obj.value}" var="element">
							<div class="option radio">
								<label>
									<form:radiobutton path="userAnswers" name="options"	id="finalQuestion" value='${element}' />
						    		<c:out value="${element}"></c:out>
						    	</label>
							</div>	
						</c:forEach>
    				</c:when>    
    				<c:otherwise>       
						<c:forEach items="${obj.value}" var="element">
							<div class="option checkbox">
								<label>
									<form:checkbox path="userAnswers" id="finalQuestion" name="options" value='${element}' />
									<c:out value="${element}"></c:out>
								</label>
							</div>	
						</c:forEach>	
					</c:otherwise>
						
				</c:choose>	
				<div class="action-buttons">
					<c:if test="${assessementObj.questionNumber ne 1}"> 
						<button onclick="submitForm1($(this))" type="submit" name="action" value="Previous" class="btn btn-primary btn-arrow-left">Previous</button>
					</c:if>
								
					<c:if test="${assessementObj.questionNumber ne assessementObj.totalQuestions }"> 
						<button onclick="submitForm1($(this))" type="submit" name="action" value="Next" class="btn btn-primary btn-arrow-right" style="float:right;">Next</button>
					</c:if>							
								
					<c:if test="${assessementObj.questionNumber eq assessementObj.totalQuestions }"> 
						<!-- <input type="submit" id="btnFinish" name="action" value="Finish" class="btn btn-primary"/> -->
						<%-- <a href="#" onclick="javascript:getTotalQuestions('${assessementObj}')" class="btn btn-primary" />Finish</a> --%>					
							<button onclick="submitForm1($(this))" type="submit" name="action" value="Finish" class="btn btn-success btn-arrow-right"  style="float:right;">Finish</button>
					</c:if>
				</div>			
				</c:forEach>		
		</form:form>
   <%-- </div>
  </div>--%> 
</div>
	</div>
</c:if>