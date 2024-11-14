<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String uid = request.getParameter("uid");
String soldout = request.getParameter("soldout");

String sql = "";

if(soldout.equals("o")){
	sql = "update shop set soldout='x' where uid="+ uid;
}else{
	sql = "update shop set soldout='o' where uid="+ uid;
}

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("/admin/shop/list.jsp");

%>