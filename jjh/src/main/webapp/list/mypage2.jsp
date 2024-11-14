<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <style>
        body{
            background-image: linear-gradient(
                rgba(0, 0, 0, 0.8),
                rgba(0, 0, 0, 0.8)
            ), url(../img/stadium.jpg);
            background-size: cover;
        }
        #t0{
            background: lightgrey;
            border-radius: 3px;
        }
        #t1{
            background: #414141;
            color: #969696;
            border-radius: 6px;
            width: 250px;
            height: 50px;
        }
        #t3{
            background: #414141;
            color: #969696;
            border-radius: 6px;
            width: 300px;
            height: 50px;
        }
        #t2{
            background: #D00109;
            color: lightgrey;
            border-radius: 6px;
            width: 300px;
            height: 50px;
        }
        .p1{
        	color: white;
            border: 0px;
            background: #414141;
            text-align: center;
            font-size: 16px;
            font-weight: bold;
        }
        .home_a{
            color: red;
        }
        .order_a{
            text-decoration: none;
            color: black;
        }
        a:hover{
            color: green;
        }
    </style>
</head>
<body>
<%
String session_id = (String)session.getAttribute("id");
%>
    <table height=150>
        <tr>
            <td></td>
        </tr>
    </table>
    <table id="t0" width=500 height=600 align=center>
        <tr>
            <td height=30></td>
        </tr>
        <tr>
            <td align=center><img src="/img/order.png"></td>
        </tr>
        <tr>
        	<td height=20></td>
        </tr>
	        <%	
		        String sql_count = "select count(*) from order1 where name='"+session_id+"'";
				
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

				int num_per_page = 4; //한 페이지당 출력 게시물 수
				int page_per_block = 10; //한 블럭당 출력 링크 수
				int total_page = (int)Math.ceil(total_count / (double)num_per_page); //총 페이지 수
				int first = num_per_page * (page_now - 1); //limit 시작 값
	        	
	        	String sql_order = "select * from order1 where name='"+session_id+"' order by signdate desc LIMIT "+first+", "+num_per_page;
													
				Connection con_order = DriverManager.getConnection(url, user, password);
				Statement stmt_order = con_order.createStatement();
				ResultSet rs_order = stmt_order.executeQuery(sql_order);
									
													
				while(rs_order.next()){
					int uid = rs_order.getInt("uid");
					String file1 = rs_order.getString("file1");
					String subject = rs_order.getString("subject");
					String price = rs_order.getString("price");
					String id = rs_order.getString("name");
					String phone = rs_order.getString("phone");
					String re = rs_order.getString("re");
					String signdate = rs_order.getString("signdate");
					String name = rs_order.getString("payment_name");
					String address = rs_order.getString("address");
					String status = rs_order.getString("status");
					int sub_len = subject.length();
					if(sub_len > 25){
						subject = subject.substring(0, 25) + "...";
					}
				%>
					<tr>
						<td align=center style="padding-left:80px">
							<a class="order_a" href="mypage.jsp?uid=<%=uid%>">
							<table width=400>
								<tr>
									<td width=100><%=rs_order.getString("signdate").substring(0,10)%></td>
									<td width=200></td>
									<td>&gt;</td>
								</tr>
								<tr>
									<td rowspan="3"><img src="/upload/<%=file1%>" width=70></td>
									<td colspan="2"><%=status%></td>
								</tr>
								<tr>
									<td colspan="2"><%=price%></td>
								</tr>
								<tr>
									<td colspan="2"><%=subject%></td>
								</tr>
							</table>
							</a>
						</td>
					</tr>
				<%
				}
													
					rs_order.close();
					stmt_order.close();
					con_order.close();
				%>
				<tr><td height=10></td></tr>
		<tr>
            <td height=20></td>
        </tr>
        <tr>
        	<td>
        		<table align=center>
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
								<a href="/list/mypage2.jsp?page_now=<%=first_page%>"><img src="/board/img/btn_left.gif"></a>&nbsp;&nbsp;
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
								<span class="page_off"><a href="/list/mypage2.jsp?page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
							<%
								}
							}
															
							// 다음 블럭 처리
							if(block < total_block) { //다음 블럭 존재
							%>
								&nbsp;<a href="/list/mypage2.jsp?page_now=<%=last_page + 1%>"><img src="/board/img/btn_right.gif"></a>
							<%
							}
							//페이징 처리 끝 /////////////////////////////			
							%>
						</td>	
					</tr>
				</table>
        	</td>
        </tr>
        <%if(total_count == 0){%>
		<tr>
			<td align=center style="padding-bottom: 100px">NO ORDER</td>
		</tr>
		<%}%>			
		<tr>
			<td align=right style="padding-right:70px"><a class="home_a" href=/index.jsp>HOME</a></td>
		</tr>
        <tr>
            <td height=40></td>
        </tr>
    </table>
</body>
</html>

