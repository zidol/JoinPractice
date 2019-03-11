<%@page import="java.sql.* "%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel = "StyleSheet" href="style.css" type="text/css">
<title>회원정보관리</title>
</head>
<body>
	<%
		Object mem_id = session.getAttribute("member_id");
		session.putValue(session.getId(), mem_id);
		String userid = (String)session.getValue(session.getId());
		
		if(userid == null)
			session.putValue(session.getId(), mem_id);
		
		String sql  = "select * from member where userid=?";
		Connection con = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			out.println(e);
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useSSL=false", "multi", "1234");
		} catch (SQLException e) {
			out.print(e);
		}
		
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, userid);
			rs = pst.executeQuery();
			
			if(!rs.next()) {
				out.println("해당하는 회원이 없습니다.");
			} else {
				String username = rs.getString("username");
				String phone = rs.getString("phone");
			
		
	%>
	
	<form name="join" method="post">
		<input type="hidden" name="userid" value="<%=userid%>">
		<input type="hidden" name="mode" value="modify">
		<table width="500" border="1" bordercolorlight="#999999" bordercolordark="#ffffff"
		cellspacing="3" cellpadding="0" align="center" class="style2">
			<tr>
				<td width="30%" align="right"> 아이디</td>
				<td width="70%"><%=userid %> </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 이름</td>
				<td width="70%"><%=username %> </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 비밀번호</td>
				<td width="70%"> 보안상 기재하지 않습니다. </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 우편번호</td>
				<td width="70%"><%=rs.getString("zipcode") %> </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 주소1</td>
				<td width="70%"><%=rs.getString("address1") %> </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 주소2</td>
				<td width="70%"><%=rs.getString("address2") %> </td>
			</tr>
			<tr>
				<td width="30%" align="right"> 휴대폰</td>
				<td width="70%">
					<%
						if(phone.equals("--")) {
							out.println("<font color='blue'>선택하지 않았습니다.</font>");
						} else {
							out.println(phone);
						}
					%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="left">
					<input type="button" value="확 인" onclick="location='right_Frame.html'">
					<input type="button" value="수 정" onclick="location='modify_session.jsp?mode=modify'">
					<input type="button" value="탈 퇴" onclick="location='delete.jsp'">
				</td>
			</tr>
		</table>
	</form>
	<%
			}
			rs.close();
			con.close();
			pst.close();
		} catch (SQLException e) {
			out.println(e);
		}
	%>
</body>
</html>