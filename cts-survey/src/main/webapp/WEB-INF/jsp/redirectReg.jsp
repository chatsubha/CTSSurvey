<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript">
$(document).ready(function(){
	$("#registrationRedirForm").submit();
});
</script>
<title>Assessment portal</title>
</head>
<body>
<form id="registrationRedirForm" action="/registrationForm" method="post" >
<input type="hidden" name="user_name" value="${username}" />
<input type="hidden" name="password" value="${password}" />
<input type="hidden" name="error" value="s" />
<input  type="submit"/>
</form>

</body>
</html>