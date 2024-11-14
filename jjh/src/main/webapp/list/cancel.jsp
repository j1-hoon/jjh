</body><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String uid = request.getParameter("uid");

String sql_del = "delete from order1 where uid=" + uid;

Connection con_del = DriverManager.getConnection(url, user, password);
Statement stmt_del = con_del.createStatement();
stmt_del.executeUpdate(sql_del);

response.sendRedirect("/list/mypage2.jsp");

%>


</body>
</html>
</html>