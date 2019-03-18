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
		<%	request.setCharacterEncoding("utf-8");
		
			String mem_id = (String)session.getAttribute("member_id");
			session.setAttribute(session.getId(), mem_id); //setAttribute
			String userid = (String)session.getAttribute(session.getId());//getAttribute
			
			if(userid == null)
				session.setAttribute(session.getId(), mem_id);
			
			userid = (String)session.getAttribute(session.getId());
			Connection con = null;
			Statement st = null;
			String sql = null;
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e.getMessage());
			}
			
			try {
				con = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useSSL=false", "multi", "1234");
				st = con.createStatement();
				sql = "delete from member where userid = '" + userid + "'";
				st.executeUpdate(sql);
				System.out.println("success");
				con.close();
				st.close();
			} catch (SQLException e) {
				out.print(e);
			}
			
		%>
		<jsp:forward page="right_Frame.html"/>
</body>
</html>