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
String name = (String)session.getAttribute("id");
String subject = request.getParameter("subject");
String file1 = request.getParameter("file1");
String phone = request.getParameter("phone");
String re = request.getParameter("request");
String price = request.getParameter("price");
String address = request.getParameter("z2") + request.getParameter("z3") + request.getParameter("z4");
String payment_name = request.getParameter("name");

//작성일
Date now = new Date();
String strNow1 = now.toString();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
String signdate = sdf.format(now);


String sql = "insert into order1 (subject, file1, name, phone, re, price, address, signdate, payment_name) values ('"+subject+"', '"+file1+"', '"+name+"', '"+phone+"', '"+re+"', '"+price+"','"+address+"', '"+signdate+"', '"+payment_name+"')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("/list/list.jsp?code=product");
%>


</body>
</html>