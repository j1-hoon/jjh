<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>
<%@ include file="info.jsp" %>

<style>
table{
	border-collapse: collapse;
}
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
<table width=100%>
	<tr>
		<td align=center>
			<table width=800>
				<tr>
					<td align=center><b>[POST]</b></td><br>
				</tr>				
			</table>
			<br>
			<form action="insert.jsp" method="post" onsubmit="return gogo()" enctype="multipart/form-data">
			<table width=800 border=1>
				<tr>
					<td align=center>Category</td>
					<td style="border-right: 0px">
						<select name = "code">
							<%if(session_level != null && session_level.equals("99")){ %>
								<option value="notice">notice</option>
							<%}%>
								<option value="free" <%if(code.equals("free")){%>selected<%}%>>free</option>
								<option value="gallery" <%if(code.equals("gallery")){%>selected<%}%>>gallery</option>
								<option value="qna" <%if(code.equals("qna")){%>selected<%}%>>Q&A</option>
						</select>
					</td>
					<td width=160 align=right style="border-left: 0px">
							<%if(session_level != null && session_level.equals("99")){ %>
								<input type="radio" id="gongji" name="gongji" value="1" <%if(code.equals("notice")){%>checked<%}%>>notice
							<%}else{%>
								<input type="radio" id="gongji" name="gongji" value="3">secret
							<%}%>
								<input type="radio" id=gongji name="gongji" value="2" <%if(!code.equals("notice") || !session_level.equals("99")){%>checked<%}%>>general
					</td>
				</tr>
				<tr>
					<td align=center>Title</td>
					<td colspan="2">
						<input id="subject" name="subject" style="width:98%">
					</td>
				</tr>
				<tr>
					<td align=center height=360>Content</td>
					<td colspan="2">
						<textarea id="comment" name="comment" style="width:98%;height:355px;"></textarea>
					</td>
				</tr>
				<tr>
					<td align=center>attachment</td>
					<td>
						<input type="file" name="file1">
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
<%@ include file="/include/f.jsp" %>