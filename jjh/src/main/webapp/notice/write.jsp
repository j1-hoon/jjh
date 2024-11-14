<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<body>
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
					<td align=center style="font-size: 20px;"><b>[WRITE]</b></td>
				</tr>				
			</table>
			<form action="insert.jsp" method="post" onsubmit="return gogo()">
			<table width=800>
				<tr>
					<td>OPTION</td>
					<td>
						<input type="radio" id="gongji" name="gongji" value="1">NOTICE
						<input type="radio" id="gongji" name="gongji" value="2" checked>FREE
						<input type="radio" id="gongji" name="gongji" value="3">SECRET
					</td>
				</tr>
				<tr>
					<td>TITLE</td>
					<td>
						<input id="subject" name="subject" style="width:98%">
					</td>
				</tr>
				<tr>
					<td>CONTENT</td>
					<td>
						<textarea id="comment" name="comment" style="width:98%;height:100px;"></textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td align=right>
					<a href="list.jsp" style="font-size:13px; border: solid 1px #767676; color: black; border-radius: 5px; background: #EFEFEF;">list</a>
					<button>write</button>
					</td>
				</tr>
			</table>
			</form>
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