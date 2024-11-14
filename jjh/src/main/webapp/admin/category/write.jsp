<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<%@ include file="/admin/include/header2.jsp" %>
						    <table class="t1" width=1590 height=650>
						        <tr><td align=center style="vertical-align: top">
						        	<table align=left>
										<tr>
											<td><b>Player Registration</b></td>
										</tr>
									</table>
									<form action="insert.jsp" method="post" onsubmit="return gogo()" enctype="multipart/form-data">
									<table class="t1"  border=1>
										<tr>
											<td>Position</td>
											<td>
												<select name="tab">
													<option value="fw">FW</option>
													<option value="mf">MF</option>
													<option value="df">DF</option>
													<option value="gk">GK</option>
												</select>
											</td>
										</tr>
										<tr>
											<td>Name</td>
											<td><input id="title" name="title"></td>
										</tr>
										<tr>
											<td>Backnumber</td>
											<td><input id="num" name="num"></td>
										</tr>
										<tr>
											<td>Img</td>
											<td><input type="file" name="file1"></td>
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