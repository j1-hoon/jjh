<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@ include file="/admin/include/header2.jsp" %>
							<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리

String uid = request.getParameter("uid");

String sql = "select * from board where uid="+uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String gongji = "";
String code = "";

if(rs.next()){
	code = rs.getString("code");
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	gongji = rs.getString("gongji");
}

rs.close();
stmt.close();
con.close();
%>
						    <table class="t1" width=1590 height=650>
						        <tr>
						        	<td style="vertical-align: top">
						        		<table width=800 border=0>
											<tr>
												<td align=left><b>Admin modifying</b></td>
											</tr>				
										</table>
										<form action="/admin/board/update.jsp" method="post" onsubmit="return gogo()">
										<input type="hidden" name="uid" value="<%=uid%>">
										<table class="t1" width=800 border=1>
											<tr>
												<td align=center width=160>Category</td>
												<td width=480 style="border-right: 0px">
													<select name="code">
														<option value="notice" <%if(code.equals("notice")){%>selected<%}%>>notice</option>
														<option value="free" <%if(code.equals("free")){%>selected<%}%>>free</option>
														<option value="gallery" <%if(code.equals("gallery")){%>selected<%}%>>gallery</option>
														<option value="qna" <%if(code.equals("qna")){%>selected<%}%>>qna</option>
													</select>
												</td>
												<td width=250 align=right style="border-left: 0px;">
													<input type="radio" id="gongji" name="gongji" value="1" <%if(gongji.equals("1")){%>checked<%}%>>notice
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
										</table>
										<table class="t1">
											<tr>
												<td width=730></td>
												<td align=right colspan="2"><button>Modify</button></td>
											</tr>
										</table>
										</form>
						        	</td>
						        </tr>
						    </table>
						</td>
						<td width=80>
						    
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>