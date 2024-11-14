<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/header.jsp" %>
<style>
	.f1, #t1{
		font-family: cursive;
	}
</style>
<body height=600>
    <table>
        <tr>
            <td valign=top width=320 style="padding-left: 70px">
                <table>
                    <tr>
                    	<%
						if(session_id == null){	//로그인 전
						%>
                        <td style="padding-top: 30px">
                            <table id=L1>
                                <tr>
                                    <td align=center><a href="/member/login.jsp">LOGIN<a></td>
                                </tr>
                            </table>
                        </td>
                        <td style="padding-top: 30px">
                              <table id=L2>
                                <tr>
                                    <td align=center><a href="/member/join.jsp">sign up</a></td>
                                </tr>
                            </table>
                        </td>
                        <%
						}else{
						%>
						<td style="padding-top: 30px">
                            <table id=L1>
                                <tr>
                                    <td align=center>NAME: <%=session_nickname %> <span style="color: black;"> | </span> Lv : <%=session_level %></td>
                                </tr>
                            </table>
                        </td>
                        <td style="padding-top: 30px">
                              <table id=L2>
                                <tr>
                                    <td align=center><a href="/member/confirm.jsp"><span style="color: #F8F8F8">Edit</span></a><td>
                                </tr>
                            </table>
                        </td>
						<%
						}
						%>
                    </tr>
                    <tr>
                        <td style="padding-top: 30px">
                            <table>
                                <tr>
                                    <td>
                                        <ul class="gnb">
                                        	<hr>
                                            <li><a href="/searchview.jsp">NEWS</a></li>
                                            <hr>
                                            <li><a href="#">MATCHES</a></li>
                                            <hr>
                                            <li><a href="/board/list.jsp">COMMUNITY</a></li>
                                            <hr>
                                            <li><a href="/team.jsp">PLAYER</a></li>
                                            <hr>
                                            <li><a href="/list/list.jsp?code=product">SHOP</a></li>
                                            <hr>
                                        </ul>
                                    </td>
                                </tr>
                            </table>
        
                        </td>
                    </tr>
                </table>
            </td>
            <td width=100></td>
            <td width=1080>
                <table>
                    <tr>
                        <td style="font-size: 30px; font-weight: bold; font-family: cursive; padding-top: 30px;">Title<br><span class="f1" style="font-size: 14px; ">2024-2025</span></td>
                    </tr>
                </table>
                <br>
                <table width=100%>
                    <tr id=t1>
                        <td>FORWARDS</td>
                        <td>MIDFIELDERS</td>
                        <td>DEFENDERS</td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/saka.jsp">7. SAKA</a></td>
                        <td><a href="/player/partey.jsp">5. PARTEY</a></td>
                        <td><a href="/player/saliba.jsp">2. SALIBA</a></td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/jesus.jsp">9. JESUS</a></td>
                        <td><a href="/player/odegaard.jsp">8. ODEGAARD</a></td>
                        <td><a href="/player/tierney.jsp">3. TIERNEY</a></td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/martinelli.jsp">11. MARTINELLI</a></td>
                        <td><a href="/player/jorginho.jsp">20. JORGINHO</a></td>
                        <td><a href="/player/white.jsp">4. WHITE</a></td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/trossard.jsp">19. TROSSARD</a></td>
                        <td><a href="/player/merino.jsp">23. MERINO</a></td>
                        <td><a href="/player/gabriel.jsp">6. GABRIEL</a></td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/haverts.jsp">29. HAVERTS</a></td>
                        <td><a href="/player/rice.jsp">41. RICE</a></td>
                        <td><a href="/player/timber.jsp">12. TIMBER</a></td>
                    </tr>
                    <tr class="f1">
                        <td><a href="/player/sterling.jsp">30. STERLING</a></td>
                        <td><a href="/player/.jsp"></a></td>
                        <td><a href="/player/kiwior.jsp">15. KIWIOR</a></td>
                 	</tr>
                 	<tr class="f1">
                        <td><a href="/player/.jsp"></a></td>
                        <td><a href="/player/.jsp"></a></td>
                        <td><a href="/player/zinchenko.jsp">17. ZINCHENKO</a></td>
                 	</tr>
                 	<tr class="f1">
                        <td id="t1" colspan=2>GOALKEEPERS</td>

                        <td><a href="/player/tomiyasu.jsp">18. TOMIYASU</a></td>
                 	</tr>
                 	<tr class="f1">
                        <td><a href="/player/raya.jsp">22. RAYA</a></td>
                        <td><a href="/player/neto.jsp">32. NETO</a></td>
                        <td><a href="/player/calafiori.jsp">33. CALAFIORI</a></td>
                 	</tr>
                </table>
            </td>
            <td width=100></td>
            <td valign=top width=320 style="padding-top: 30px">
                <img src="img/test.jpg" width=320>
            </td>
        </tr>
    </table>
</body>
<%@ include file="/include/footer.jsp" %>