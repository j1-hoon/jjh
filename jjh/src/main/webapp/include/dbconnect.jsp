<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>  

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
//디비 접속	
Class.forName("org.mariadb.jdbc.Driver");
String url="jdbc:mariadb://localhost:3306/project1"; //데이타베이스명 : project1
String user="root"; //관리자 아이디
String password="1111"; //관리자 비밀번호
%>