<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String view_comment = request.getParameter("view_comment");

String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");

//작성일
Date now = new Date();
String strNow1 = now.toString();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String signdate = sdf.format(now);

String sql = "insert into comment (tb_table,tb_uid,tb_id,tb_name,tb_comment,tb_date) values ('"+code+"',"+uid+",'"+session_id+"','"+session_nickname+"','"+view_comment+"','"+signdate+"')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

//response.sendRedirect("");
%>
<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>











