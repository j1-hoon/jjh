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
String pass = request.getParameter("pass");
String nickname = request.getParameter("nickname");
String email = request.getParameter("email");
String z1 = request.getParameter("z1");
String z2 = request.getParameter("z2");
String z3 = request.getParameter("z3");
String z4 = request.getParameter("z4");

//아이디 중복 체크
String sql2 = "select count(*) from member where id = '"+id+"'";
Connection con2 = DriverManager.getConnection(url, user, password);
Statement stmt2 = con2.createStatement();
ResultSet rs = stmt2.executeQuery(sql2);

int num = 0;
while(rs.next()){
	num = rs.getInt(1);
}

rs.close();
stmt2.close();
con2.close();

//작성일
Date now = new Date();
String strNow1 = now.toString();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = sdf.format(now);

if(num == 0){
	//회원가입
	String sql = "insert into member(id, pass, nickname, email, z1, z2, z3, z4, signdate) values ('"+id+"', '"+pass+"', '"+nickname+"', '"+email+"','"+z1+"', '"+z2+"', '"+z3+"', '"+z4+"', '"+signdate+"')";

	Connection con = DriverManager.getConnection(url, user, password);
	Statement stmt = con.createStatement();
	stmt.executeUpdate(sql);

	stmt.close();
	con.close();
	%>
	<script>
	location.href="/"
	</script>
	<%
}else{
	%>
	<script>
	alert("The ID already exists")
	history.back()
	</script>
	<%
}


%>
</body>
</html>