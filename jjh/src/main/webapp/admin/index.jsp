<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/admin/include/header2.jsp" %>
<%
String sql_0 = "select count(*) from order1 where status='order'";

int total_0 = 0;

Connection con_0 = DriverManager.getConnection(url, user, password);
Statement stmt_0 = con_0.createStatement();
ResultSet rs_0 = stmt_0.executeQuery(sql_0);

if(rs_0.next()){
	total_0 = rs_0.getInt(1);
}

rs_0.close();
stmt_0.close();
con_0.close();

String sql_1 = "select count(*) from order1 where status='deposit'";

int total_1 = 0;

Connection con_1 = DriverManager.getConnection(url, user, password);
Statement stmt_1 = con_1.createStatement();
ResultSet rs_1 = stmt_1.executeQuery(sql_1);

if(rs_1.next()){
	total_1 = rs_1.getInt(1);
}

rs_1.close();
stmt_1.close();
con_1.close();

String sql_2 = "select count(*) from order1 where status='shipping'";

int total_2 = 0;

Connection con_2 = DriverManager.getConnection(url, user, password);
Statement stmt_2 = con_2.createStatement();
ResultSet rs_2 = stmt_2.executeQuery(sql_2);

if(rs_2.next()){
	total_2 = rs_2.getInt(1);
}

rs_2.close();
stmt_2.close();
con_2.close();

String sql_3 = "select count(*) from order1 where status='complete'";

int total_3 = 0;

Connection con_3 = DriverManager.getConnection(url, user, password);
Statement stmt_3 = con_3.createStatement();
ResultSet rs_3 = stmt_3.executeQuery(sql_3);

if(rs_3.next()){
	total_3 = rs_3.getInt(1);
}

rs_3.close();
stmt_3.close();
con_3.close();

String sql_4 = "select count(*) from member";

int total_4 = 0;

Connection con_4 = DriverManager.getConnection(url, user, password);
Statement stmt_4 = con_4.createStatement();
ResultSet rs_4 = stmt_4.executeQuery(sql_4);

if(rs_4.next()){
	total_4 = rs_4.getInt(1);
}

rs_4.close();
stmt_4.close();
con_4.close();

String sql_5 = "select count(*) from order1 where status='confirmation'";

int total_5 = 0;

Connection con_5 = DriverManager.getConnection(url, user, password);
Statement stmt_5 = con_5.createStatement();
ResultSet rs_5 = stmt_5.executeQuery(sql_5);

if(rs_5.next()){
	total_5 = rs_5.getInt(1);
}

rs_5.close();
stmt_5.close();
con_5.close();

int total = total_0 + total_1 + total_2 + total_3;
%>

						    <table class="t1" width=1590 height=650>
						        <tr>
						        	<td align=center style="vertical-align: top">
						        		<table align=left>
						        			<tr>
												<td><b>Statistics</b></td>
											</tr>
								   		</table>
								   		<table class="t1">
											<tr>
												<td align=center>Current Situation</td>
												<td align=center>Order Status</td>
											</tr>
											<tr>
												<td>
													<table class="t1" align=center>
														<thead>
														<tr>
															<td align=center width=100>Total Members</td>
															<td align=center width=100>Purchase Confirmation</td>
														</tr>
														</thead>
														<tbody>
														<tr>
															<td align=center><%=total_4%></td>
															<td align=center><%=total_5%></td>
														</tr>
														</tbody>
													</table>
												</td>
												<td>
													<table class="t1" align=center>
														<thead>
														<tr>
															<td align=center width=80>Total Order</td>
															<td align=center width=80>Order</td>
															<td align=center width=80>Deposit</td>
															<td align=center width=80>shipping</td>
															<td align=center width=80>Complete</td>	
														</tr>
														</thead>
														<tbody>
														<tr>
															<td align=center><%=total%></td>
															<td align=center><%=total_0%></td>
															<td align=center><%=total_1%></td>
															<td align=center><%=total_2%></td>
															<td align=center><%=total_3%></td>
														</tr>
														</tbody>
													</table>
												</td>
											</tr>
										</table>
										<br>
										<table align=left>
											<tr>
												<td><b>Latest Order list</b></td>
											</tr>									
										</table>
										<table class="t1" border=1 align=center>
											<thead>
											<tr>
												<td align=center><b>No</b></td>
												<td align=center><b>Date</b></td>
												<td align=center><b>Product</b></td>
												<td align=center><b>Address</b></td>
												<td align=center><b>Tel</b></td>
												<td align=center><b>Price</b></td>
												<td align=center><b>Id</b></td>
												<td align=center><b>Name</b></td>
												<td align=center><b>Request</b></td>
											</tr>
											<thead>
											<tbody>
												<%
												String sql_count = "select count(*) from order1";
												
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
							
												int num_per_page = 2; //한 페이지당 출력 게시물 수
												int page_per_block = 10; //한 블럭당 출력 링크 수
												int total_page = (int)Math.ceil(total_count / (double)num_per_page); //총 페이지 수
												int first = num_per_page * (page_now - 1); //limit 시작 값
												
												String sql = "select * from order1 where status='order' order by signdate desc LIMIT "+first+", "+num_per_page;
												
												Connection con = DriverManager.getConnection(url, user, password);
												Statement stmt = con.createStatement();
												ResultSet rs = stmt.executeQuery(sql);
								
												
												while(rs.next()){
													int uid = rs.getInt("uid");
													String file1 = rs.getString("file1");
													String subject = rs.getString("subject");
													String price = rs.getString("price");
													String id = rs.getString("name");
													String phone = rs.getString("phone");
													String re = rs.getString("re");
													String signdate = rs.getString("signdate");
													String name = rs.getString("payment_name");
													String address = rs.getString("address");
												%>
													<tr>
														<td width=30 align=center><%=uid%></td>
														<td width=130 align=center><%=signdate%></td>
														<td width=300><img src="/upload/<%=file1%>" width=30><%=subject%></td>
														<td width=350 align=center><%=address%></td>
														<td width=80 align=center><%=phone%></td>
														<td width=50 align=center><%=price%></td>
														<td width=100 align=center><%=id%></td>
														<td width=50 align=center><%=name%></td>
														<td width=150 align=center><%=re%></td>
													</tr>
												<%
												}
												
												rs.close();
												stmt.close();
												con.close();
												%>
											</tbody>
										</table>
										<br>
										<table align=left>
								   			<tr>
												<td><b>Newest Member</b></td>
											</tr>
								   		</table>
								   		<table class="t1">
									       <thead>
									       <tr id="1f">
												<th>id</th>
												<th>pass</th>
												<th>name</th>
												<th>email</th>
												<th>address</th>
												<th>date</th>
									       </tr>
									       </thead>
									       <tbody>
									       <%
										        String sql_coun = "select count(*) from member";
												
												int total_coun = 0;
												
												Connection con_coun = DriverManager.getConnection(url, user, password);
												Statement stmt_coun = con_coun.createStatement();
												ResultSet rs_coun = stmt_coun.executeQuery(sql_coun);
							
												if(rs_coun.next()){
													total_coun = rs_count.getInt(1);
												}
							
												rs_coun.close();
												stmt_coun.close();
												con_coun.close();
												
												//페이징 관련
							
												int page_now_2 = 1;
												if(request.getParameter("page_now_2") != null){
													page_now_2 = Integer.parseInt(request.getParameter("page_now_2")); //현재 페이징 수
												}
							
												int num_per_page_2 = 2; //한 페이지당 출력 게시물 수
												int page_per_block_2 = 10; //한 블럭당 출력 링크 수
												int total_page_2 = (int)Math.ceil(total_coun / (double)num_per_page_2); //총 페이지 수
												int first_2 = num_per_page_2 * (page_now_2 - 1); //limit 시작 값
												
												String sql_m = "select * from member order by signdate desc LIMIT "+first+", "+num_per_page;
												
												Connection con_m = DriverManager.getConnection(url, user, password);
												Statement stmt_m = con_m.createStatement();
												ResultSet rs_m = stmt_m.executeQuery(sql_m);
												
												String id = "";
												String pass = "";
												String nickname = "";
												String email = "";
												String z2 = "z2";
												String z3 = "z3";
												String z4 = "z4";
												String signdate = "";
												
												while(rs_m.next()){
													id = rs_m.getString("id");
													pass = rs_m.getString("pass");
													nickname = rs_m.getString("nickname");
													email= rs_m.getString("email");
													z2 = rs_m.getString("z2");
													z3 = rs_m.getString("z3");
													z4 = rs_m.getString("z4");
													signdate = rs_m.getString("signdate");
												%>
									       <tr>
									           <td><%=id%></td>
									           <td><%=pass%></td>
									           <td><%=nickname%></td>
									           <td><%=email%></td>
									           <td><%=z2%> <%=z3%> <%=z4%></td>
									           <td><%=signdate%></td>
									       </tr>
									       		<%
												}
												rs_m.close();
												stmt_m.close();
												con_m.close();
												%>
									       </tbody>
										</table>
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