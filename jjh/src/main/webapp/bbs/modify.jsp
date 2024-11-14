<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<style>
	
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
String uid = request.getParameter("uid");
String code = request.getParameter("code");
String sql = "select * from " + code + " where uid=" + uid;

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

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String gongji = "";

if(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
}

rs.close();
stmt.close();
con.close();
%>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0>
				<tr>
					<td align=center><b>[<%=bbs_title%>]</b></td>
				</tr>				
			</table>
			<form action="update.jsp" method="post" onsubmit="return gogo()">
			<input type="hidden" name="uid" value="<%=uid%>">
			<input type="hidden" name="code" value="<%=code%>">
						<table width=800 border=1>
				<tr>
					<td align=center width=100>Option</td>
					<td>
						<input type="radio" id="gongji" name="gongji" value="1">notice
						<input type="radio" id="gongji" name="gongji" value="2" checked>free
						<input type="radio" id="gongji" name="gongji" value="3">secret
					</td>
				</tr>
				<tr>
					<td align=center>Title</td>
					<td>
						<input id="subject" name="subject" style="width:98%">
					</td>
				</tr>
				<tr>
					<td align=center height=360>Content</td>
					<td>
						<textarea id="comment" name="comment" style="width:98%;height:355px;"></textarea>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td width=750></td>
					<td align=right><button>modify</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>

<%@ include file="/include/footer.jsp" %>