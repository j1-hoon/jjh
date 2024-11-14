<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 
//String uploadPath=request.getRealPath("/upload");
String uploadPath="C:\\jsp\\jjh\\src\\main\\webapp\\upload_player"; //window 폴더 내 upload 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String tab  = multi.getParameter("tab");
String title  = multi.getParameter("title");
String num  = multi.getParameter("num");

Enumeration files=multi.getFileNames();

//첨부파일1
String file1=(String)files.nextElement(); //첨부파일1 존재한다면
String file1_rename=multi.getFilesystemName(file1); //중복된 파일명을 새로운 파일명으로 변경

if(file1_rename == null){ //첨부파일1 없다면
	file1_rename = ""; //null 값이 아닌 비어있는 값으로 대체

}

String sql = "insert into category (tab, num, img, title) values ('" + tab + "','" + num + "','" + file1_rename + "','" + title + "')";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
stmt.executeUpdate(sql);

response.sendRedirect("list.jsp");
%>

<%@ include file="/include/footer.jsp" %>