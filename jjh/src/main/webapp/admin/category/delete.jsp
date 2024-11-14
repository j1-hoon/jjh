<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String uid = request.getParameter("uid");

String sql_id = "delete from category where uid="+uid;

Connection con_id = DriverManager.getConnection(url, user, password);
Statement stmt_id = con_id.createStatement();
stmt_id.executeUpdate(sql_id);

response.sendRedirect("/admin/category/list.jsp");

%>