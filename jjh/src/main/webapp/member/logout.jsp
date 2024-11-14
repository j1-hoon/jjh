<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
session.invalidate();	//만든 세션 변수들 모두 삭제처리

response.sendRedirect("/");
%>