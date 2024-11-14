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
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String address = request.getParameter("z2") + request.getParameter("z3") + request.getParameter("z4");
String re = request.getParameter("re");
String price = request.getParameter("total");

String sql = "insert into order1 (name, phone, address, re, price) values('" +name + "', '" +phone + "','" + address + "','" + re + "'," + price + ")";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("/list/list.jsp?code=product");
%>
</body>
</html>