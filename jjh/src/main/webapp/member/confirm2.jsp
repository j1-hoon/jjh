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
String id = request.getParameter("id");
String pass = request.getParameter("pass");

String sql = "select count(*) from member where id = '"+id+"'";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);	//select 구문일 경우

//데이터베이스에 아이디 존재 유무
int num = 0;
while(rs.next()){
	num = rs.getInt(1);
}

rs.close();
stmt.close();
con.close();

if(num == 1){	//아이디가 존재함
	String sql2 = "select * from member where id = '"+id+"' and pass = '"+pass+"'";
	
	Connection con2 = DriverManager.getConnection(url, user, password);
	Statement stmt2 = con2.createStatement();
	ResultSet rs2 = stmt2.executeQuery(sql2);
	
	String s_id = "";	//로그인한 아이디
	String s_nickname = "";
	String s_level = "";
	while(rs2.next()){
		s_id = rs2.getString("id");
		s_nickname = rs2.getString("nickname");
		s_level = rs2.getString("level");
	}
	
	if(s_id.equals("")){	//비밀번호가 틀린 경우
	%>
		<script>
		alert("Password doesn't match.");
		history.back();
		</script>
	<%
	}else{		//로그인 성공	:	session 객체 이용
		response.sendRedirect("modify.jsp");
	}
	
}else{
%>
	<script>
		alert("존재하지 않는 아이디입니다.");
		history.back();
	</script>
<%
}
%>
</body>
</html>