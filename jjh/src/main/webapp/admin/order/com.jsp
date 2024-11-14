<%@ page language="java" contentType="text/html; charset=UTF-8"
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

String sql = "update order1 set status='deposit' where uid='"+uid+"'";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

stmt.close();
con.close();

response.sendRedirect("/admin/order/deposit.jsp");

%>


</body>
</html>