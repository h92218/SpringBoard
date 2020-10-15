<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>

</head>
<script type="text/javascript">

</script>
<body>
	<table align="center">

		<tr>
			<td align="right">
			<div style="text-align:left;width:50%;float:left;">
				<c:if test="${userId==null}">
					<a href="/board/LoginForm.do">login</a>
					<a href="/board/boardJoin.do">join</a> 
				</c:if>
				<c:if test="${userId!=null}">
					[${userName}]님 로그인
				</c:if> 
				</div>
		<div style="width:50%;float:right;">total : ${totalCnt}</div>
		
			</td>

		</tr>
		<tr>
			<td>
				<table id="boardTable" border="1">
					<tr>
						<td width="80" align="center">Type</td>
						<td width="40" align="center">No</td>
						<td width="300" align="center">Title</td>
					</tr>
					<c:forEach items="${boardList}" var="list">
						<tr>
							<td align="center">${codeMap[list.boardType]}</td>
							<td>${list.boardNum}</td>
							<td><a
								href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
							</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
			<div style="width:50%;float:left;text-align:left;">
			<input type="button" onclick="location.href='/board/excelDown.do'" value="엑셀 다운로드" style="align:left;">
			</div>
			<div style="width:50%;float:right;">
			<a href="/board/boardWrite.do">글쓰기</a>	
			<c:if test="${userId!=null}">
			<a href="/board/Logout.do">로그아웃</a>
			</c:if> 
			</div>
			</td>
		</tr>
		<tr>
			<td>
				<input type="number" id="year" min="1970" max="2025">년
				<input type="number" id ="month" max="12" min="1" defaultvalue="1">월
				<input type="button" onclick="makeCalendar()" value="달력보기">
			</td>
		</tr>
		<tr>
			<td>
				<form action="boardList.do" class="boardTypeCheck"
					onsubmit="return beforeSubmit()">
					<input type="checkbox" name="boardType" id="checkall" value="">전체선택
					<c:forEach items="${codeList}" var="list">
						<input type="checkbox" name="boardType" class="checktype"
							value="${list.codeId}">${list.codeName}
		</c:forEach>
					<input type="submit" value="조회">
				</form>
			</td>
		</tr>
	</table>
	
	
	<input type="text" id="test">
	

	<input type="button" class="key" value="ㅂ" >
	<input type="button" class="key" value="ㅏ" >
	<input type="button" class="key" value="ㄱ" >


	
	<script>
	

$j('#checkall').click(function(){
	if($j('#checkall').is(':checked')){
		$j('.checktype').prop("checked",true);
	}else{
		$j('.checktype').prop("checked",false);
	}
		
});

$j('.checktype').click(function(){
	if($j('input[class=checktype]:checked').length==4){
		$j('#checkall').prop("checked",true);
	}else{
		$j('#checkall').prop("checked",false);
	}
});

function beforeSubmit(){
	var ch = $j('input:checked').val();
	if(ch==null){
		alert("체크 하세요");
		return false;
	}
			
}


//달력 년, 월 검색
function makeCalendar(){
	if($j('#year').val()<1970 || $j('#year').val()> 2025){
		alert("년도는 1970 ~2025 사이  입력");
		$j('#year').focus();
	}
	
	else if($j('#month').val()<1 || $j('#month').val()>12 ){
		alert("월은 1~12 사이 입력 ");
		$j('#year').focus();
	}
	
	else{
		location.href="/board/Calendar.do?req_year=" + $j('#year').val() + "&req_month="+$j('#month').val();
	}	
}



$j('.key').on("click",function(){
	var text=$j('#test').val(); // input란에 있는 값
	var lastchar = text.substring(text.length-1);
	alert("마지막 글자 : " + lastchar);
	var key=$j(this).val(); //버튼 값 

	$j('#test').val();
	$j('#test').focus();
	
});

//index
var chosung_index = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"];
var joongsung_index = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"];
var jongsung_index = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ","ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", 
      "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];

</script>

</body>
</html>