<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/admin/include/header2.jsp" %>

<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String id2 = request.getParameter("id");

String sql = "select * from member where id='"+id2+"'";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = "";
String pass = "";
String nickname = "";
String email = "";
String z1 = "";
String z2 = "";
String z3 = "";
String z4 = "";

while(rs.next()){
	id = rs.getString("id");
	pass = rs.getString("pass");
	nickname = rs.getString("nickname");
	email= rs.getString("email");
	z1 = rs.getString("z1");
	z2 = rs.getString("z2");
	z3 = rs.getString("z3");
	z4 = rs.getString("z4");
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
															<td align=left><b>Admin modifying</b></td>
														</tr>
													</table>
													<form action="/admin/member/update.jsp" method="post" onsubmit="return join()">
													<table class="t1">
														<tr>
															<td>ID</td>
															<td><input id="id" name="id" value="<%=id%>" readonly="readonly"></td>
														</tr>
														<tr>
															<td>PASSWORD</td>
															<td><input id="pass" name="pass" value="<%=pass%>" required="required"></td>
														</tr>
														<tr>
															<td>NAME</td>
															<td><input id="nickname" name="nickname" value="<%=nickname%>" required="required"></td>
														</tr>
														<tr>
															<td>E-MAIL</td>
															<td>
																<input type="email" id="email" name="email" value="<%=email%>" required="required">
															</td>
														</tr>
														<tr>
															<td>POSTCODE</td>
															<td>
									                        	<input class="p1" type="text" id="sample6_postcode" placeholder="POSTCODE(option)" name="z1" value="<%=z1%>">
																<input type="button" onclick="sample6_execDaumPostcode()" value="SEARCH" style="border: 0px;">
									                        </td>
														</tr>
														<tr>
															<td>ADDRESS</td>
									                        <td>
																<input class="p1" type="text" id="sample6_address" placeholder="ADDRESS" name="z2" value="<%=z2%>">
									                        </td>
									                    </tr>
									                    <tr>
									                    	<td>ADDRESS2</td>
									                        <td>
																<input class="p1" type="text" id="sample6_detailAddress" placeholder="ADDRESS2" name="z3" value="<%=z3%>">
									                        </td>
									                    </tr>
									                    <tr>
									                    	<td>ADDRESS3</td>
									                    	<td>
									                       		<input class="p1" type="text" id="sample6_extraAddress" placeholder="ADDRESS3" name="z4" value="<%=z4%>">
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
													
									<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
									<script>
									    function sample6_execDaumPostcode() {
									        new daum.Postcode({
									            oncomplete: function(data) {
									                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
									
									                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
									                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
									                var addr = ''; // 주소 변수
									                var extraAddr = ''; // 참고항목 변수
									
									                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
									                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									                    addr = data.roadAddress;
									                } else { // 사용자가 지번 주소를 선택했을 경우(J)
									                    addr = data.jibunAddress;
									                }
									
									                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
									                if(data.userSelectedType === 'R'){
									                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
									                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
									                        extraAddr += data.bname;
									                    }
									                    // 건물명이 있고, 공동주택일 경우 추가한다.
									                    if(data.buildingName !== '' && data.apartment === 'Y'){
									                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
									                    }
									                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									                    if(extraAddr !== ''){
									                        extraAddr = ' (' + extraAddr + ')';
									                    }
									                    // 조합된 참고항목을 해당 필드에 넣는다.
									                    document.getElementById("sample6_extraAddress").value = extraAddr;
									                
									                } else {
									                    document.getElementById("sample6_extraAddress").value = '';
									                }
									
									                // 우편번호와 주소 정보를 해당 필드에 넣는다.
									                document.getElementById('sample6_postcode').value = data.zonecode;
									                document.getElementById("sample6_address").value = addr;
									                // 커서를 상세주소 필드로 이동한다.
									                document.getElementById("sample6_detailAddress").focus();
									            }
									        }).open();
									    }
									</script>
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