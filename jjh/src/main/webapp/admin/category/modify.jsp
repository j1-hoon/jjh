<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header2.jsp" %>
<script>
function gogo(){
	if(title.value == ""){
		alert("Please write the player name");
		title.focus();
		return false;
	}
	if(num.value == ""){
		alert("Please write the back number");
		num.focus();
		return false;
	}
}
</script>
<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String uid = request.getParameter("uid");

String sql = "select * from category where uid=" + uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String num = "";
String tab = "";
String title = "";

while(rs.next()){
	num = rs.getString("num");
	tab = rs.getString("tab");
	title = rs.getString("title");

}

rs.close();
stmt.close();
con.close();

%>
						    <table class="t1" width=1590 height=650>
						        <tr>
						        	<td style="vertical-align: top">
													<table>
														<tr>
															<td align=left><b>Player modifying</b></td>
														</tr>
													</table>
													<form action="/admin/category/update.jsp" method="post" onsubmit="return gogo()">
													<input type="hidden" name="uid" value="<%=uid%>">
													<table class="t1">
														<tr>
															<td>Player Name</td>
															<td><input id="title" name="title" value="<%=title%>"></td>
														</tr>
														<tr>
															<td>Position</td>
															<td>
																<select name="tab">
																	<option value="fw"<%if(tab.equals("fw")){%>selected<%}%>>FW</option>
																	<option value="mf"<%if(tab.equals("mf")){%>selected<%}%>>MF</option>
																	<option value="df"<%if(tab.equals("df")){%>selected<%}%>>DF</option>
																	<option value="gk"<%if(tab.equals("gk")){%>selected<%}%>>GK</option>
																</select>
															</td>
														</tr>
														<tr>
															<td>Back Number</td>
															<td><input id="num" name="num" value="<%=num%>"></td>
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