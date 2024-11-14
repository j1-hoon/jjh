<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>

</head>
<style>
@charset "UTF-8";
		table{
			border-collapse: collapse;
		}
		.page_on {
			padding:0px 5px;
			color:#D00109;
			border:0px;
			font-weight:bold;
		}
		.page_off {
			padding:0px 5px;
			color:black;
			border:0px;
		}	
	   .b1{
            background:#EEEEEE;
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
    body{
        padding: 1.5em;
        background: #f5f5f5;
    }
    .t1{
        border: 1px solid #a39485;
        font-size: 0.9em;
        box-shadow: 0 2px 5px rgba(0,0,0,0.25);
        width: 100%;
        border-collapse: collapse;
        border-radius: 5px;
        overflow: hidden;
    }
    th{
        text-align: left;
    }
    thead{
        font-weight: bold;
        color: #fff;
        background: #73685d;
    }
    td, th {
        padding: 1em .5em;
        vertical-align: middle;
    }
    hr{
        background: pink;
    }
    button{
        width: 50px;
        height: 30px;
        color: #353535;
    }
</style>

<script>
function delete_go(str){
	result = confirm("Are you sure you want to delete it?");
	if(result == true){
		location.href="delete.jsp?id="+str;
	}
}

function delete_go(num){
	result = confirm("Are you sure you want to delete it?");
	if(result == true){
		location.href="delete.jsp?uid="+num;
	}
}

</script>

<%
String session_id = (String)session.getAttribute("id");
String session_nickname = (String)session.getAttribute("nickname");
String session_level = (String)session.getAttribute("level");
%>
<script>
admin_level = "<%=session_level%>"
if(admin_level != "99"){
	alert("관리자 영역입니다.");
	location.href="/";
}
</script>
<body class="b1">
    <table width=100%>
		<tr>
			<td>
				<table  width=1920>
					<tr>
						<td width=250>
                            <table class="t1" width=240 height=715 style="padding-left: 15px; background: #353535; color: white">
                                <tr><td height=30><img src="/admin/img/logo.png" width=60></td></tr>
                                <tr><td style="font-size:17px">Arsenal</td></tr>
                                <tr><td><a href="/index.jsp" style="color:#CDA697">User page</td></a></tr>
                                <tr><td>--------------------------------------</td></tr>
                                <tr><td style="font-size: 15px"><a href="/admin/administrator.jsp" style="color:white">Administrator</a></td></tr>                            
                                <tr><td style="font-size: 14px">Management</td></tr>
                                <tr><td style="font-size: 12px"><a class="a2" href="/admin/member/list.jsp">Members</a></td></tr>
                                <tr><td style="font-size: 12px"><a class="a2" href="/admin/board/list.jsp">Posts</a></td></tr>
                                <tr><td style="font-size: 14px">Registration</td></tr>                           
                                <tr><td style="font-size: 12px"><a class="a2" href="/admin/category/list.jsp">Players</a></td></tr>
                                <tr><td style="font-size: 12px"><a class="a2" href="/admin/shop/list.jsp">Products</a></td></tr>
                                <tr><td style="font-size: 14px">Shopping</td></tr>                          
                                <tr><td style="font-size: 12px"><a class="a2" href="/admin/order/list.jsp">Order Info</a></td></tr>
                            </table>
                        </td>
						<td width=1590>
						    <table class="t1" width=1590 height=60>
						        <tr>
						            <td><a href="/admin/index.jsp" style="color:black">Administrator<img src="/admin/img/admin.png" width=12></a></td>
						        </tr>
						    </table>