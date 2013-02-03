<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>My Application</title>
	<link href="<c:url value="/resources/form.css" />" rel="stylesheet"  type="text/css" />		
	<link href="<c:url value="/resources/myapp.css" />" rel="stylesheet"  type="text/css" />
	<link href="<c:url value="/resources/jqueryui/1.8/themes/base/jquery.ui.all.css" />" rel="stylesheet" type="text/css"/>
	<script type="text/javascript" src="<c:url value="/resources/jquery/1.4/jquery.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/jqueryform/2.4/jquery.form.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.core.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.widget.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/jqueryui/1.8/jquery.ui.tabs.js" />"></script>
	<script type="text/javascript" src="<c:url value="/resources/json2.js" />"></script>
	<script>
		MvcUtil = {};
		MvcUtil.showSuccessResponse = function (text, element) {
			MvcUtil.showResponse("success", text, element);
		};
		MvcUtil.showErrorResponse = function showErrorResponse(text, element) {
			MvcUtil.showResponse("error", text, element);
		};
		MvcUtil.showResponse = function(type, text, element) {
			if(type == "success") {
				if($('#list li').length == 10) {
					$('#list li:last').remove();
				}				
				$('#list li:first').after("<li class=\"listyle\">"+text+"</li>");
				//element.prepend("<li class=\"listyle\">"+text+"</li>");
			}
			if(type == "error") {
				element.animate({height:'20px',opacity:'1.0'},"fast");
				element.html('');
				element.append("<font color=\"red\">"+text+"</font>");
				element.show();
				element.slideUp(1000);
			}
			
		};
	</script>	
</head>
<body>
<p><button id="clickMe" class="clickMeButtonStyle" type="submit"><font class="buttonLabel">Click Me</font></button></p>
		<div id="errorPanel" class="errorPanelStyle"></div>
		<ul id="list">
			<li class="listyle"><b>Movie title</b></li>
		</ul>

		<script type="text/javascript">
			$(document).ready(function() {
				$("#errorPanel").hide();
				$("#clickMe").click(function(){
					var list = $("#list");
					var errDiv = $("#errorPanel");
					$.ajax({ url: "<c:url value="/mvc/json" />", dataType: "json", success: function(json) { MvcUtil.showSuccessResponse(json.name , list); }, error: function(xhr) {MvcUtil.showErrorResponse(xhr.responseText, errDiv); }});
					return false;
				});
					 
			});
		</script>
</body>
</html>
