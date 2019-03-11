<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<%
		String admPwd = "manager";
		String password = request.getParameter("password");
		if(admPwd.equals(password)) 
			response.sendRedirect(response.encodeRedirectURL("select_all.jsp"));
		 else {
	%>
	<script type="text/javascript">
		alert("인증이 허용된 사람만 가능 합니다.")
	</script>
<link rel = "StyleSheet" href="style.css" type="text/css">
<title>우리회원 정보 관리</title>
</head>
<body>
	<table width="500" border="1" bordercolorlight = "#999999" bordercolordark="#ffffff" cellpadding="3" cellspacing="0" align="center" class="style2">
		<th>관리자 승인</th>
			<tr>
				<td align="center">
				<form action="admin.jsp" name="form1" method="post">
					<br> 관리자 비밀 번호 :
					<input type="password" name="password">
					<p>
					<input type="submit" name="change" value="확인">&nbsp;
					<input type="button" value="취소" onclick="javascript:history.go(-1)"> 
				</form>
				</td>
			</tr>
			<tr>
				<td align="center">Copyright by jsp Study</td>
			</tr>
	</table>
</body>
</html>
<% } %>