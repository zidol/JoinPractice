<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
			String userid = request.getParameter("userid");
			String password = request.getParameter("password");
			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			String query = new String();
			String name = new String();
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e);
			}
			
			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useSSL=false", "multi", "1234");
				stmt = conn.createStatement();
			} catch (SQLException e) {
				out.println(e);
			}
			
			boolean bLogin = false;
			try {
				query = "select * from member where userid = '" + userid +"'";
				query += " and password = '" + password + "'";
				rs = stmt.executeQuery(query);
				if(rs.next()) {
					name = rs.getString("username");
					bLogin = true;
				} else {
					bLogin = false;
				}
				rs.close();
			} catch (SQLException e) {
				out.println(e);
			} finally {
				conn.close();
			}
			
			if (bLogin) {
				session.setAttribute("member_id", userid);
				session.setAttribute("member_name", name);
				response.sendRedirect("left_Frame.jsp");
			} else {
				out.println("<script>alert('아이디와 비밀번호를 확인하세요.'); history.back();</script>");
			}
		%>
</body>
</html>