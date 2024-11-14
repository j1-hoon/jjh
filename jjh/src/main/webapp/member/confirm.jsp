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
            background-image: linear-gradient(
                rgba(0, 0, 0, 0.8),
                rgba(0, 0, 0, 0.8)
            ), url(../img/stadium.jpg);
            background-size: cover;
        }
        #t0{
            background: lightgrey;
            border-radius: 3px;
        }
        #t1{
            background: #414141;
            color: #969696;
            border-radius: 6px;
            width: 250px;
            height: 50px;
        }
        #t3{
            background: #414141;
            color: #969696;
            border-radius: 6px;
            width: 300px;
            height: 50px;
        }
        #t2{
            background: #D00109;
            color: lightgrey;
            border-radius: 6px;
            width: 300px;
            height: 50px;
        }
        .p1{
        	color: white;
            border: 0px;
            background: #414141;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<%
String session_id = (String)session.getAttribute("id");

%>


    <table height=220>
        <tr>
            <td></td>
        </tr>
    </table>
    <form action="confirm2.jsp" method="post" onsubmit="return join()">
    <table id="t0" align=center>
        <tr>
            <td width=40></td>
            <td colspan="2" height=70></td>
            <td width=40></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=center><img src="../img/info.png" width=65 style="padding-bottom: 30px; padding-left: 9px"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center><input class="p1" id="id" name="id" value="<%=session_id%>" placeholder="ID" readonly="readonly"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center><input class="p1" id="pass" name="pass" value="" type="password" placeholder="confirm password"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table align=center>
                    <tr>
                        <td align=center><button id="t2">CHECK</button></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=right><a href=login.jsp></a></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" height=60></td>
            <td></td>
        </tr>
    </table>
    </form>
</body>
</html>

