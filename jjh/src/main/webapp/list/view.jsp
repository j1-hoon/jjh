<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_m.jsp" %>
<%@ include file="info.jsp" %>

<style>
	table{
		border-collapse: collapse;
	}
	.a5{
        text-decoration: none;
        color: green;
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
    a{
    	text-decoration: none;
    }
</style>
<script>
function delete_go(str,num){
	result = confirm("Are you sure you want to delete it?");
	if(result == true){
		location.href="delete.jsp?code="+str+"&uid="+num;
	}
}
function BuyGo(){
	alert('Please login and fill it out');
	result = confirm("Do you want to go to the login page?");
	if(result == true){
		location.href="/member/login.jsp";
	}
}
</script>

<%
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");

//페이징 관련
String page_now = request.getParameter("page_now");

String sql = "select * from shop where uid="+ uid + code_title;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String price = "";
String comment = "";
String gongji = "";
String name = "";
String signdate = "";
String ref = "";
String id = "";
String file1 = "";
String soldout = "";

if(rs.next()){
	subject = rs.getString("subject");
	price = rs.getString("price");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
	name = rs.getString("name");
	signdate = rs.getString("signdate");
	ref = rs.getString("ref");
	id = rs.getString("id");
	file1 = rs.getString("file1");
	soldout = rs.getString("soldout");
}

String gongji_title = "";
if(gongji.equals("1")){
	gongji_title = "공지";
}else if(gongji.equals("2")){
	gongji_title = "일반";
}else{
	gongji_title = "비밀";
}

rs.close();
stmt.close();
con.close();

if(gongji.equals("3")){ //비밀글 일때
	if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){
		
	}else{
%>
	<script>
		alert("글을 볼 권한이 없습니다.");
		location.href="/";
	</script>
<%
	}
}else{ //공지, 일반글 일때
	
}

//조회수 + 1 처리
String sql_cnt = "update shop set ref=ref+1 where uid="+uid;
Connection con_cnt = DriverManager.getConnection(url, user, password);
Statement stmt_cnt = con_cnt.createStatement();
stmt_cnt.executeUpdate(sql_cnt);

stmt_cnt.close();
con_cnt.close();
%>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800>
				<tr>
					<td align=left><b>[SHOP]</b></td><br>
				</tr>				
			</table>
			<br>
			<hr>
			<table width=800>
				<tr>	
					<td><img src="/upload/<%=file1 %>" width=450 style="padding-right:20px; padding-left:60px "></td>
					<td style="vertical-align: top">
						<table>
							<tr>
								<td style="font-size:25px;"><%=subject%></td>
								<td style="padding-left:90px"></td>
							</tr>
							<tr><td style="font-size:25px; font-weight:bold">₩<%=price%></td></tr>
							<tr><td></td></tr>
							<tr>
								<td>
									<%if(soldout.equals("x")){%>
										<%if(session_id != null){ //로그인 후 %>
										<a href="/list/order.jsp?uid=<%=uid%>"style="text-decoration: none; color:white"><button style="width:300px; height:30px; border-radius:10px; background: #93040C; color:white">Buy</button></a>
										<%}else{ //로그인 전%>
										<a onclick="BuyGo()""style="text-decoration: none; color:white"><button style="width:300px; height:30px; border-radius:10px; background: #93040C; color:white">Buy</button></a>
										<%} %>
									<%}else{%>
										<button style="width:300px; height:30px; border-radius:10px; background: black; color:white">Sold Out</button>
									<%}%>
								</td>
							</tr>
							<tr><td><br><hr><br></td></tr>
							<tr><td style="font-size:25px; font-weight:bold">PRODUCT INFO</td></tr>
							<tr><td><br><%=comment %></td></tr>
						</table>
					</td>
				</tr>
			</table>
			<br>
			<!-- 댓글달기 -->
			<script>
				function comment_go(){
					if(view_comment.value == ""){
						alert('Please write the contents');
						view_comment.focus();
						return false;
					}
				}
				
				function delete_re(str1, num, str2, str3, str4, str5){
					result = confirm("Are you sure you want to delete it?");
					if(result == true){	
						location.href="comment_delete.jsp?code=" + str1 + "&uid=" + num + "&field=" + str2 + "&search=" + str3 + "&page_now=" + str4 + "&com_uid=" + str5;
					}
				}
			</script>	
			<br>
			<table width=800 border=0>
				<tr><td colspan=3 style="border-top:1px solid #666"></td></tr>
				<%
				String sql_comment = "select * from comment where tb_table='"+code+"' and tb_uid="+uid+" order by uid;";
				
				Connection con_comment = DriverManager.getConnection(url, user, password);
				Statement stmt_comment = con_comment.createStatement();
				ResultSet rs_comment = stmt_comment.executeQuery(sql_comment);
				
				int i = 0;
				while(rs_comment.next()){
					int com_uid = rs_comment.getInt("uid");
					String tb_id = rs_comment.getString("tb_id");
					
					Date today = new Date(); //현재 날짜
					
					String r = rs_comment.getString("tb_date").substring(0,10);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String signdate3 = sdf.format(today);
				%>
				<tr>
					<td width=100><%=rs_comment.getString("tb_name") %></td>
					<td><%=rs_comment.getString("tb_comment") %></td>
					<td width=100 align=right>
					<%if(signdate3.equals(r)){%>
						<%=rs_comment.getString("tb_date").substring(10) %>
					<%}else{%>
						<%=rs_comment.getString("tb_date").substring(0,10) %>
					<%}%>
					<%if((session_id != null && session_id.equals(tb_id)) || (session_level != null && session_level.equals("99"))){%>
					<a onclick="delete_re('<%=code%>',<%=uid%>,'<%=field%>','<%=search%>','<%=page_now%>','<%=com_uid%>',)"><button>X</button></a>
					<%}%>
					</td>
				</tr>
				<tr><td colspan=5 style="border-top:1px solid #767676"></td></tr>
				<%
					i++;
				}
				if(i == 0){ //작성된 댓글 내용이 없다.
				%>
				<tr>
					<td style="color:red;height:40px;text-align:center">No comments</td>
				</tr>
				<tr><td style="border-top:1px solid #767676"></td></tr>
				<%
				}
				%>
				
			</table>
			<br>
			<form action="comment_insert.jsp" method="post" onsubmit="return comment_go()">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="uid" value="<%=uid%>">
			<input type="hidden" name="field" value="<%=field%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="page_now" value="<%=page_now%>">
			<%if(session_id != null){%>
			<div style="width:800px; height:100px; border:1px solid black; border-radius:10px; border-color:#767676">
				<table width=800>
					<tr>
						<td width=100 style="padding-top: 13px; padding-left:18px">
							<b>
							<%
								if(session_nickname != null){
									out.print(session_nickname);
								}
							%>
							</b>
						</td>
					</tr>
					<tr>	
						<td align=center><input id="view_comment"name="view_comment" style="width:95%" placeholder="Enter your comments"></td>
					</tr>
					<tr>	
						<td width=100 align=right style="padding-right:18px"><button>Write</button>
					</tr>
				</table>
			<%}%>
			</div>
			</form>
			<!-- 댓글끝 -->	
		</td>
	</tr>
</table>
<br>
<hr>
<%@ include file="/include/f.jsp" %>













