<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String code = request.getParameter("code");
String uid = request.getParameter("uid");
String gongji = request.getParameter("gongji");
String subject = request.getParameter("subject");
String comment = request.getParameter("comment");

String sql = "update board set code='"+code+"',gongji='"+gongji+"',subject='"+subject+"',comment='"+comment+"' where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

//response.sendRedirect("list.jsp");
response.sendRedirect("/admin/board/list.jsp");
%>












