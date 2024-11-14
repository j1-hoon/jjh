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
            width: 510px;
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
        .a0{
        	color: black;
        	text-decoration-line: none;
        }
        .a0:hover{
            color: green;
        }
    </style>
</head>
<body>
<%
request.setCharacterEncoding("utf-8"); //한글 깨지지 않게 처리
String session_id = (String)session.getAttribute("id");
String sql = "select * from member where id='"+session_id+"'";

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id = "";
String nickname = "";
String email = "";

String z1 = "";
String z2 = "";
String z3 = "";
String z4 = "";
if(rs.next()){
	id = rs.getString("id");
	nickname = rs.getString("nickname");
	email = rs.getString("email");
	z1 = rs.getString("z1");
	z2 = rs.getString("z2");
	z3 = rs.getString("z3");
	z4 = rs.getString("z4");
}

rs.close();
stmt.close();
con.close();

%>

    <table height=40>
        <tr>
            <td></td>
        </tr>
    </table>
    <form action="update.jsp" method="post" onsubmit="return join()">
    <table id="t0" align=center>
        <tr>
            <td width=40></td>
            <td colspan="2" height=70></td>
            <td width=40></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=center><img src="../img/info.png" width=65 style="padding-bottom: 30px; padding-left: 9px"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center><input class="p1" id="id" name="id" value="<%=id%>" placeholder="*ID" readonly="readonly"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center><input class="p1" id="nickname" name="nickname" value="<%=nickname%>" placeholder="*NICKNAME" required="required"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center><input class="p1" id="email" name="email" value="<%=email%>" placeholder="*EMAIL" required="required"></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                        <td align=center>
                        	<input class="p1" type="text" id="sample6_postcode" placeholder="POSTCODE(option)" name="z1" value="<%=z1%>">
							<input type="button" onclick="sample6_execDaumPostcode()" value="SEARCH" style="border: 0px;">
                        </td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <table id="t1" align=center>
                    <tr>
                        <td align=center>
							<input class="p1" type="text" id="sample6_address" placeholder="ADDRESS" name="z2" value="<%=z2%>">
                        </td>
                    </tr>
                </table>
                <br>
            </td>
            <td>
                <table id="t1" align=center>
                    <tr>
                        <td align=center>
							<input class="p1" type="text" id="sample6_detailAddress" placeholder="ADDRESS2" name="z3" value="<%=z3%>">
                        </td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table id="t3" align=center>
                    <tr>
                    	<td align=center>
                       		<input class="p1" type="text" id="sample6_extraAddress" placeholder="ADDRESS3" name="z4" value="<%=z4%>">
                        </td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">
                <table align=center>
                    <tr>
                        <td align=center><button id="t2">MODIFY</button></td>
                    </tr>
                </table>
                <br>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" align=right style="color: #D00109">
            	<a class="a0" href=../list/mypage2.jsp>ORDER</a>&ensp;
            	<a class="a0" href=../index.jsp>HOME</a>
            </td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" height=60></td>
            <td></td>
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
</body>
</html>

