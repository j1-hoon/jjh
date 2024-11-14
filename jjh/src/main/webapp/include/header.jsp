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
.dark {
  background: #212529;
}

body{
    background-image: linear-gradient(
                    rgba(0, 0, 0, 0.8),
                    rgba(0, 0, 0, 0.8)
                ), url(/img/header.jpg);
    background-size: cover;
}

.page-navbar .nav-navbar {
  height: 100%;
  list-style-type: none;
  padding-left: 0;
  display: flex;
}


.page-navbar .nav-navbar .nav-link {
  text-align: center;
  flex-grow: 1;
  color: #f8f9fa;
  font-weight: bold;
  text-decoration: none;
  font-size: 17px;
}

.page-navbar .nav-navbar .nav-link i {
  font-weight: bold;
  display: inline-block;
  margin-right: 3px;
  position: relative;
  top: 1px;
  font-size: 14px;
}

.page-navbar .nav-navbar{
  position: relative;
}

.page-navbar .nav-navbar{
  border-radius: 0.25rem;
  border-width: 1px;
  padding: 5px 8px;
  margin: 0;
}

.page-navbar.affix .nav-link {
  color: #fff;
}
    
.header {
  z-index: 990;
  position: relative;
  height: 100%;
  min-height: 600px;
  text-align: center;
  color: #fff;
  background-image: url(../imgs/header.jpg);
  background-size: cover;
  background-position: center;
  -webkit-transition: .2s;
  transition: .2s;
  -webkit-transition-timing-function: linear;
          transition-timing-function: linear;
}

.header .overlay {
  position: absolute;
  left: 0;
  top: 0;
  height: 100%;
  width: 100%;
}

.header .header-content {
  position: absolute;
	  left: 43.8%;
	  top: 43%;

}

.header .header-content .header-title {
  font-size: 65px;
  margin-top: 15px;
  margin-bottom: 10px;
  font-weight: bold;
}

.header .header-content .header-subtitle {
  opacity: 1;
  margin-bottom: 30px;
}

.header-title {
  font-weight: bold;
  opacity: .8;
}
    
.page-container {
  text-align: center;
  padding: 50px 0;
}

.mb-5,
.my-5 {
  margin-bottom: 3rem !important;
}
    
.box .info {
  color: #fff;
  position: absolute; left: 10; top: 5;
  background: rgba(0,0,0,0.5);
  width: 300px;
  height: 120px;
  padding: 15px;
  box-sizing: border-box;
  opacity: 0;
  transition: opacity 0.35s ease-in-out;
}
.box:hover .info {
  opacity: 1;
}
.box .info h3 {
  font-size: 20px;
  overflow:hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  text-transform: uppercase;
}
.box .info p {
  font-size: 15px;
  text-overflow: ellipsis;
  white-space: nowrap;
  text-transform: uppercase;
}
a{
  text-decoration: none;
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

<body>
<%
String session_id = (String)session.getAttribute("id");
String session_nickname = (String)session.getAttribute("nickname");
String session_level = (String)session.getAttribute("level");
%>
<table width=100%>
  <tr>
	<td align=center>
	    <table width=800 class="page-navbar" >
	    	<tr>
	    		<td align=right>
	    			<table class="page-navbar">
	                <tr>
	                    <td class="a1" valign=top width=400 style="padding-left:1700px">
			           		<%
							if(session_id == null){	//로그인 전
							%>
								<table>
									<tr>
										<td><a href=../member/login.jsp>LOGIN</a>&ensp;</td>
										<td><a href=../member/join.jsp>SIGNUP</a></td>
									</tr>
								</table>	
			           		<%
							}else{
							%>	
								<table>
									<tr>
										<td><a href=../member/logout.jsp>LOGOUT</a>&ensp;</td>
										<td>
											<%if(session_level != null && session_level.equals("99")){ %>
						           				<a class="a1" href=/admin/index.jsp>ADMIN</a>
						           			<%}else{%>
						           				<a class="a1" href=../member/confirm.jsp>PROFILE</a>
						           			<%}%>
										</td>
									</tr>
								</table>	
							<%
							}
							%>
			           	</td>
	                </tr>
   					</table>
	    		</td>
	    	</tr>
	        <tr>
	        	<td align=center>
	        		<table>
	        			<tr>
	        				<td align=center>
				            	<ul class="nav-navbar container" align=center>
									<li class="nav-item" style="paddinig-left:30px"><a href="/searchview.jsp" class="nav-link">NEWS</a></li>&ensp;&ensp;&ensp;&ensp;&ensp;
									<li class="nav-item"><a href="/team.jsp" class="nav-link">SQUAD</a></li>&ensp;&ensp;&ensp;&ensp;&ensp;
									<li class="nav-item"><a href="/index.jsp" class="nav-link"><img src="/img/alogo.png" width=45></a></li>&ensp;&ensp;&ensp;&ensp;&ensp;
									<li class="nav-item"><a href="/board/list.jsp" class="nav-link">BOARD</a></li>&ensp;&ensp;&ensp;&ensp;&ensp;
									<li class="nav-item"><a href="/list/list.jsp?code=product" class="nav-link">SHOP</a></li>  
								</ul>
				            </td>
	        			</tr>
	        		</table>
	        	</td>
	         </tr>
	    </table>

	    
	    		