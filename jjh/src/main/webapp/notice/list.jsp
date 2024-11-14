<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>
<body>
<%
//총 게시물 수
String sql_count = "select count(*) from notice";

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
					<td align=center style="font-size:20px"><b>[COMMUNITY]</b></td>
				</tr>				
			</table>
			<table width=800 border=0>
				<tr>
					<td>Total : <%=total_count %></td>
					<td align=right>
						<form>
							<select name="">
								<option value="subject">title</option>
								<option value="comment">content</option>
								<option value="name">writer</option>
							</select>
							<input name="">
							<button>search</button>
						</form>
					</td>
				</tr>				
			</table>
			<table width=800 border=1>
				<tr>
					<th width=40>No</th>
					<th width=540>title</th>
					<th width=60>writer</th>
					<th width=100>date</th>
					<th width=60>hits</th>
				</tr>
				<%
				String sql = "select * from notice order by uid desc";
				
				Connection con = DriverManager.getConnection(url, user, password);
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				
				while(rs.next()){
				%>
				<tr>
					<td class="td2"><%=rs.getString("uid") %></td>
					<td><%=rs.getString("subject") %></td>
					<td class="td2"><%=rs.getString("name") %></td>
					<td class="td2"><%=rs.getString("signdate") %></td>
					<td class="td2"><%=rs.getString("ref") %></td>
				</tr>
				<%
				}
				if(total_count == 0){
				%>
				<tr>
					<td colspan=5 align=center height=100>작성된 게시물이 없습니다.</td>
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
						<a href="write.jsp">[write]</a>
						<%}else{ //로그인 전%>
						<a onclick="writeGo()">[write]</a>
						<%} %>
					</td>
				</tr>				
			</table>
		</td>
	</tr>
</table>
<table>
	<tr>
		<td style="padding-bottom:300px"></td>
	</tr>
</table>
</body>
<%@ include file="/include/footer.jsp" %>