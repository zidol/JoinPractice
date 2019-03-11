<%@ page language="java" contentType="text/html; charset=UTF-8" errorPage="error.jsp"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<%
		session = request.getSession(false);
		session.invalidate();
	%>
	<script type="text/javascript">
	parent.location.href="index.html";
</script>
</body>
</html>