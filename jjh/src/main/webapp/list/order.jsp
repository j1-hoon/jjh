<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_m.jsp" %>
<%@ include file="info.jsp" %>

<%
String uid = request.getParameter("uid");

String sql = "select * from shop where uid="+ uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String subject = "";
String price = "";
String file1 = "";

if(rs.next()){
	subject = rs.getString("subject");
	price = rs.getString("price");
	file1 = rs.getString("file1");
}

rs.close();
stmt.close();
con.close();
%>
<script>
function gogo(){
	if(name.value == ""){
		alert("이름을 입력하세요.");
		subject.focus();
		return false;
	}
	if(phone.value == ""){
		alert("전화번호를 입력하세요.");
		comment.focus();
		return false;
	}
	if(address.value == ""){
		alert("주소를 입력하세요.");
		comment.focus();
		return false;
	}
}
</script>
<table width=100%>
	<tr>
		<td align=center>
			<table width=800>
				<tr>
					<td align=left><b>[Order]</b></td><br>
				</tr>				
			</table>
			<br>
			<hr>
			<table class="t1" width=800 border=1>
               <tr>
                   <td align=center width=110 style="background:#EDF2FA; border-weight:bold">Img</td>
                   <td align=center style="background:#EDF2FA; border-weight:bold">Product</td>
                   <td align=center width=100 style="background:#EDF2FA; border-weight:bold">Quantity</td>
                   <td align=center width=100 style="background:#EDF2FA; border-weight:bold">Price</td>
                   <td align=center width=100 style="background:#EDF2FA; border-weight:bold">Delivery fee</td>
               </tr>
               <tr>
                   <td align=center><img src="/upload/<%=file1%>" width=100></td>
                   <td align=center><%=subject%></td>
                   <td align=center>1</td>
                   <td align=center>₩<%=price%></td>
                   <td align=center>₩3,000</td>
               </tr>
            </table>
            <br>
            
            <table width=800>
                <tr>
                    <td align=left>Orderer Information</td>
                </tr>
                <tr>
                    <td>
                    	<form action="insert.jsp" method="post" onsubmit="return gogo()">
                    	<input type="hidden" name="file1" value="<%=file1%>">
                    	<input type="hidden" name="subject" value="<%=subject%>">
                        <table width=800 border=1 class="t1">
                            <tr>
                                <td width=200 style="background:#EDF2FA; border-weight:bold">name</td>
                                <td><input id="name" name="name" value="" required="required" style="width:98%;"></td>
                            </tr>
                            <tr>
                                <td style="background:#EDF2FA; border-weight:bold">phone Num</td>
                                <td><input id="phone" name="phone" value="" required="required" style="width:98%;"></td>
                            </tr>
                            <tr>
                                <td style="background:#EDF2FA; border-weight:bold">address</td>
                                <td>
                                	<input type="text" id="sample6_postcode" value="" name="z1" required="required">
									<input type="button" onclick="sample6_execDaumPostcode()" value="SEARCH" style="border: 0px; "><br>
									<input type="text" id="sample6_address" name="z2" value="" style="width:98%;"><br>
									<input type="text" id="sample6_detailAddress" name="z3" value="" style="width:98%;"><br>
									<input type="text" id="sample6_extraAddress" name="z4" value="" style="width:98%;">
                                </td>
                            </tr>
                            <tr>
                                <td style="background:#EDF2FA; border-weight:bold"> Request</td>
                                <td><textarea id="request" name="request" style="width:99%;height:50px;"></textarea></td>
                            </tr>
                        </table>
                        <br>
                        <table width=800>
                            <tr>
                                <td>Payment Information</td>
                            </tr>
                            <tr>
                                <td>
                                    <table width=800 border=1 class="t1">
                                    <%
                                    String str = price.replace(",", "");
                                    int p = Integer.parseInt(str);
                                   	String total = (p+3000) + "";
                                    %>
                                        <tr>
                                            <td width=200 style="background:#EDF2FA; border-weight:bold">Payment method</td>
                                            <td>send</td>
                                        </tr>
                                        <tr>
                                            <td style="background:#EDF2FA; border-weight:bold">Price</td>
                                            <td>₩<%=price%></td>
                                        </tr>
                                        <tr>
                                            <td style="background:#EDF2FA; border-weight:bold">Delivery fee</td>
                                            <td>₩3,000</td>
                                        </tr>
                                        <tr>
                                            <td style="background:#EDF2FA; border-weight:bold">Total</td>
                                            <td><input id="price" name="price" value="<%=total%>" readonly="readonly" style="width:98%;"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        
                        <table align=center>
                            <tr>
                                <td><button>order</button></td>
                                <td><a href=""><button>cancel</button></a></td>
                            </tr>
                        </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

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














<%@ include file="/include/f.jsp" %>