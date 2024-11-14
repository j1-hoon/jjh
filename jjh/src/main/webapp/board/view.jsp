<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>
<%@ include file="info.jsp" %>

<style>
	table{
		border-collapse: collapse;
	}
	.a5{
        text-decoration: none;
        color: green;
    }
    .a4{color:black}
    .a4:hover{color:black}
    .a4:link{color:black;}
	.a4:visited{color:black;}
	a{text-decoration-line: none;}
	.board_a{
		color:red;
	}
	.board_a:hover{
		color:green;
	}
</style>
<script>
function delete_go(str,num){
	result = confirm("Are you sure you want to delete it?");
	if(result == true){
		location.href="delete.jsp?code="+str+"&uid="+num;
	}
}
</script>

<%
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");

//페이징 관련
String page_now = request.getParameter("page_now");

String sql = "select *,(select count(*) from comment where tb_uid=board.uid) as count from board where uid="+ uid + code_title;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String gongji = "";
String name = "";
String signdate = "";
String ref = "";
String id = "";
String file1 = "";
String fid = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
	name = rs.getString("name");
	signdate = rs.getString("signdate");
	ref = rs.getString("ref");
	id = rs.getString("id");
	file1 = rs.getString("file1");
	fid = rs.getString("fid");
}

int count = rs.getInt("count");

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

String fid_1 = "";
String sql_fid = "SELECT id FROM board WHERE fid = " + fid;
Connection con_fid = DriverManager.getConnection(url, user, password);
Statement stmt_fid = con_fid.createStatement();
ResultSet rs_fid = stmt_fid.executeQuery(sql_fid);
if (rs_fid.next()) {
    fid_1 = rs_fid.getString("id");
}
rs_fid.close();
stmt_fid.close();

if(gongji.equals("3") && !code.equals("qna")){ //비밀글 일때
	if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){
		
	}else{
%>
	<script>
		alert("글을 볼 권한이 없습니다.");
		location.href="/";
	</script>
<%
	}
}else if(gongji.equals("3") && code.equals("qna")){ //질문글 일때
	if(((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))) || session_id.equals(fid_1)){
		
	}else{
%>
	<script>
		alert("글을 볼 권한이 없습니다.");
		location.href="/";
	</script>
<%
	}
}else{
	
}

//조회수 + 1 처리
String sql_cnt = "update board set ref=ref+1 where uid="+uid;
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
					<td align=left></td><br>
				</tr>				
			</table>
			<br>
			<hr>
			<table width=800>
				<tr>
					<td><button><a class="a4" href="list.jsp?code=<%=code%>&field=<%=field%>&page_now=<%=page_now%>">List</a></button></td>
					<td align=right>
						<%if(subject.indexOf("Re:") != -1){ 		//답변글%>	
							<%if((session_id != null && session_id.equals(id)) || (session_id != null && session_level.equals("99"))){ %>
								<button><a class="a4" href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>">Modify</a></button>
								<button><a class="a4" onclick="delete_go('<%=code%>',<%=uid%>)">Delete</a></button>
							<%}%>
						<%}else{%>
							<%if(code.equals("notice")){ 			//공지글%>
								<%if(session_id != null && session_id.equals(id)){%>
									<button><a class="a4" href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>">Modify</a></button>
									<button><a class="a4" onclick="delete_go('<%=code%>',<%=uid%>)">Delete</a></button>
								<%}%>
							<%}else{%>
								<%if((session_id != null && session_level.equals("99")) && code.equals("qna")){ %>
									<button><a class="a4" href="/board/reply.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">Answer</a></button>
								<%}%>
								<%if((session_id != null && session_id.equals(id)) || (session_id != null && session_level.equals("99"))){ %>
									<button><a class="a4" href="modify.jsp?code=<%=code%>&uid=<%=uid%>&page_now=<%=page_now%>">Modify</a></button>
									<button><a class="a4" onclick="delete_go('<%=code%>',<%=uid%>)">Delete</a></button>
								<%}%>
							<%}%>
						<%}%>
					</td>
				</tr>
			</table>
			<table class="board_t" width=800>
				<tr>
					<td align=left><a class="board_a" href="/board/list.jsp?code=<%=bbs_title%>"><%=bbs_title%> &gt;</a></td><br>
				</tr>
				<tr>
					<td colspan=2 align=left style="font-size: 20px; font-weight: bold; word-break: break-all;"><%=subject%></td>
				</tr>
				<tr>
					<td colspan=2><hr></td>
				<tr>
					<td style="font-size: 17px">Name: <a href="/board/list.jsp?field=name&search=<%=name%>" style="color:black"><%=name%></a></td>
					<td rowspans=2 align=right style="font-size: 17px"><%if(!code.equals("qna")){%> <img src="/board/img/re.png" width=15>Comments: <%=count%> <%}%></td>
				</tr>
				<tr>
					<td align=left style="font-size:13px; color:#414141"> | <%=signdate%> | Hits: <%=ref%> |</td>
					<td></td>
				</tr>
				<tr>
					<td colspan=2 style="padding-top: 10px;">
						<hr>
						<table width=800 border=0>
							<tr>
								<td align=left height=400 valign=top style="padding-left: 10px; padding-top: 10px; background: #F2F2F2">
									<%if(!file1.equals("") && code.equals("gallery")){		//이미지 첨부가 있다면{%>
										<img src="/upload/<%=file1%>" width=400>
										<br>
									<%}%>
									<%=comment%>
								</td>
							</tr>
						</table>
						
					</td>
				<%if(!file1.equals("")){ //첨부파일 존재 %>
				<tr height=26>
					<td colspan=3 style="color: #767676"><img src="/board/img/file.png"> Attached file: <a class="a5" href="/upload/<%=file1 %>" download><%=file1 %></a></td>
				</tr>
				<%} %>
			</table>
			<br>
			<%
			if(!code.equals("qna")){
			%>
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
				<tr><td style="color:#414141; font-size:18px; font-weight:bold;"><img src="/board/img/re.png" width=15>Comment</td></tr>
				<tr><td colspan=3 style="border-top:1px solid #666"></td></tr>
				<%
				String sql_comment = "select * from comment where tb_uid="+uid+" order by uid;";
				
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
					<%
					//작성자 or 관리자 삭제
					if((session_id != null && session_id.equals(tb_id)) || (session_level != null && session_level.equals("99"))){
					%>
						<a class="a4" onclick="delete_re('<%=code%>',<%=uid%>,'<%=field%>','<%=search%>','<%=page_now%>','<%=com_uid%>',)"><button>X</button></a>
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
			<%}%>
		</td>
	</tr>
</table>
<br>
<hr>
<%@ include file="/include/f.jsp" %>
z












