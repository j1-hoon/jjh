<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header2.jsp" %>

						    <table class="t1" width=1590 height=650>
						        <tr>
						        	<td style="vertical-align: top">
						        		<table>
											<tr>
												<td align=left><b>Product list</b></td>
											</tr>
										</table>
										<table class="t1" border=1 align=center>
											<thead>
											<tr>
												<td align=center><b>No</b></td>
												<td align=center><b>Img</b></td>
												<td align=center><b>Name</b></td>
												<td align=center><b>Price</b></td>
												<td align=center><b>Sold Out</b></td>
												<td colspan=2 align=center></td>
											</tr>
											<thead>
											<tbody>
												<%
												String sql_count = "select count(*) from shop";
												
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
												
												String sql = "select * from shop LIMIT "+first+", "+num_per_page;
												
												Connection con = DriverManager.getConnection(url, user, password);
												Statement stmt = con.createStatement();
												ResultSet rs = stmt.executeQuery(sql);
												
												
												
												while(rs.next()){
													int uid = rs.getInt("uid");
													String file1 = rs.getString("file1");
													String subject = rs.getString("subject");
													String price = rs.getString("price");
													String soldout = rs.getString("soldout");
												%>
													<tr>
														<td width=100 align=center><%=price%></td>
														<td width=60><img src="/upload/<%=file1%>" width=50></td>
														<td><%=subject%></td>
														<td width=100 align=center><%=price%></td>
														<td width=100 align=center>
															<%if(soldout.equals("x")){%>
																<a href="/admin/shop/soldout.jsp?uid=<%=uid%>&soldout=<%=soldout%>"><button>X</button></a>
															<%}else{%>
																<a href="/admin/shop/soldout.jsp?uid=<%=uid%>&soldout=<%=soldout%>"><button>O</button></a>
															<%}%>
														</td>
														<td width=50 align=center><button><a href="/admin/shop/modify.jsp?uid=<%=uid%>">modify</a></button></td>
											   			<td width=50 align=center><button><a onclick="delete_go(<%=uid%>)">delete</a></button></td>
													</tr>
												<%
												}
												
												rs.close();
												stmt.close();
												con.close();
												%>
											</tbody>
										</table>
										<table class="t1">
											<tr>
												<td align=right><button style="width:100px"><a href="/admin/shop/write.jsp" style="color:black">Registration</a></button></td>
											</tr>
										</table>
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
															<a href="list.jsp?page_now=<%=first_page%>"><img src="/board/img/btn_left.gif"></a>&nbsp;&nbsp;
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
																<span class="page_off"><a href="list.jsp?page_now=<%=direct_page%>"><%=direct_page%></a></span>&nbsp;
														<%
															}
														}
															
														// 다음 블럭 처리
														if(block < total_block) { //다음 블럭 존재
														%>
															&nbsp;<a href="list.jsp?page_now=<%=last_page + 1%>"><img src="/board/img/btn_right.gif"></a>
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