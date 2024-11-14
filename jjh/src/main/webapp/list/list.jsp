<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_m.jsp" %>
<%@ include file="info.jsp" %>

<%
//검색 관련
String field, search, sql_search;
String code_value = "";

if(request.getParameter("search") != null && !request.getParameter("search").equals("")){	//검색
	field = request.getParameter("field");		//칼럼에 해당
	search = request.getParameter("search");	//검색어	
	sql_search = " and " + field + " like '%" + search + "%'";
}else{
	field = "";
	search = "";
	sql_search = "";
}

//총 게시물 수 + 카테고리 이름 + 검색
String sql_count = "select count(*) from shop where gongji != '1' and subject not like 'Re%'" + code_title + sql_search;

int total_count = 0;

Connection con_count = DriverManager.getConnection(url, user, password);
Statement stmt_count = con_count.createStatement();
ResultSet rs_count = stmt_count.executeQuery(sql_count);

if(rs_count.next()){
	total_count = rs_count.getInt(1);
}

rs_count.close();
stmt_count.close();
con_count.close();

//페이징 관련

int page_now = 1;
if(request.getParameter("page_now") != null){
	page_now = Integer.parseInt(request.getParameter("page_now")); //현재 페이징 수
}

int num_per_page = 6; //한 페이지당 출력 게시물 수
int page_per_block = 10; //한 블럭당 출력 링크 수
int total_page = (int)Math.ceil(total_count / (double)num_per_page); //총 페이지 수
int first = num_per_page * (page_now - 1); //limit 시작 값

%>

<style>
	.td2 { text-align: center; }
	table{border-collapse: collapse;}
	a{text-decoration-line: none;}
	.a4:link{color:black;}
	.a4:visited{color:black;}
	.a3:link { color : #FF4E59;}
	.a3:visited { color:#FF4E59;}
	.page_on {
		padding:0px 5px;
		color:#D00109;
		border:0px;
		font-weight:bold;
	}
	.page_off {
		padding:0px 5px;
		color:black;
		border:0px;
	}
}
</style>


<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0 style="border-bottom: 1px solid black">
				<tr>
					<td align=left style="font-size: 25px"><b>SHOP</b></td><br>
				</tr>
				<tr>
					<td><b><%=total_count %></b> posts</td>
				</tr>			
			</table>
			<table width=800 style="border-top: 1px solid black">
					<tr bgcolor="#E5ECEF" height="25">
						<th colspan="6" width=40>Product</th>
					</tr>
				<%
				if(code.equals("product")){
					String sql = "select * from shop where gongji != '1' " + code_title + sql_search + " order by uid desc LIMIT "+first+", "+num_per_page;;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					int i = 1;
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						String price = rs.getString("price");
						int sub_len = subject.length();
						if(sub_len > 25){
							subject = subject.substring(0, 25) + "<br>" + subject.substring(26);
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id"); //작성자
						String soldout = rs.getString("soldout");
						
						//2일전까지 최신글 처리
						Date signdate2, day2;

						Date today = new Date(); //현재 날짜

						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입

						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						
						String file1 = rs.getString("file1");
						
						String comment = rs.getString("comment");
						int comment_len = comment.length();
						if(comment_len > 70){
							comment = comment.substring(0,70)+"...";
						}
						
						if(i % 4 == 1){
							out.print("<tr height='100'>");
						}
					%>
							<td width=200 align=left>
								<table><tr><td height=170 style="vertical-align: top">																
									<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">
										<img src="/upload/<%=file1%>" width="190">
									</a>
								</td></tr></table>
								<table><tr><td height=50 style="vertical-align: top">
									<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">
										<span style="color:black;" width=190><%=subject %></span>
									</a>
								</td></tr></table>
								<table><tr><td style="vertical-align: top">
									<%if(soldout.equals("x")){%>
										<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>">
											<span style="color:black; font-weight:bold;">₩<%=price %></span>
										</a>
									<%}else{%>
										<span style="color:black; font-weight:bold;">SOLDOUT</span>
									<%}%>
								</td></tr></table>
							</td>
							<%if(total_count == 1){%>
								<td colspan="3" ></td>
							<%}else if(total_count == 2){%>
								<%if(i == 2){%>
									<td colspan="2" ></td>
								<%}%>
							<%}else if(total_count == 3){ %>
								<%if(i == 3){%>
									<td></td>
								<%}%>
							<%} %>
					<%
						if(i % 4 == 0){
							out.print("</tr>");
							out.print("<tr><td colspan=6 style='border-top:1px solid #666;height:30px;'></td></tr>");
						}
					
						num--;
						i++;
					}
				}
				
					if(total_count == 0){
					%>
					<tr>
						<td colspan=6 align=center height=100>NO PRODUCT</td>
					</tr>
					<%
					}
				%>
			</table>
			<br>
			<table width=800 border=0>
				<tr><td style='border-top:1px solid #666;height:30px;'></td></tr>
				<tr>
					<td align=center>
						<%
							// 페이징 처리 시작 /////////////////////////////
							int total_block = 0;
							int block = 0;
							int first_page = 0;
							int last_page = 0;
							int direct_page = 0;
							int my_page = 0;
							
							total_block = (int)Math.ceil(total_page / (double)page_per_block); //총 블럭 수
							block = (int)Math.ceil(page_now / (double)page_per_block); //현재 블럭
							first_page = (block - 1) * page_per_block; //블럭내 시작하는 수
							last_page = block * page_per_block; //블럭내 끝나는 수
							
							if(total_block <= block) { //마지막 블럭일 때
								last_page = total_page; //반복문 변수 처리
							}
							
							
							// 이전 블럭 처리			
							if(block != 1){ //첫 블럭이 아니라면
							%>
								<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=first_page%>"><img src="img/btn_left.gif"></a>&nbsp;&nbsp;
							<%
							}
							
							// 블럭내 페이지 수 출력 
							for(direct_page = first_page + 1; direct_page <= last_page; direct_page++){
								if(page_now == direct_page){
							%>
									<span class="page_on"><%=direct_page%></span>&nbsp;
							<%
								}else{
							%>
									<span class="page_off"><a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
							<%
								}
							}
								
							// 다음 블럭 처리
							if(block < total_block) { //다음 블럭 존재
							%>
								&nbsp;<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=last_page + 1%>"><src="img/btn_right.gif"></a>
							<%
							}
							//페이징 처리 끝 /////////////////////////////			
							%>
					</td>	
				</tr>			
			</table>		
		</td>
	</tr>
</table>
<table height=150>
	<tr>
		<td></td>
	</tr>
</table>
<hr>
<%@ include file="/include/f.jsp" %>