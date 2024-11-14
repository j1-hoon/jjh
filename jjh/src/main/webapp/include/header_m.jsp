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
        .a1, .a2{
            text-decoration: none;
            color: #D00109;
        }
        .a1:visited{
            color: red;
        }
        .a2:visited{
            color: #D00109;
        }
        .a1, .a2:hover{
            color: green;
        }
        a:hover{
   			 color: green;
        }
        a{
        	color: red;
        }
        .a1:active{
            color: darkred;
        }
        .a1:focus{
            color: blueviolet;
        }
        .t1{
        border: 1px solid #a39485;
        font-size: 0.9em;
        box-shadow: 0 2px 5px rgba(0,0,0,0.25);
        border-collapse: collapse;
        border-radius: 5px;
        overflow: hidden;
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
            <td style="vertical-align: bottom">
                <a href=/index.jsp><img src="../img/gunner.png" height="175"></a>
            </td>
            <td valign=bottom style="padding-bottom:10px; padding-left:260px;">
            	<a class="a2" href="/searchview.jsp">NEWS</a>&ensp;&ensp;&ensp;&ensp;
				<a class="a2" href="/board/list.jsp">BOARD</a>&ensp;&ensp;&ensp;&ensp;
				<a class="a2" href="/team.jsp">TEAMS</a>&ensp;&ensp;&ensp;&ensp;
				<a class="a2" href="/list/list.jsp?code=product">SHOP</a>
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
           				<a href=/admin/index.jsp>ADMIN</a>
           			<%}else{%>
           				<a href=../list/mypage2.jsp>ORDER</a>
           			<%}%>
				<%
				}
				%>
           	</td>
        </tr>
    </table>
</header>