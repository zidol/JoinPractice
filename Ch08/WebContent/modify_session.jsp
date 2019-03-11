<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel = "StyleSheet" href="style.css" type="text/css">
<script type="text/javascript">
	function MM_openBrWindow(theURL, winName, features) {
		window.open(theURL, winName, features);
	}
	function doSubmit() {
		form = document.join;
		if(!form.username.value) {
			alert('이름 입력하지 않았습니다.');
			form.userid.focus();
			return;
		}
		if(!form.email.value) {
			alert('Email 주소 입력하지 않았습니다.');
			form.email.focus();
			return;
		}
		if(form.email.value.indexOf("@") < 0) {
			alert('Email 주소 형식이 틀립니다.');
			form.email.focus();
			return;
		}
		if(form.email.value.indexOf(".") < 0) {
			alert('Email 주소 형식이 틀립니다.');
			form.email.focus();
			return;
		}
		if(!form.zipcode1.value || !form.zipcode2.value) {
			alert('우편번호를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbars=yes, width=500, height=250');
			return;
		}
		if(!form.address1.value) {
			alert('주소2를 입력하지 않았습니다.');
			MM_openBrWindow('zipcode_search.jsp', 'zipcode_search', 'scrollbars=yes, width=500, height=250');
			return;
		}
		if(!form.address2.value) {
			alert('주소2를 입력하지 않았습니다.');
			form.address2.focus();
			return;
		}
		
		form.submit();
	}
</script>
<title>회원정보 수정</title>
</head>
<body bgcolor="#ffffff">
		<%
			request.setCharacterEncoding("utf-8");
			
			String mode = request.getParameter("mode");
			String userid = (String)session.getAttribute("member_id");
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String email = request.getParameter("email");
			String zipcode1 = request.getParameter("zipcode1");
			String zipcode2 = request.getParameter("zipcode2");
			String zipcode = zipcode1 + "-" + zipcode2;
			String address1 = request.getParameter("address1");
			String address2 = request.getParameter("address2");
			String phone1 = request.getParameter("phone1");
			String phone2 = request.getParameter("phone2");
			String phone3 = request.getParameter("phone3");
			String phone = phone1 + "-" + phone2 + "-" + phone3;
			StringTokenizer st_zipcode = null;
			StringTokenizer st_phone = null;
			String query = null;
			
			Connection conn = null;
			ResultSet rs = null;
			Statement stmt = null;
			PreparedStatement pstmt = null;
			java.util.Date yymmdd = new java.util.Date();
			SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-dd h:mm a");
			String regdate = myformat.format(yymmdd);
			
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e);
			}

			try {
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useSSL=false", "multi", "1234");
				
				stmt = conn.createStatement();	
				
				if(mode.equals("null") || mode.equals("modify")) {
					query = "select * from member where userid='" + userid + "'";
					rs = stmt.executeQuery(query);
					if(rs.next()) {
						username = rs.getString("username");
						password = rs.getString("password");
						email	= rs.getString("email");
						st_zipcode = new StringTokenizer(rs.getString("zipcode"), "-");
						address1 = rs.getString("address1");
						address2 = rs.getString("address2");
						st_phone = new StringTokenizer(rs.getString("phone"), "-");
						
						if(st_zipcode.hasMoreTokens()) {
							zipcode1 = st_zipcode.nextToken();
						}
						if(st_zipcode.hasMoreTokens()) {
							zipcode2 = st_zipcode.nextToken();
						}
						if(st_phone.hasMoreTokens()) {
							phone1 = st_phone.nextToken();
						}
						if(st_phone.hasMoreTokens()) {
							phone2 = st_phone.nextToken();
						}
						if(st_phone.hasMoreTokens()) {
							phone3 = st_phone.nextToken();
						}
 					}
					rs.close();
				} else if(mode.equals("update")){
					query = "update member set username = ?, password = ?, email = ?, zipcode = ?, address1 = ?, address2 = ?, phone = ? where userid = '" +userid + "'";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, username);
					pstmt.setString(2, password);
					pstmt.setString(3, email);
					pstmt.setString(4, zipcode);
					pstmt.setString(5, address1);
					pstmt.setString(6, address2);
					pstmt.setString(7, phone);
					pstmt.executeUpdate();
					response.sendRedirect("index.html");
				}
				
			} catch (SQLException e) {
				System.out.println(e);
				out.println("<script>alert('수정이 되지 않았습니다. 다시 시도해 주세요.'); history.back();</script>");
			} finally {
				conn.close();
			}
		%>
		<br>
		<br>
		<TABLE align=center cellpadding=8 cellspacing=0 width='650'
		topmargin="0" leftmargin="0" rightmargin="0" marginheight="0"
		marginwidth="0">
		<TR>
			<TD width="650">
				<form name="join" method="post" action="modify_session.jsp">
					<table width="650" height="536" border="1" cellspacing="0"
						cellpadding="0" bordercolor="#A3C2F6">
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">아이디&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp; <input type="text" name="userid"
								size="16" maxlength="16" class="box" value="<%=userid%>" readonly="readonly">
								<font class="style2">(영문+숫자 5~16자리) 
						</tr>
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">비밀번호&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp; <input type="password"
								name="password" size="12" maxlength="12" value="<%=password %>" class="box">
								<font class="style1">다시한번&nbsp;&nbsp; </font> <input
								type="password" name="password2" value="<%=password %>" size="12" maxlength="12"
								class="box"> <font class="style2">(영문+숫자
									4~12자리)</font></td>
						</tr>
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">이름&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp;<input type="text" name="username"
								size="10" maxlength="10" class="box" value="<%=username%>">
							</td>
						</tr>

						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">EMAIL&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp;<input type="text" name="email"
								size="20" maxlength="50" class="box" value="<%=email%>"></td>
						</tr>
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">우편번호&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp; <input type="text" name="zipcode1"
								size="3" maxlength="3" class="box" value="<%=zipcode1%>"> - <input
								type="text" name="zipcode2" size="3" maxlength="3"
								class="box" value="<%=zipcode2%>"> <input name="button" type="button"
								onClick="MM_openBrWindow('zipcode_search.jsp','zipcodesearch','scrollbars=yes,width=500,height=250')"
								value="우편번호 검색"> <font class="style2"><font
									color="#0099FF">우편번호 검색 버튼을 누르세요.</font></font></td>
						</tr>
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">주소&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp;<input type="text" name="address1"
								size="50" maxlength="100" class="box" value="<%=address1 %>" readonly="readonly"></td>
						</tr>
						<tr>
							<td width="15%" align="right"><font color="#FF0000" size=1>★</font><font
								class="style1">나머지 주소&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp; <input type="text" name="address2"
								size="50" maxlength="100" class="box" value="<%=address2%>"> 
						</tr>
						<tr>
							<td width="15%" align="right"><font class="style1">핸드폰&nbsp;&nbsp;</font></td>
							<td width="75%">&nbsp; <input type="text" name="phone1" size="4" maxlength="4"
								class="box" value="<%=phone1%>"> - <input type="text" name="phone2" size="4" maxlength="4"
								class="box" value="<%=phone2%>"> - <input type="text" name="phone3"
								size="4" maxlength="4" class="box" value="<%=phone3%>"></td>
						</tr>
					</table>
					<br>
					<table width="614" border="0" cellspacing="0" cellpadding="0"
						align="center">
						<tr>
							<td width=100% align="center">
								<input type="hidden" name="mode" value="update"> 
								<input type="button" value="등   록" onClick="doSubmit()">&nbsp; 
								<input type="button" value="취   소" onClick="javascript:history.go(-1);"></td>
						</tr>
					</table>
				</form>
			</TD>
		</TR>
	</TABLE>
	<div align="center">

		<table width="638" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td bgcolor="#FFFFFF" width="638" nowrap><p align="center">
						<br>Copyright by JSP Study
					</p></td>
			</tr>
		</table>
	</div>
	<p>&nbsp;</p>
		
</body>
</html>