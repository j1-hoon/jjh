<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<%
String code = request.getParameter("code");	//db > table name
//총 게시물 수
String sql_count = "select count(*) from " + code;

//게시판 이름
String bbs_title = "";
if(code.equals("notice")){
	bbs_title = "NOTICE";
}else if(code.equals("free")){
	bbs_title = "FREE";
}else if(code.equals("gallery")){
	bbs_title = "GALLERY";
}else if(code.equals("qna")){
	bbs_title = "Q&A";
}else{
	bbs_title = "존재하지 않는 게시판입니다.";
}

int total_count = 0;

Connection con_count = DriverManager.getConnection(url, user, password);
Statement stmt_count = con_count.createStatement();
ResultSet rs_count = stmt_count.executeQuery(sql_count);

if(rs_count.next()){
	total_count = rs_count.getInt(1);
}

rs_count.close();
stmt_count.close();
con_count.close();
%>

<style>
	.td2 { text-align: center; }
</style>
<script>
function writeGo(){
	alert('로그인후 작성하세요.');
	result = confirm("로그인 페이지로 이동하시겠습니까?");
	if(result == true){
		location.href="/member/login.jsp";
	}
}
</script>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0>
				<tr>
					<td align=center><b>[<%=bbs_title%>]</b></td><br>
				</tr>				
			</table>
			<br>
			<hr>
			<table width=800 border=0>
				<tr>
					<td>Total : <%=total_count %></td>
					<td align=right>
						<form>
							<select name="">
								<option value="subject">Title</option>
								<option value="comment">Content</option>
								<option value="name">Writer</option>
							</select>
							<input name="">
							<button>Search</button>
						</form>
					</td>
				</tr>				
			</table>
			<table width=800 border=1>
				<tr>
					<th width=40>No</th>
					<th width=480>Title</th>
					<th width=100>Writer</th>
					<th width=200>Date</th>
					<th width=60>Hits</th>
				</tr>
				<%
				String sql = "select * from " + code + " order by uid desc";
				
				Connection con = DriverManager.getConnection(url, user, password);
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				
				while(rs.next()){
					int uid = rs.getInt("uid");
					String subject = rs.getString("subject");
				%>
				<tr>
					<td class="td2"><%=rs.getString("uid") %></td>
					<td>
						<a href="view.jsp?code=<%=code%>&uid=<%=uid%>"><%=subject%></a>
					</td>
					<td class="td2"><%=rs.getString("name") %></td>
					<td class="td2"><%=rs.getString("signdate") %></td>
					<td class="td2"><%=rs.getString("ref") %></td>
				</tr>
				<%
				}
				if(total_count == 0){
				%>
				<tr>
					<td colspan=5 align=center height=100>NO POST</td>
				</tr>
				<%
				}
				%>
			</table>
			<table width=800 border=0>
				<tr>
					<td align=center>&lt; 1 . 2 . 3 &gt;</td>
					<td width=100 align=right>
						<%if(session_id != null){ //로그인 후 %>
						<button><a href="write.jsp?code=<%=code%>">Write</a></button>
						<%}else{ //로그인 전%>
						<button><a onclick="writeGo()">Write</a></button>
						<%} %>
					</td>
				</tr>				
			</table>
		</td>
	</tr>
</table>
<table height=150>
	<tr>
		<td></td>
	</tr>
</table>
<hr>
<%@ include file="/include/footer.jsp" %>