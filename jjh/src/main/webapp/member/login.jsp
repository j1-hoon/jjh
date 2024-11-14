<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<%
String chek = null;
String userid = "";
Cookie[] cookie = request.getCookies();
if(cookie != null){
	for(int i=0; i<cookie.length; i++){
		if(cookie[i].getName().equals("remember")){
			chek = "checked";
			userid = cookie[i].getValue();
			System.out.println(userid);
		}
	}
}
%>
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

<script>
function login(){
	if(id.value == ''){
		alert("아이디를 입력하세요!");
		id.focus();
		return false;
	}
	if(pass.value == ''){
		alert("비밀번호를 입력하세요!");
		pass.focus();
		return false;
}
</script>

    <table height=200>
        <tr>
            <td></td>
        </tr>
    </table>
    <form action="login_2.jsp" method="post" onsubmit="return login()">
    <table id="t0" align=center>
        <tr>
            <td width=40></td>
            <td colspan="2" height=70></td>
            <td width=40></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=center><img src="../img/login.png" width=50 style="padding-bottom: 30px"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t1" align=center>
                    <tr>
                        <td align=center><input class="p1" id="id" name="id" value="<%=userid%>" placeholder="ID"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t1" align=center>
                    <tr>
                        <td align=center><input class="p1" id="pass" name="pass" value="" type="password" placeholder="PASSWORD"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td align=left style="font-size: 12px"><input type="checkbox" name="remember" value="chk"<%=chek%>>Remember ID</td>
            <td align=right style="font-size: 12px"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" style="padding-top: 20px">
                <table align=center>
                    <tr>
                        <td align=center><button id="t2">LOGIN</button></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=right style="color: #D00109"><a href="join.jsp">sign up</a></td>
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