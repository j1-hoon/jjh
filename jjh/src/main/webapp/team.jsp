<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header_m.jsp" %>

<%
int total_count = 0;
//페이징 관련

int page_now = 1;
if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now")); //현재 페이징 수
}

int num_per_page = 3; //한 페이지당 출력 게시물 수
int page_per_block = 10; //한 블럭당 출력 링크 수
int total_page = (int)Math.ceil(total_count / (double)num_per_page); //총 페이지 수
int first = num_per_page * (page_now - 1); //limit 시작 값

%>
<style>
.t1{
        border: 1px solid #a39485;
        font-size: 0.9em;
        box-shadow: 0 2px 5px rgba(0,0,0,0.25);
        width: 100%;
        border-collapse: collapse;
        border-radius: 5px;
        overflow: hidden;
        }
a{
	text-decoration: none;
}
</style>
<body>
	<table width=100%>
	 <tr>
	 	<td align=center>
			<table>
				<tr>
					<th>SQUAD</th>
				</tr>
			</table>
			<br>
			<table width=1080>
				<tr>
					<td align=left style="font-size:40px; font-weight: bold; font-family: cursive;">GOALKEEPER</td>
				</tr>
				<tr>
					<td>
						<table>
							<%
							request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
							String sql_gk = "select * from category where tab='gk'";
							
							Connection con_gk = DriverManager.getConnection(url, user, password);
							Statement stmt_gk = con_gk.createStatement();
							ResultSet rs_gk = stmt_gk.executeQuery(sql_gk);
							
							String title_gk = "";
							String num_gk = "";
							
							while(rs_gk.next()){
								title_gk = rs_gk.getString("title");
								num_gk = rs_gk.getString("num");
								String img_gk = rs_gk.getString("img");
								
							%>
							<td>
								<a href="/player/<%=title_gk%>.jsp" style="color:black;">
								<img src="/upload_player/<%=img_gk%>" width=400 height=240>
								<table width=350  class="t1">
									<tr>
										<td style="font-size:25px;"><%=title_gk%></td>
										<td align=right style="font-size:30px; color:red"><%=num_gk %></td>
									</tr>
								</table>
								</a>
							</td>
							<%
							}
							rs_gk.close();
							stmt_gk.close();
							con_gk.close();
							%>
						</table>
					</td>
				</tr>
				<tr>
					<td align=left style="font-size:40px; font-weight: bold; font-family: cursive;">DEFENDER</td>
				</tr>
				<tr>
					<td>
						<table>
							<%
							request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
							String sql_df = "select * from category where tab='df'";
							
							Connection con_df = DriverManager.getConnection(url, user, password);
							Statement stmt_df = con_df.createStatement();
							ResultSet rs_df = stmt_df.executeQuery(sql_df);
							
							String title_df = "";
							String num_df = "";
							
							int i_df = 1;
							
							int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
							while(rs_df.next()){
								title_df = rs_df.getString("title");
								num_df = rs_df.getString("num");
								String img_df = rs_df.getString("img");
								
								if(i_df % 4 == 1){
									out.print("<tr height='100'>");
								}
							%>
							<td class="t1">
								<a href="/player/<%=title_df%>.jsp" style="color:black">
								<img src="/upload_player/<%=img_df%>" width=400 height=240>
								<table class="t1">
									<tr>
										<td style="font-size:25px;"><%=title_df%></td>
										<td align=right style="font-size:30px; color:red"><%=num_df %></td>
									</tr>
								</table>
								</a>
							</td>
							<%
							if(i_df % 4 == 0){
								out.print("</tr>");
								out.print("<tr><td colspan=6 style='border-top:1px solid #666;height:30px;'></td></tr>");
							}
							
							i_df++;
							}
							rs_df.close();
							stmt_df.close();
							con_df.close();
							%>
						</table>
					</td>
				</tr>
				<tr>
					<td align=left style="font-size:40px; font-weight: bold; font-family: cursive;">MIDFIELDER</td>
				</tr>
				<tr>
					<td>
						<table>
							<%
							request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
							String sql_mf = "select * from category where tab='mf'";
							
							Connection con_mf = DriverManager.getConnection(url, user, password);
							Statement stmt_mf = con_mf.createStatement();
							ResultSet rs_mf = stmt_mf.executeQuery(sql_mf);
							
							String title_mf = "";
							String num_mf = "";
							
							int i_mf = 1;
							
							while(rs_mf.next()){
								title_mf = rs_mf.getString("title");
								num_mf = rs_mf.getString("num");
								String img_mf = rs_mf.getString("img");
								
								if(i_mf % 4 == 1){
									out.print("<tr height='100'>");
								}
							%>
							<td class="t1">
								<a href="/player/<%=title_mf%>.jsp" style="color:black">
								<img src="/upload_player/<%=img_mf%>" width=400 height=240>
								<table class="t1">
									<tr>
										<td style="font-size:25px;"><%=title_mf%></td>
										<td align=right style="font-size:30px; color:red"><%=num_mf%></td>
									</tr>
								</table>
								</a>
							</td>
							
							<% 
							if(i_mf % 4 == 0){
								out.print("</tr>");
								out.print("<tr><td colspan=6 style='border-top:1px solid #666;height:30px;'></td></tr>");
							}
							
							i_mf++;
							
							}
							rs_mf.close();
							stmt_mf.close();
							con_mf.close();
							%>
						</table>
					</td>
				</tr>
				<tr>
					<td align=left style="font-size:40px; font-weight: bold; font-family: cursive;">FORWARD</td>
				</tr>
				<tr>
					<td>
						<table>
							<%
							request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
							String sql_fw = "select * from category where tab='fw'";
							
							Connection con_fw = DriverManager.getConnection(url, user, password);
							Statement stmt_fw = con_fw.createStatement();
							ResultSet rs_fw = stmt_fw.executeQuery(sql_fw);
							
							String title_fw = "";
							String num_fw = "";
							
							int i_fw = 1;
							
							while(rs_fw.next()){
								title_fw = rs_fw.getString("title");
								num_fw = rs_fw.getString("num");
								String img_fw = rs_fw.getString("img");
								
								if(i_fw % 4 == 1){
									out.print("<tr height='100'>");
								}
							%>
							<td class="t1">
							<a href="/player/<%=title_fw%>.jsp" style="color:black">
								<img src="/upload_player/<%=img_fw%>" width=400 height=240>
								<table class="t1">
									<tr>
										<td style="font-size:25px;"><%=title_fw%></td>
										<td align=right style="font-size:30px; color:red"><%=num_fw %></td>
									</tr>
								</table>
							</a>
							</td>
							
							<% 
							if(i_fw % 4 == 0){
								out.print("</tr>");
								out.print("<tr><td colspan=6 style='border-top:1px solid #666;height:30px;'></td></tr>");
							}
							
							i_fw++;
							
							}
							rs_fw.close();
							stmt_fw.close();
							con_fw.close();
							%>
						</table>
					</td>
				</tr>
			
			</table>
		</td>
	 </tr>
	</table>
</body>
<%@ include file="/include/f.jsp" %>