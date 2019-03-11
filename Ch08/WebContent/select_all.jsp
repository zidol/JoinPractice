<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 회원 정보 관리</title>
<link rel = "StyleSheet" href="style.css" type="text/css">
</head>
<body>
	<%	
		Connection con = null;
		Statement st = null;
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
			st = con.createStatement();
			rs = st.executeQuery("select * from member order by userid");
		
	%>
	<table width="500" border="1" bordercolorlight = "#999999" bordercolordark="#ffffff" cellpadding="3" cellspacing="0" align="center" class="style2">
		<th>사용자 이름</th>
		<th>이름</th>
		<th>주소</th>
		<% if(!(rs.next())) { %>
		<tr><td colspan="4">등록된 회원이 없습니다</td></tr>
		<%} else {
			do {
				out.println("<tr>");
				out.println("<td align='center'>" + rs.getString("userid") + "</td>");
				out.println("<td align='center'>" + rs.getString("username") + "</td>");
				out.println("<td>" + rs.getString("address1"));
				out.println(rs.getString("address2") + "</td>");
				out.println("</tr>");
			} while(rs.next());
		}
		rs.close();
		st.close();
		con.close();
		} catch (SQLException e) {
			System.out.println(e);
		}
		%>
	</table>
</body>
</html>