<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header2.jsp" %>
						    <table class="t1" width=1590 height=650>
						        <tr><td align=center style="vertical-align: top">
						        	<table align=left>
										<tr>
											<td><b>Product Registration</b></td>
										</tr>
									</table>
									<form action="insert.jsp" method="post" enctype="multipart/form-data">
									<table class="t1"  border=1>
										<tr>
											<td align=center>Category</td>
											<td style="border-right: 0px">
												<select name = "code">
														<option value="product">product</option>
												</select>
											</td>
										</tr>
										<tr>
											<td align=center>Product Title</td>
											<td colspan="2">
												<input id="subject" name="subject" style="width:98%">
											</td>
										</tr>
										<tr>
											<td align=center>Price</td>
											<td colspan="2">
												<input id="price" name="price" style="width:98%;">
											</td>
										</tr>
										<tr>
											<td align=center height=267>Product Descriptions</td>
											<td colspan="2">
												<textarea id="comment" name="comment" style="width:98%;height:263px;"></textarea>
											</td>
										</tr>
										<tr>
											<td align=center>Image</td>
											<td>
												<input type="file" name="file1">
											</td>
										</tr>
									</table>
									<table class="t1">
										<tr>
											<td></td>
											<td align=right><button style="width:100px">Registration</button></td>
										</tr>
									</table>
									</form>
						        </td></tr>
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