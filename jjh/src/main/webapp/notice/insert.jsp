<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
String gongji = request.getParameter("gongji");
String subject = request.getParameter("subject");
String comment = request.getParameter("comment");

//작성일
Date now = new Date();
String strNow1 = now.toString();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = sdf.format(now);

String sql = "insert into notice (id,name,subject,comment,signdate,gongji) values ('"+session_id+"','"+session_nickname+"','"+subject+"','"+comment+"','"+signdate+"','"+gongji+"')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("list.jsp");
%>












