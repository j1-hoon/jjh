<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String id = request.getParameter("id");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String z1 = request.getParameter("z1");
String z2 = request.getParameter("z2");
String z3 = request.getParameter("z3");
String z4 = request.getParameter("z4");

String sql = "update member set nickname='"+nickname+"', email='"+email+"', z1='"+z1+"', z2='"+z2+"', z3='"+z3+"', z4='"+z4+"' where id='"+id+"'";;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

stmt.close();
con.close();
%>

	<script>
	alert("회원님의 정보가 수정되었습니다.");
	location.href="/member/modify.jsp"
	</script>
</body>
</html>