<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/include/header_m.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
	ul { border: 2px #cccccc solid; padding: 10px; list-style-type: none; }
	li { 
		margin-bottom: 5px; 
		list-style:none;
		}
	.news_a {
        text-decoration: none;
        color: black;
      }
    .news_a:hover{
        color: grey;
    }
    a{
    	text-decoration: none;
    }
</style>
<table width=100%>
	<tr>
		<td align=center>
			<table width=800 border=0 style="border-bottom: 1px solid black">
				<tr>
					<td align=left style="font-size: 25px"><b>NEWS</b></td><br>
				</tr>			
			</table>
			<table width=800 style="border-top: 1px solid black">
				<tr>
					<td align=center>
						<script>
						$(function() {
						    // 페이지 선택 옵션을 동적으로 생성
						    for (let i = 1; i <= 10; i++) {
						        $('#startNum').append('<option value="' + ((i - 1) * 10 + 1) + '">Page ' + i + '</option>');
						    }
						
						    // 페이지 선택 시 AJAX 요청 실행
						    $('#startNum').change(function() {
						        executeSearch();
						    });
						
						    // 초기 AJAX 요청 실행 (첫 페이지)
						    executeSearch();
						});
						
						// AJAX 요청을 실행하는 함수
						function executeSearch() {
						    $.ajax({
						        url : "../NaverSearchAPI.do",  // 요청 URL
						        type : "get",                  // HTTP 메서드
						        data : {                       // 매개변수로 전달할 데이터
						            startNum : $('#startNum option:selected').val()  // 검색 시작 위치
						        },
						        dataType : "json",             // 응답 데이터 형식
						        success : sucFuncJson,         // 요청 성공 시 호출할 메서드 설정
						        error : errFunc                // 요청 실패 시 호출할 메서드 설정
						    });
						}
						
						// 검색 성공 시 결과를 화면에 뿌려줍니다.
						function sucFuncJson(d) {
						    var str = "";
						    $.each(d.items, function(index, item) {
						        str += "<li><a class='news_a' href='" + item.link + "' target='_blank'>" + item.title + "'</a></li>";
						        str += "<li>-------------------------------------------------------------------------------</li>"
						    });
						    $('#searchResult').html(str +"\n");
						}
						
						// 실패 시 경고창을 띄워줍니다.
						function errFunc(e) {
						    alert("실패: " + e.status);
						}
						</script>
						
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<form id="searchFrm">
				            <label for="startNum">Select Page:</label>
				            <select id="startNum">
				            </select>
				            <br>
				            <br>
				        </form>
					</td>
				</tr>
				<tr>
					<td>
						<div class="row" id="searchResult"></div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<hr>
<%@ include file="/include/f.jsp" %>