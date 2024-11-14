<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
String uid = request.getParameter("uid");
String subject = request.getParameter("subject");
String comment= request.getParameter("comment");
String price = request.getParameter("price");

String sql = "update shop set subject='" + subject +"', comment='"+comment+"', price='"+price+"' where uid="+ uid;


Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

stmt.close();
con.close();
%>

	<script>
	alert("수정되었습니다.");
	location.href="/admin/shop/list.jsp"
	</script>

