<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
String uid = request.getParameter("uid");
String num = request.getParameter("num");
String tab= request.getParameter("tab");
String title = request.getParameter("title");

String sql = "update category set num='" + num +"', tab='"+tab+"', title='"+title+"' where uid="+ uid;


Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

stmt.close();
con.close();
%>

	<script>
	alert("Modified complete");
	location.href="/admin/category/list.jsp"
	</script>

