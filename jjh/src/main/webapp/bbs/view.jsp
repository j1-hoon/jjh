<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<style>
	
</style>
<script>
function delete_go(str,num){
	result = confirm("삭제하시겠습니까?");
	if(result == true){
		location.href="delete.jsp?code="+str+"&uid="+num;
	}
}
</script>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");

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

String sql = "select * from "+code+" where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String gongji = "";
String name = "";
String signdate = "";
String ref = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
	name = rs.getString("name");
	signdate = rs.getString("signdate");
	ref = rs.getString("ref");
}

String gongji_title = "";
if(gongji.equals("1")){
	gongji_title = "notice";
}else if(gongji.equals("2")){
	gongji_title = "free";
}else{
	gongji_title = "secret";
}

rs.close();
stmt.close();
con.close();
%>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800>
				<tr>
					<td align=center><b>[<%=bbs_title%>]</b></td><br>
				</tr>				
			</table>
			<br>
			<hr>
			<table width=800>
				<tr>
					<td colspan=2 align=center style="font-size: 25px; font-weight: bold;"><%=subject%></td>
				</tr>
				<tr>
					<td colspan=2><hr></td>
				<tr>
					<td>Category: <%=gongji_title%></td>
					<td align=right><%=name%> | <%=signdate%> | Hits: <%=ref%></td>
				</tr>
				<tr>
					<td colspan=2>
						<table width=800 border=1>
							<tr>
								<td width=100 height=300 align=center>Content</td>
								<td><%=comment%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table width=800 border=0>
				<tr>
					<td><button><a href="list.jsp?code=<%=code%>">list</a></button></td>
					<td align=right>
						<button><a href="modify.jsp?code=<%=code%>&uid=<%=uid%>">modify</a></button>
						<button><a onclick="delete_go('<%=code%>',<%=uid%>)">delete</a></button>
					</td>
				</tr>				
			</table>
		</td>
	</tr>
</table>
<hr>
<%@ include file="/include/footer.jsp" %>













