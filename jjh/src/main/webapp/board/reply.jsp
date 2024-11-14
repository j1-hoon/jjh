<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/h.jsp" %>

<style>
table{
	border-collapse: collapse;
}
</style>
<script>
function gogo(){
	if(subject.value == ""){
		alert("제목을 입력하세요.");
		subject.focus();
		return false;
	}
	if(comment.value == ""){
		alert("내용을 입력하세요.");
		comment.focus();
		return false;
	}
}
</script>

<%
String code = request.getParameter("code");
String uid = request.getParameter("uid");
String field = request.getParameter("field");
String search = request.getParameter("search");
String page_now = request.getParameter("page_now");

String sql = "select * from board where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String gongji = "";
String id = "";
String file1 = "";
int fid = 0;
String thread = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
	id = rs.getString("id");
	file1 = rs.getString("file1");
	fid = rs.getInt("fid");
	thread = rs.getString("thread");
}

rs.close();
stmt.close();
con.close();

//관리자, 작성자만 수정
if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){
		
}else{
%>
	<script>
		alert("글을 수정할 권한이 없습니다.");
		location.href="/";
	</script>
<%
}
%>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0>
				<tr>
					<td align=center><b>Answer</b></td>
				</tr>				
			</table>
			<form action="reply_insert.jsp" method="post" onsubmit="return gogo()" enctype="multipart/form-data">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="uid" value="<%=uid%>">
			<input type="hidden" name="field" value="<%=field%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="page_now" value="<%=page_now%>">
			<input type="hidden" name="fid" value="<%=fid%>">
			<input type="hidden" name="thread" value="<%=thread%>">
			<table width=800 border=1>
				<tr>
					<td>Option</td>
					<td>
						<input type="radio" id="gongji" name="gongji" value="2" <%if(gongji.equals("2")){%>checked<%}%>>general
						<input type="radio" id="gongji" name="gongji" value="3" <%if(gongji.equals("3")){%>checked<%}%>>secret
					</td>
				</tr>
				<tr>
					<td>Title</td>
					<td>
						<input id="subject" name="subject" style="width:98%" value="Re: <%=subject%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td>Contents</td>
					<td>
						<textarea id="comment" name="comment" style="width:98%;height:100px;">Re: <%=comment%></textarea>
					</td>
				</tr>
				<tr>
					<td>attachment</td>
					<td style="color:red">
						<input type="file" name="file1">
						<%if(!file1.equals("")){ %>
							Attached file : <%=file1 %>
						<%} %>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><button>Reply</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>

<%@ include file="/include/f.jsp" %>