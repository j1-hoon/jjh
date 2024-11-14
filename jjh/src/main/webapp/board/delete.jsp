<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<%
String uid = request.getParameter("uid");
String code = request.getParameter("code");


String sql = "delete from board where uid=" + uid;
Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("list.jsp?code=" + code);
%>












