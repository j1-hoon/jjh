<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/h.jsp" %>

<style>
	table{
	border-collapse: collapse;
</style>
<script>
function gogo(){
	if(subject.value == ""){
		alert("Please write the title");
		subject.focus();
		return false;
	}
	if(comment.value == ""){
		alert("Please write the contents");
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

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
	id = rs.getString("id");
	file1 = rs.getString("file1");
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
		<br>
			<table width=800 border=0>
				<tr>
					<td align=center><b>[Modify]</b></td>
				</tr>				
			</table>
			<br>
			<form action="update.jsp" method="post" onsubmit="return gogo()" enctype="multipart/form-data">
			<input type="hidden" name="code" value="<%=code%>">
			<input type="hidden" name="uid" value="<%=uid%>">
			<input type="hidden" name="field" value="<%=field%>">
			<input type="hidden" name="search" value="<%=search%>">
			<input type="hidden" name="page_now" value="<%=page_now%>">
			<table width=800 border=1>
				<tr>
					<td align=center width=160>Category</td>
					<td width=480 style="border-right: 0px"><%=code%></td>
					<td width=250 align=right style="border-left: 0px;">
						<%if(session_level != null && session_level.equals("99")){%>
						<input type="radio" id="gongji" name="gongji" value="1" <%if(gongji.equals("1")){%>checked<%}%>>notice
						<%}%>
						<input type="radio" id="gongji" name="gongji" value="2" <%if(gongji.equals("2")){%>checked<%}%>>general
						<input type="radio" id="gongji" name="gongji" value="3" <%if(gongji.equals("3")){%>checked<%}%>>secret
					</td>
				</tr>
				<tr>
					<td align=center>Title</td>
					<td colspan="2">
						<input id="subject" name="subject" style="width:98%" value="<%=subject%>">
					</td>
				</tr>
				<tr>
					<td align=center height=360>content</td>
					<td colspan="2" width=640>
						<textarea id="comment" name="comment" style="width:98%;height:355px;"><%=comment%></textarea>
					</td>
				</tr>
				<tr>
					<td align=center>Attachment</td>
					<td style="color:red" colspan="2">
						<input type="file" name="file1">
						<%if(!file1.equals("")){ %>
							Attached file : <%=file1 %>
						<%} %>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td width=750></td>
					<td align=right colspan="2"><button>Modify</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>
<hr>
<%@ include file="/include/f.jsp" %>