<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
   	<style>
        body{
            background: #F8F8F8;
        }
        #L1{
            background: #DDE3E9;
            color: #D00109;
            border-radius: 6px;
            width: 200px;
            height: 30px;
            font-size: 12px;
        }
        #L2{
            background: #414141;
            color: lightgrey;
            border-radius: 6px;
            width: 50px;
            height: 30px;
            font-size: 12px;
        }
        #t1{
           font-size: 20px;
        }
        a{
            text-decoration: none;
            color: #D00109;
        }
        a:visited{
            color: red;
        }
        a:hover{
            color: green;
        }
        a:active{
            color: darkred;
        }
        a:focus{
            color: blueviolet;
        }
   	</style>
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
                <a href=/index.jsp><img src="../img/at.png" height="200"></a>
            </td>
           	<td valign=top style="text-align: right; padding-right: 40px">
           		<%
				if(session_id == null){	//로그인 전
				%>
           			<a href=../member/login.jsp>LOGIN</a>&ensp;
           			<a href=../member/join.jsp>SIGNUP</a>
           		<%
				}else{
				%>
					<a href=../member/logout.jsp>LOGOUT</a>&ensp;
					<%if(session_level != null && session_level.equals("99")){ %>
           				<a class="a1" href=/admin/index.jsp>ADMIN</a>
           			<%}else{%>
           				<a class="a1" href=../member/confirm.jsp>PROFILE</a>
           			<%}%>
				<%
				}
				%>
           	</td>
        </tr>
    </table>
</header>