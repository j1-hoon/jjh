<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>

<%
String code = request.getParameter("code");

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
%>
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
<table width=100%>
	<tr>
		<td align=center>
			<table width=800>
				<tr>
					<td align=center><b>[<%=bbs_title%>]</b></td><br>
				</tr>				
			</table>
			<br>
			<form action="insert.jsp" method="post" onsubmit="return gogo()">
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
					<td align=right><button>write</button></td>
				</tr>
			</table>
			</form>
		</td>
	</tr>
</table>
<hr>
<%@ include file="/include/footer.jsp" %>