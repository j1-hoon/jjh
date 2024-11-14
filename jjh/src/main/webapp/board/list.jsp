<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_c.jsp" %>
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
String sql_count = "";
if(code.equals("")){
	sql_count = "select count(*) from board where gongji = '2' and subject not like 'Re%'" + code_title + sql_search;
}else if(code.equals("notice")){
	sql_count = "select count(*) from board where gongji = '1'" + code_title + sql_search;
}else{
	sql_count = "select count(*) from board where gongji != '1' and subject not like 'Re%'" + code_title + sql_search;
}
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

int num_per_page = 10; //한 페이지당 출력 게시물 수
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
	#first:checked + div{
		 display:none;
	}
	.write_a{color:black;}
	.wirte_a:hover{color:black;}
}
</style>
<script>
function writeGo(){
	alert('Please login and fill it out');
	result = confirm("Do you want to go to the login page?");
	if(result == true){
		location.href="/member/login.jsp";
	}
}
</script>

<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0 style="border-bottom: 1px solid black">
				<tr>
					<br>
					<td align=left style="font-size: 25px"><b><%=bbs_title%></b></td><br>
				</tr>
				<tr>
					<td><b><%=total_count %></b> posts</td>
				</tr>			
			</table>
			<table width=800 style="border-top: 1px solid black">
				<%if(code.equals("gallery")){%>
					<tr bgcolor="#E5ECEF" height="25">
						<th width=60>No</th>
						<th width=60>img</th>
						<th width=430>Title</th>
						<th width=90>Writer</th>
						<th width=200>Date</th>
						<th width=40>Hits</th>
					</tr>
				<%}else if(code.equals("")){%>
					<tr bgcolor="#E5ECEF" height="25">
						<th width=60>No</th>
						<th width=60>Category</th>
						<th width=430>Title</th>
						<th width=90>Writer</th>
						<th width=200>Date</th>
						<th width=40>Hits</th>
					</tr>
				<%}else{%>
					<tr bgcolor="#E5ECEF" height="25">
						<th width=60>No</th>
						<th width=430>Title</th>
						<th width=90>Writer</th>
						<th width=200>Date</th>
						<th width=40>Hits</th>
					</tr>
				<%}%>
			
				<%	//공지글
				String sql_notice = "select * from board where gongji = '1' "+ sql_search + " order by uid desc";
				
				Connection con_notice = DriverManager.getConnection(url, user, password);
				Statement stmt_notice = con_notice.createStatement();
				ResultSet rs_notice = stmt_notice.executeQuery(sql_notice);
				
				while(rs_notice.next()){
					int uid = rs_notice.getInt("uid");
					String subject = rs_notice.getString("subject");
					int sub_len = subject.length();
					if(sub_len > 36){
						subject = subject.substring(0, 36) + "...";
					}
					
					String gongji = rs_notice.getString("gongji");					
					String signdate = rs_notice.getString("signdate");
					
					Date today = new Date(); //현재 날짜
					
					String r = rs_notice.getString("signdate").substring(0,10);
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					String signdate3 = sdf.format(today);
		
				%>
				<%if(code.equals("") || code.equals("gallery")){%>
					<tr  bgcolor="#FFF6FA" height="25" style="border-bottom: 1px solid #F2F2F2">
						<td class="td2">
							<table align=center>
								<tr>
									<td align=center width=40 height=20 style="border-radius: 8px; background: #FFE3E4; color: #FF4E59; font-size: 12px;">Notice</td>
								</tr>
							</table>
						</td>
						<td class="td2" style="color:#777"><%=rs_notice.getString("code") %></td>
						<td>
							<a class="a3" href="view.jsp?code=notice&uid=<%=uid%>&field=<%=field%>%search=<%=search%>"><%=subject%></a>
						</td>
						<td class="td2"><%=rs_notice.getString("name") %><img src="/board/img/ad.ico" width=11px></td>
						<td class="td2"><%=rs_notice.getString("signdate").substring(0,10) %></td>
						<td class="td2"><%=rs_notice.getString("ref") %></td>
					</tr>
				<%}else{%>
					<tr  bgcolor="#FFF6FA" height="25" style="border-bottom: 1px solid #F2F2F2">
						<td class="td2">
							<table align=center>
								<tr>
									<td align=center width=40 height=20 style="border-radius: 8px; background: #FFE3E4; color: #FF4E59; font-size: 12px;">Notice</td>
								</tr>
							</table>
						</td>
						<td>
							<a class="a3" href="view.jsp?code=notice&uid=<%=uid%>&field=<%=field%>%search=<%=search%>"><%=subject%></a>
						</td>
						<td class="td2"><%=rs_notice.getString("name") %><img src="/board/img/ad.ico" width=11px></td>
						<td class="td2"><%=rs_notice.getString("signdate").substring(0,10) %></td>
						<td class="td2"><%=rs_notice.getString("ref") %></td>
					</tr>
				<%}%>
				<%
				}
				rs_notice.close();
				stmt_notice.close();
				con_notice.close();
				%>
			
				<%//갤러리 게시판
				if(code.equals("gallery")){
					String sql = "select *,(select count(*) from comment where tb_uid=board.uid) as count from board where gongji != '1' " + code_title + sql_search + " order by uid desc LIMIT "+first+", "+num_per_page;;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					int i = 1;
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						int sub_len = subject.length();
						if(sub_len > 36){
							subject = subject.substring(0, 36) + "...";
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id"); //작성자
						
						//2일전까지 최신글 처리
						Date signdate2, day2;

						Date today = new Date(); //현재 날짜

						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입

						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						
						String r = rs.getString("signdate").substring(0,10);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String signdate3 = sdf.format(today);
						
						String file1 = rs.getString("file1");
						int count = rs.getInt("count");
						
						String comment = rs.getString("comment");
						int comment_len = comment.length();
						if(comment_len > 70){
							comment = comment.substring(0,70)+"...";
						}
						
					%>
					<tr height="100">
						<td class="td2"><%=num%></td>
						<td align=center>
							<%if(!file1.equals("") && !gongji.equals("3")){	//이미지 첨부가 있고 일반글%>
								<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><img src="/upload/<%=file1%>" width=98 height=100></a>
							<%}else if(!file1.equals("") && gongji.equals("3")){	//이미지 첨부가 있고 비밀글%>
								<%if((session_id != null && session_id.equals(id)) || (session_id != null && session_level.equals("99"))){%>
									<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><img src="/upload/<%=file1%>" width=98 height=100></a>
								<%}else{%>
									Secret
								<%}%>
							<%}else{%>
									No Image
							<%}%>
						</td>
						<td>
							<%
							if(gongji.equals("3")){ //비밀글일 때
								if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){ //관리자,작성자라면
							%>
									<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><%=subject %></a>
							<%
								}else{
							%>
									<a onclick="alert('It\'s a secret post')" style="color: #757500; cursor:pointer;">Secret Post</a>
							<%
								}
							}else{ //일반글일 때
							%>
								<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"><%=subject %></a>
							<%
							}
							%>
							<%if(gongji.equals("3")){%><img src="img/icon_secret.gif"><%}%>
							<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
							<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
							<%if(count > 0){%><font color=red>(<%=count%>)</font><%}%>
						</td>
						<td class="td2"><%=rs.getString("name") %></td>
						<td class="td2">
							<%if(signdate3.equals(r)){%>
								<%=rs.getString("signdate").substring(10) %>
							<%}else{%>
								<%=rs.getString("signdate").substring(0,10) %>
							<%}%>
						</td>
						<td class="td2"><%=rs.getString("ref") %></td>
						
					</tr>
					<%
						num--;
					}
				}else if(code.equals("qna")){	//qna 게시판
					String sql = "select *,(select count(*) from comment where tb_uid=board.uid) as count from board where gongji != '1' " + code_title + sql_search + " order by fid desc, thread asc LIMIT "+first+", "+num_per_page;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						int sub_len = subject.length();
						if(sub_len > 36){
							subject = subject.substring(0, 36) + "...";
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id"); //작성자
						String thread = rs.getString("thread");
						String fid = rs.getString("fid");
						
						 String fid_1 = "";
					        if (fid != null && !fid.equals("")) {
					            String sql_fid = "SELECT id FROM board WHERE fid = " + fid;
					            Statement stmt_fid = con.createStatement();
					            ResultSet rs_fid = stmt_fid.executeQuery(sql_fid);
					            if (rs_fid.next()) {
					                fid_1 = rs_fid.getString("id");
					            }
					            rs_fid.close();
					            stmt_fid.close();
					        }
						
						
						//2일전까지 최신글 처리
						Date signdate2, day2;

						Date today = new Date(); //현재 날짜

						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입

						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						int len_thread = thread.length() - 1; //답변 길이 - 1
						
						String r = rs.getString("signdate").substring(0,10);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String signdate3 = sdf.format(today);
						
						String file1 = rs.getString("file1");
						int count = rs.getInt("count");
						
						%>
						<tr height="25" style="border-bottom: 1px solid #F2F2F2">
							<td class="td2">
								<%if(subject.indexOf("Re:") != -1){%>
									Re
								<%}else{%>
									Q
								<%}%>
							</td>
							<td>
								<%
								if(len_thread > 0){
									for (int i=1; i<len_thread; i++){ //첫 답변은 제외
										out.print("&nbsp;&nbsp;&nbsp;");
									}
										out.print("<img src='img/thread_new.gif'>");
									}
								%>
								<%
								if(gongji.equals("3")){ //비밀글일 때
									if(((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))) || (session_id != null && session_id.equals(fid_1))){ //관리자,작성자라면
								%>
										<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>&fid=<%=fid%>"><%=subject %></a>
								<%
									}else{
								%>
										<%if(subject.indexOf("Re:") != -1){%>
											<a onclick="alert('It\'s a secret answer')" style="color: #757500; cursor:pointer;">Secret Answer</a>
										<%}else{%>
											<a onclick="alert('It\'s a secret question')" style="color: #757500; cursor:pointer;">Secret Question</a>
										<%}%>
								<%
									}
								}else{ //일반글일 때
								%>
									<a class="a4" href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>&fid=<%=fid%>"><%=subject %></a>
								<%
								}
								%>
								<%if(gongji.equals("3")){%><img src="img/icon_secret.gif"><%}%>
								<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
								<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
								<%if(count > 0){%><font color=red>(<%=count%>)</font><%}%>
							</td>
							<td class="td2"><%=rs.getString("name") %></td>
							<td class="td2">
								<%if(signdate3.equals(r)){%>
									<%=rs.getString("signdate").substring(10) %>
								<%}else{%>
									<%=rs.getString("signdate").substring(0,10) %>
								<%}%>
							</td>
							<td class="td2"><%=rs.getString("ref") %></td>
						</tr>
						<%
						num--;
					}
				}else if(code.equals("")){		//전체게시판
					String sql = "select *,(select count(*) from comment where tb_uid=board.uid) as count from board where gongji = '2' and subject not like 'Re%'" + code_title + sql_search + " order by uid desc LIMIT "+first+", "+num_per_page;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						int sub_len = subject.length();
						if(sub_len > 36){
							subject = subject.substring(0, 36) + "...";
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id");
						
						//2일전까지 최신글 처리
						Date signdate2, day2;
	
						Date today = new Date(); //현재 날짜
	
						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입
	
						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						
						String r = rs.getString("signdate").substring(0,10);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String signdate3 = sdf.format(today);
						
						String file1 = rs.getString("file1");
						int count = rs.getInt("count");
						
					%>
					<tr height="25" style="border-bottom: 1px solid #F2F2F2">
						<td class="td2"><%=num%></td>
						<td class="td2"><%=rs.getString("code") %></td>
						<td>
							<%
							if(gongji.equals("3")){ //비밀글일 때
								if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){ //관리자,작성자라면
							%>
									<a href="view.jsp?code=<%=rs.getString("code") %>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"style="color: #9C9C10"><%=subject %></a>
							<%
								}else{
							%>
									<a onclick="alert('It\'s a secret post')" style="cursor:pointer;">Secret Post</a>
							<%
								}
							}else{ //일반글일 때
							%>
								<a href="view.jsp?code=<%=rs.getString("code") %>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>" style="color: black"><%=subject %></a>
							<%
							}
							%>
							<%if(gongji.equals("3")){%><img src="img/icon_secret.gif"><%}%>
							<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
							<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
							<%if(count > 0){%><font color=red>(<%=count%>)</font><%}%>
							
						</td>
						<td class="td2">
								<%=rs.getString("name") %>
						</td>
						<td class="td2">
							<%if(signdate3.equals(r)){%>
								<%=rs.getString("signdate").substring(10) %>
							<%}else{%>
								<%=rs.getString("signdate").substring(0,10) %>
							<%}%>
						</td>
						<td class="td2"><%=rs.getString("ref") %></td>
					</tr>
						
					
					<%
						num--;
					}
					if(total_count == 0){
					%>
					<tr>
						<td colspan=6 align=center height=100>NO POST</td>
					</tr>
					<%
					}
				}else if(code.equals("notice")){
					//공지 게시판
					String sql = "select * from board where gongji = '1'" + code_title + sql_search + " order by uid desc LIMIT "+first+", "+num_per_page;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						int sub_len = subject.length();
						if(sub_len > 36){
							subject = subject.substring(0, 36) + "...";
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id");
						
						//2일전까지 최신글 처리
						Date signdate2, day2;
	
						Date today = new Date(); //현재 날짜
	
						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입
	
						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						
						String r = rs.getString("signdate").substring(0,10);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String signdate3 = sdf.format(today);
						
						String file1 = rs.getString("file1");
						
					%>
					<tr height="25" style="border-bottom: 1px solid #F2F2F2">
						<td class="td2"><%=num%></td>
						<td>
							<%
							if(gongji.equals("3")){ //비밀글일 때
								if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){ //관리자,작성자라면
							%>
									<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>"style="color: #9C9C10"><%=subject %></a>
							<%
								}else{
							%>
									<a onclick="alert('It\'s a secret post')" style="cursor:pointer;">Secret Post</a>
							<%
								}
							}else{ //일반글일 때
							%>
								<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>" style="color: black"><%=subject %></a>
							<%
							}
							%>
							<%if(gongji.equals("3")){%><img src="img/icon_secret.gif"><%}%>
							<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
							<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
							
						</td>
						<td class="td2">
								<%=rs.getString("name") %>
						</td>
						<td class="td2">
							<%if(signdate3.equals(r)){%>
								<%=rs.getString("signdate").substring(10) %>
							<%}else{%>
								<%=rs.getString("signdate").substring(0,10) %>
							<%}%>
						</td>
						<td class="td2"><%=rs.getString("ref") %></td>
					</tr>
						
					
					<%
						num--;
					}
					if(total_count == 0){
					%>
					<tr>
						<td colspan=6 align=center height=100>NO POST</td>
					</tr>
					<%
					}
				}else{	//자유게시판
					//
					String sql = "select *,(select count(*) from comment where tb_uid=board.uid) as count from board where gongji != '1' and subject not like 'Re%'" + code_title + sql_search + " order by uid desc LIMIT "+first+", "+num_per_page;;
					
					Connection con = DriverManager.getConnection(url, user, password);
					Statement stmt = con.createStatement();
					ResultSet rs = stmt.executeQuery(sql);
					
					int num = total_count - ((page_now - 1) * num_per_page); //넘버링 처리
					while(rs.next()){
						int uid = rs.getInt("uid");
						String subject = rs.getString("subject");
						int sub_len = subject.length();
						if(sub_len > 36){
							subject = subject.substring(0, 36) + "...";
						}
						
						String gongji = rs.getString("gongji");					
						String signdate = rs.getString("signdate");
						String id = rs.getString("id");
						
						//2일전까지 최신글 처리
						Date signdate2, day2;
	
						Date today = new Date(); //현재 날짜
	
						Date day_22 = new Date(today.getTime() - (long)(1000*60*60*24*2)); //현재 날짜 - 2일
						SimpleDateFormat bbb = new SimpleDateFormat("yyyy-MM-dd"); //년-월-일 변경
						String day_2 = bbb.format(day_22); //2일전 날짜를 문자열 변수에 대입
	
						day2 = new SimpleDateFormat("yyyy-MM-dd").parse(day_2); //2일전
						signdate2 = new SimpleDateFormat("yyyy-MM-dd").parse(signdate); //작성일
						
						String r = rs.getString("signdate").substring(0,10);
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						String signdate3 = sdf.format(today);
						
						String file1 = rs.getString("file1");
						int count = rs.getInt("count");
						
					%>
					<tr height="25" style="border-bottom: 1px solid #F2F2F2">
						<td class="td2"><%=num%></td>
						<td>
							<%
							if(gongji.equals("3")){ //비밀글일 때
								if((session_id != null && session_id.equals(id)) || (session_level != null && session_level.equals("99"))){ //관리자,작성자라면
							%>
									<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>" style="color:black"><%=subject %></a>
							<%
								}else{
							%>
									<a onclick="alert('It\'s a secret post')" style="cursor:pointer; color: #9C9C10">Secret Post</a>
							<%
								}
							}else{ //일반글일 때
							%>
								<a href="view.jsp?code=<%=code%>&uid=<%=uid%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>" style="color: black"><%=subject %></a>
							<%
							}
							%>
							<%if(gongji.equals("3")){%><img src="img/icon_secret.gif"><%}%>
							<%if(!file1.equals("")){%><img src="img/icon_file.gif"><%}%>
							<%if(signdate2.getTime() >= day2.getTime()){%><img src="img/main_new.gif"><%}%>
							<%if(count > 0){%><font color=red>(<%=count%>)</font><%}%>
							
						</td>
						<td class="td2">
								<%=rs.getString("name") %>
						</td>
						<td class="td2">
							<%if(signdate3.equals(r)){%>
								<%=rs.getString("signdate").substring(10) %>
							<%}else{%>
								<%=rs.getString("signdate").substring(0,10) %>
							<%}%>
						</td>
						<td class="td2"><%=rs.getString("ref") %></td>
					</tr>	
					<%
					num--;
					}
					if(total_count == 0){
					%>
					<tr>
						<td colspan=6 align=center height=100>NO POST</td>
					</tr>
					<%
					}
				}
				%>
			</table>
			
			
			<table width=800 border=0>
				<tr>
					<td width=100 align=right>
						<%if(session_id != null){ //로그인 후 %>
						<button><a class="write_a" href="write.jsp?code=<%=code%>">Write</a></button>
						<%}else{ //로그인 전%>
						<button><a class="write_a" onclick="writeGo()">Write</a></button>
						<%} %>
					</td>
				</tr>
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
								<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=first_page%>"><img src="/board/img/btn_left.gif"></a>&nbsp;&nbsp;
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
								&nbsp;<a href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=last_page + 1%>"><img src="/board/img/btn_right.gif"></a>
							<%
							}
							//페이징 처리 끝 /////////////////////////////			
							%>
					</td>	
				</tr>			
			</table>
			<br>		
			<table width=800 border=0>
				<tr>
					<td align=center>
						<form>
							<select name="field">
								<option value="subject" <%if(field.equals("subject")){%>selected<%}%>>Title</option>
								<option value="comment" <%if(field.equals("comment")){%>selected<%}%>>Content</option>
								<option value="name" <%if(field.equals("name")){%>selected<%}%>>Writer</option>
							</select>
							<input name="search" value="<%=search%>">
							<button style="border-radius:6px;">search</button>
						</form>
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