<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header2.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String uid = request.getParameter("uid");

String sql = "select * from shop where uid="+ uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String comment = "";
String price = "";


while(rs.next()){
	subject = rs.getString("subject");
	comment = rs.getString("comment");
	price = rs.getString("price");
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
															<td align=left><b>Product modifying</b></td>
														</tr>
													</table>
													<form action="/admin/shop/update.jsp" method="post" onsubmit="return join()">
													<input type="hidden" name="uid" value="<%=uid%>">
													<table class="t1">
														<tr>
															<td align=center>Product Title</td>
															<td colspan="2">
																<input id="subject" name="subject" value="<%=subject%>" style="width:98%">
															</td>
														</tr>
														<tr>
															<td align=center>Price</td>
															<td colspan="2">
																<input id="price" name="price" value="<%=price%>" style="width:98%;">
															</td>
														</tr>
														<tr>
															<td align=center height=267>Product Descriptions</td>
															<td colspan="2">
																<textarea id="comment" name="comment" style="width:98%;height:263px;"><%=comment%></textarea>
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