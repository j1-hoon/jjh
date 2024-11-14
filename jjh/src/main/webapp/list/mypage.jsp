<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/dbconnect.jsp" %> 
<!DOCTYPE html>
<html lang="en">
<script>
function order_cancel(num){
	result = confirm("Do you want to cancel your order?");
	if(result == true){
		location.href="/list/cancel.jsp?uid=" +num;
		alert('Your order has been canceled');
	}
}

function order_complete(num){
	result = confirm("Do you want to confirm your purchase?");
	if(result == true){
		location.href="/list/complete.jsp?uid=" +num;
		alert('The purchase has been confirmed');
	}
}
</script>

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
        .order_a{
        	cursor:pointer;
        	text-decoration: underline;
        }
        a{
        	color: red;
        }
        a:hover{
            color: green;
        }
        button{
        	width: 300px
        }
    </style>
</head>
<body>
<%
String uid = request.getParameter("uid");

String sql = "select * from order1 where uid="+ uid;

Connection con = DriverManager.getConnection(url, user, password);
Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String file1 = "";
String subject = "";
String price = "";
String id = ""; 
String phone = "";
String re = "";
String signdate = "";
String name = "";
String address = "";
String status = "";

if(rs.next()){
	file1 = rs.getString("file1");
	subject = rs.getString("subject");
	price = rs.getString("price");
	id = rs.getString("name");
	phone = rs.getString("phone");
	re = rs.getString("re");
	signdate = rs.getString("signdate");
	name = rs.getString("payment_name");
	address = rs.getString("address");
	status = rs.getString("status");
	int sub_len = subject.length();
	if(sub_len > 25){
		subject = subject.substring(0, 25) + "<br>" + subject.substring(25);
	}
}
rs.close();
stmt.close();
con.close();
%>
    <table height=160>
        <tr>
            <td></td>
        </tr>
    </table>
    <table id="t0" align=center>
        <tr>
            <td colspan="2" height=30></td>
        </tr>
        <tr>
            <td colspan="2" align=center>Order Information</td>
        </tr>
        <tr>
        	<td colspan="2" height=20></td>
        </tr>
        <tr>
			<td colspan="2" align=center style="padding-left:80px">
				<table width=400>
					<tr>
						<td width=100><%=rs.getString("signdate").substring(0,10)%></td>
						<td width=200></td>
						<td></td>
					</tr>
					<tr>
						<td rowspan="3"><img src="/upload/<%=file1%>" width=70></td>
						<td colspan="2" style="font-weight: bold; font-size:15px">
							<%if(status.equals("order")){ %>
								Order Status: Order Completed 
							<%}else if(status.equals("deposit")){%>
								Order Status: Deposit Confirmation
							<%}else if(status.equals("shipping")){%>
								Order Status: Shipping in Progress
							<%}else if(status.equals("complete")){%>
								Order Status: Delivery Completed
							<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="2"><%=subject%></td>
					</tr>
					<tr>
						<td colspan="2">₩<%=price%></td>
					</tr>
						
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" align=center w>
				<%if(status.equals("order")){%>
					<a class="order_a" onclick="order_cancel(<%=uid%>)"><button>ORDER CANCELLATION</button></a>
				<%}else if(status.equals("complete")){%>
					<a class="order_a" onclick="order_complete(<%=uid%>)"><button>ORDER CONFIRMATION</button></a>
				<%}%>
			</td>
		</tr>
		<tr><td colspan="2" height=10></td></tr>
		<tr>
			<td colspan="2" align=center>
				<table width=320>
					<tr>
						<td colspan="2" style="font-weight:bold; font-size:17px">Orderer Information</td>
					</tr>
					<tr>
						<td width=100>Orderer</td>
						<td><%=id%></td>
					</tr>
					<tr>
						<td>Phone</td>
						<td><%=phone%></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" height=10></td></tr>
		<tr>
			<td colspan="2" align=center>
				<table width=320>
					<tr>
						<td colspan="2" style="font-weight:bold; font-size:17px">Payment Information</td>
					</tr>
					<tr>
						<td width=100>Method</td>
						<td>send</td>
					</tr>
					<tr>
						<td width=100>Price</td>
						<td><%=price%></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" height=10></td></tr>
		<tr>
			<td colspan="2" align=center> 
				<table width=320>
					<tr>
						<td colspan="2" style="font-weight:bold; font-size:17px">Shipping</td>
					</tr>
					<tr>
						<td width=100>Name</td>
						<td><%=name%></td>
					</tr>
					<tr>
						<td width=100>Address</td>
						<td><%=address%></td>
					</tr>
					<tr>
						<td width=100>Phone</td>
						<td><%=phone%></td>
					</tr>
					<tr>
						<td width=100>Request</td>
						<td><%=re%></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr><td colspan="2" height=10></td></tr>
		<tr>
			<td align=left style="padding-left:90px"><a href=/list/mypage2.jsp>&lt;</a></td>
			<td align=right style="padding-right:70px">
				<a href=/index.jsp>HOME</a>
			</td>
		</tr>
		<tr>
            <td colspan="2" height=60></td>
        </tr>
    </table>
</body>
</html>

