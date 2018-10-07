<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>
.pageNumber {
	padding: 2px;
	font-size: large;
	background-color: white;
	border: 1px solid lightslategray;
	margin: 2px;
}

#pages {
	margin-top: 10px;
	
	
}
#stamnt_page {
    margin-right: 3px;

}
</style>
<script>
	$(document)
			.ready(
					function() {
						var totalRows = $('#tbl_result').find(
								'#tbl_body tr:has(td)').length;
						var recordPerPage = 10;
						var selectedButton=1;
						if(totalRows<recordPerPage)
							{
							recordPerPage=totalRows;
							}
							
						if (totalRows > 0) {
							var totalPages = Math.ceil(totalRows
									/ recordPerPage);
							var $pages = $('<div id="pages" align="right"><span id="stamnt_page"></span></div>');
							for (i = 0; i < totalPages; i++) {
								$(
										'<span align="center" id=pageNumber'+i+' class="pageNumber">'
												+ (i + 1) + '</span>')
										.appendTo($pages);
							}
							$('#pageNumber0').css("background-color","#337ab7");
							$pages.appendTo('#tbl_result #pagination_row');
							$('.pageNumber').hover(function() {
								$(this).addClass('focus1');
							}, function() {
								$(this).removeClass('focus1');
							});
							$('table').find('#tbl_body tr:has(td)').hide();
							var tr = $('table #tbl_body tr:has(td)');
							$("#stamnt_page").empty().append(
									"Results 1 to " + (recordPerPage)
											+ " of " + (totalRows))+"&nbsp;&nbsp;";
							for (var i = 0; i < recordPerPage; i++) {
								$(tr[i]).show();
							}
							hidePaginationButton();
							$('.pageNumber').click(
									function(event) {
										$('.pageNumber').css("background-color","white");
										$(this).css("background-color",  "#337ab7");
										$('#tbl_result').find(
												'#tbl_body tr:has(td)').hide();
										selectedButton=$(this).text();
										var nBegin = ($(this).text() - 1)
												* recordPerPage;
										var nEnd = $(this).text()
												* recordPerPage - 1;
										if(totalRows<nEnd)
											{
										$("#stamnt_page").empty().append(
												"Results " + (nBegin+1) + " to "
														+ (totalRows) + " of "
														+ totalRows);
											}
										else
											{
											$("#stamnt_page").empty().append(
													"Results " + (nBegin+1) + " to "
															+ (nEnd+1) + " of "
															+ totalRows);
											}
										for (var i = nBegin; i <= nEnd; i++) {
											$(tr[i]).show();
										}
										hidePaginationButton();
									});
						} else {
							$("#main_div")
									.append(
											'<center><table  class="table table table-striped" style="width: 50%; margin-top: 5%" align="center"><tr><td  colspan="6" align="center"><b><center>Assessment History</center></b></td></tr><tr><td colspan="6"><div class="alert alert-warning" align="center">No user has taken any assessment<div></td></tr></center>');
							$("#tbl_result").hide();
						}
						//	}
						function hidePaginationButton()
						{
							
							var numberOfButton=$("#pages .pageNumber").length;
							if(numberOfButton>5)
								{
								$("#pages .pageNumber").hide();
								var start=(parseInt(selectedButton)-3);
								
								var end =(parseInt(selectedButton)+3);
								
								for(i=start;i<=end;i++)
									{
									$("#pageNumber"+i).show();
									}
								$("#pageNumber0").show();
								$(".dotSpanStart").empty();
								$(".dotSpanEnd").empty();
								if(parseInt(selectedButton)>3)
									{$("#pageNumber0").after("<span class='dotSpanStart'>...</span>");}
								
								$("#pageNumber"+(totalPages-1)).show();
								if(parseInt(selectedButton)<(totalPages-3))
									{$("#pageNumber"+(totalPages-1)).before("<span class='dotSpanEnd'>...</span>");}
								
								}
						}
					});
	
</script>
<div id="main_div"
	style="height: 100%; background-color: rgba(245, 245, 245, 1);">

	<div>

		<!-- <form  action="/newAssessment" method="post">-->
		<!--<div align="right">
			Welcome <b><c:out value="${sessionScope.username}" /></b>
			<!-- <input  align="right" class="button btn-warning" type="submit"  value="Take new assessment"/>-->
		<!--</div>
		<!-- </form>-->

	</div>
<table id="tbl_result" class="table table-striped"
		style="width: 60%; margin-top: 2%;border-bottom: 1px solid #337ab7" align="center" >
        <tr style="background-color: transparent;" >
        <td style="border-top: 0px none white;" id="pagination_row" colspan="6" align="center"></td>
        </tr>
		<tr  style="background-color: #337ab7">
			<td  colspan="6" style="color: white" align="center"><b><center>Assessment 
						History</center></b></td>
		</tr>
		<tr>
		    <td><b> User Name </b></td>
			<td><b> Assessment name </b></td>
			<td><b> Score </b></td>
			<td><b> Result </b></td>
			<td><b> Number Of Attempts </b></td>
			<td><b> Last Attempt Date </b></td>

		</tr>
		<tbody id="tbl_body">
			<c:forEach items="${assessHistoryList}" var="obj">
				<c:if test="${obj.result=='Fail'}">
				<tr class="table danger">
				</c:if>
				<c:if test="${obj.result=='Pass'}">
				<tr class="table success">
				</c:if>
				    <td><c:out value="${obj.user_name}" /></td>
					<td>
					<a href="#" onclick="return popupFromText($(this).html())"><c:out value="${obj.category_name}" /></a>
					</td>
					<td align="left"><c:out value="${obj.score}" /></td>
					<td><c:if test="${obj.result=='Fail'}">
							<span style="color: red;font-weight:bold"><c:out value="${obj.result}" /></span>
						</c:if> <c:if test="${obj.result=='Pass'}">
							<span style="color: green;font-weight:bold"><c:out value="${obj.result}" /></span>
						</c:if></td>
					<td><c:out value="${obj.num_of_attempts}" /></td>
					<td><c:out value="${obj.last_attempt_date}" /></td>
				</tr>
				
				

			</c:forEach>
		</tbody>
	</table>
	</div>
