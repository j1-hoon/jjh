<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리

String uploadPath="C:\\jsp\\web02\\src\\main\\webapp\\upload";
int size=10*1024*1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String uid = multi.getParameter("uid");
String gongji = multi.getParameter("gongji");
String subject = multi.getParameter("subject");
String comment = multi.getParameter("comment");
String field = multi.getParameter("field");
String search = multi.getParameter("search");
String page_now = multi.getParameter("page_now");

Enumeration files=multi.getFileNames();

//첨부파일1
String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_name=multi.getOriginalFileName(file1); //사용자가 올린 파일명
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경

if(file1_name == null){ //첨부파일1 없다면
	file1_name = ""; //null 값이 아닌 비어있는 값으로 대체
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

//디비 수정

String sql;
if(file1_name != null && file1_name != ""){ //첨부파일 존재
	sql = "update board set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"',file1='"+file1_rename+"',file1_o='"+file1_name+"' where uid="+uid;
}else{
	sql = "update board set subject='"+subject+"',comment='"+comment+"',gongji='"+gongji+"' where uid="+uid;
}

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

//response.sendRedirect("list.jsp");
//response.sendRedirect("view.jsp?code="+code+"&uid="+uid);
%>
<script>
	location.href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>











