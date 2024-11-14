<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
   	<link rel="stylesheet" href="/admin/css/basic.css" type="text/css">
</head>
<header>
<%
String session_id = (String)session.getAttribute("id");
String session_nickname = (String)session.getAttribute("nickname");
String session_level = (String)session.getAttribute("level");
%>
    <table valign=top width=100% height=200 style="background: black; color: white">
        <tr>
            <td>
                <a href=/index.jsp><img src="/img/at.png" height="200"></a>
            </td>
            <td valign=bottom style="padding-bottom:10px; padding-left:435px;">
            	<a class="a2" href="/admin/member/list.jsp">회원관리</a>&ensp;&ensp;&ensp;&ensp;
            	<a class="a2" href="/admin/board/list.jsp">게시물관리</a>&ensp;&ensp;&ensp;&ensp;
            	<a class="a2" href="/admin/category/list.jsp">선수명단</a>&ensp;&ensp;&ensp;&ensp;

            </td>
        </tr>
    </table>
</header>