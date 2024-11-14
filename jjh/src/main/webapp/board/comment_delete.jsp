<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<%
request.setCharacterEncoding("utf-8");

String code = request.getParameter("code");
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");
String com_uid = request.getParameter("com_uid"); //댓글 uid

//삭제
String sql = "delete from comment where uid="+com_uid;

Connection conn=DriverManager.getConnection(url, user, password);
Statement stmt=conn.createStatement();
stmt.executeUpdate(sql);

stmt.close();
conn.close();
%>

<script type="text/javascript">
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>