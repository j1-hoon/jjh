<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<%
String uid = request.getParameter("uid");
String code = request.getParameter("code");
String gongji = request.getParameter("gongji");
String subject = request.getParameter("subject");
String comment = request.getParameter("comment");

String sql = "update " + code + " set gongji='" + gongji + "', subject='" + subject + "', comment='" + comment + "' where uid=" + uid;
Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

//response.sendRedirect("list.jsp");
response.sendRedirect("view.jsp?code=" + code + "&uid=" + uid);
%>












