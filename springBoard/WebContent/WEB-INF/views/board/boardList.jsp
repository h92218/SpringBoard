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
				<div style="text-align: left; width: 50%; float: left;">
					<c:if test="${userId==null}">
						<a href="/board/LoginForm.do">login</a>
						<a href="/board/boardJoin.do">join</a>
					</c:if>
					<c:if test="${userId!=null}">
					[${userName}]님 로그인
				</c:if>
				</div>
				<div id="cntbox" style="text-align:right;width: 50%;">total : ${totalCnt}</div>
			</td>
		</tr>
		<tr>
			<td>
					
					<table id="boardTest" border="1">
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
				<div style="width: 50%; float: left; text-align: left;">
					<input type="button" onclick="location.href='/board/excelDown.do'"
						value="엑셀 다운로드" style="align: left;">
				</div>
				<div style="width: 50%; float: right;">
					<a href="/board/boardWrite.do">글쓰기</a>
					<c:if test="${userId!=null}">
						<a href="/board/Logout.do">로그아웃</a>
					</c:if>
				</div>
			</td>
		</tr>
		<tr>
			<td><input type="number" id="year" min="1970" max="2025">년
				<input type="number" id="month" max="12" min="1" defaultvalue="1">월
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
					<!--  <input type="submit" value="조회">-->
					<input type="button" id="search" value="조회">
				</form>
			</td>
		</tr>
	</table>


	<input type="text" id="test">
<br> 　
	<div>
		<input type="button" class="key" value="ㅃ"> 
		<input type="button" class="key" value="ㅉ"> 
		<input type="button" class="key" value="ㄸ"> 
		<input type="button" class="key" value="ㄲ"> 
		<input type="button" class="key" value="ㅆ">
		　　　　　　　　　　
		<input type="button" class="key" value="ㅒ"> 
		<input type="button" class="key" value="ㅖ"> 
		<input type="button" class="key" value="◀-"> 
		<br> 　
		<input type="button" class="key" value="ㅂ"> 
		<input type="button" class="key" value="ㅈ"> 
		<input type="button" class="key" value="ㄷ">
		<input type="button" class="key" value="ㄱ"> 
		<input type="button" class="key" value="ㅅ"> 
		　　　
		<input type="button" class="key" value="ㅛ"> 
		<input type="button" class="key" value="ㅕ"> 
		<input type="button" class="key" value="ㅑ">
		<input type="button" class="key" value="ㅐ"> 
		<input type="button" class="key" value="ㅔ"> 
		<br> 　　
		<input type="button" class="key" value="ㅁ"> 
		<input type="button" class="key" value="ㄴ"> 
		<input type="button" class="key" value="ㅇ"> 
		<input type="button" class="key" value="ㄹ">
		<input type="button" class="key" value="ㅎ"> 
		　
		<input type="button" class="key" value="ㅗ"> 
		<input type="button" class="key" value="ㅓ"> 
		<input type="button" class="key" value="ㅏ"> 
		<input type="button" class="key" value="ㅣ">
		<br> 　　　
		<input type="button" class="key" value="ㅋ"> 
		<input type="button" class="key" value="ㅌ"> 
		<input type="button" class="key" value="ㅊ"> 
		<input type="button" class="key" value="ㅍ"> 
		<input type="button" class="key" value=" space ">
		<input type="button" class="key" value="ㅠ"> 
		<input type="button" class="key" value="ㅜ"> 
		<input type="button" class="key" value="ㅡ">

	</div>
	<br>

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

  //게시판 글 조회 AJAX
$j("#search").on("click",function(){
	var ch = $j('input:checked').val();
	if(ch==null){
		alert("체크 하세요");
		return false;
	}
	
	
	var $frm = $j("input[class=checktype]:checked");
	var param = $frm.serialize();
	console.log(param);
	
	var table = document.getElementById('boardTest');
	
	 $j.ajax({
	    url : "/board/boardTypeList.do",
	    dataType: "json",
	    type: "POST",
	    data : param,

	    success: function(data)
	    {
	    	console.log(data.list.length)
	    	
	    	$j('#cntbox').html("total : " + data.totalCnt);
	    	//데이터를 새로 뿌리기 위해 이전 표를 지움 
	    	var trlength = $j('#boardTest tr').length;
	    	for(var t=trlength-1;t>0;t--){
	    		table.deleteRow(t);
	    	}
	    	//데이터 뿌리기 
	    	 for(var i=0;i<data.list.length;i++){
				$j('#boardTest').append("<tr><td align='center'>" + data.codeMap[data.list[i].boardType] + "</td>" +
											"<td>" + data.list[i].boardNum + "</td>" +
											"<td><a href= '/board/ " + data.list[i].boardType + "/" + data.list[i].boardNum
											+ "/boardView.do?pageNo=1'>"+data.list[i].boardTitle+ "</td>"); 
										
	    	} 
	    },
	    error: function ()
	    {
	    	alert("검색실패");
	    	
	    }
	}); 
});    




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



var JM = function(char_uni){ // 글자가 자음인가 모음인가? 
	if(char_uni >= 12593 && char_uni <= 12622){
		return "J";
	}else if(char_uni >= 12623 && char_uni <= 12643){
		return "M";
	}else{
		return "";
	}
}

$j('.key').on("click",function(){
	
	//버튼 입력 값 
	var key=$j(this).val(); 
	
	//합쳐서 나올 값
	var hangeul="";
	
	// input란에 있는 값
	var text=$j('#test').val(); 
	
	
	//input란에 있는 마지막 문자
	var lasttext = text.substring(text.length-1);
	
	
	if(key==" space "){
		key=" ";
		$j('#test').val(text+key);
		$j('#test').focus();
	}
	
	else if(key=="◀-"){
		text=text.substring(0,text.length-1);
		$j('#test').val(text);
		$j('#test').focus();
	}
	else{
	if(lasttext!=""){//마지막 문자가 공백이 아닐 경우만 실행 

		//마지막 문자의 유니코드 
		var lasttext_uni=lasttext.charCodeAt(0);
	
		//1. 마지막 글자의 초성,중성,종성과 인덱스 구하기
		var chosung;
		var joongsung;
		var jongsung;
		
		var jong_idx;
		var joong_idx;
		var cho_idx;
		
		//마지막 문자가 하나의 자음만 있는 경우 
		if(JM(lasttext_uni)=="J"){
			chosung=lasttext;
			joongsung="";
			jongsung="";
		
		//마지막 문자가 하나의 모음만 있는 경우 
		}else if(JM(lasttext_uni)=="M"){
			chosung="";
			joongsung=lasttext;
			jongsung="";
			
		}else{//마지막 문자가 하나의 자음이나 모음이 아닌경우 

			//마지막 문자에서 AC00을 뺀다
			var lastchar_uni_cal = lasttext_uni-44032; 
	
			//마지막 문자의 초성, 중성, 종성의 인덱스 구하기 
			//한글음절위치 = ((초성index * 21) + 중성index) * 28 + 종성index
			jong_idx = lastchar_uni_cal % 28;
			joong_idx = (Math.floor(lastchar_uni_cal/28)) % 21;
			cho_idx = Math.floor((Math.floor(lastchar_uni_cal / 28)) / 21);
	
			//마지막 문자의 초성, 중성, 종성 구하기 
			chosung = chosung_index[cho_idx];
			joongsung = joongsung_index[joong_idx];
			jongsung = jongsung_index[jong_idx];
		
			

	
		}//마지막 문자가 하나의 자음이나 모음이 아닌경우  초,중,종 구하기 끝 
		
		console.log("마지막문자 :  " + lasttext);
		console.log("마지막 문자의 초성,index : " + chosung + cho_idx);
		console.log("마지막 문자의 중성,index : " + joongsung + joong_idx);
		console.log("마지막 문자의 종성,index : " + jongsung + jong_idx);
		//2. 방금 친 글자 모음인지 자음인지 구별 
		var key_jm = JM(key.charCodeAt(0));
		console.log("방금 친 글자 : " + key +  " / 자음모음 : " + key_jm);
	
		var str_uni;
		var key_idx;
		
		//3. 글자 재조합
		
		//앞에 자음만 있는 경우 + 자음
		if(lasttext==chosung&&key_jm=="J"){
			console.log("앞에 자음만 있는 경우 + 자음");
			var newja = chosung+key;
			
			//앞자음 + 뒷자음 = 콤보인경우
			if(Jcombo.indexOf(newja)!=-1){
				newja = Jcombo_index[Jcombo.indexOf(newja)];
					
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+newja);
				$j('#test').focus();
			
			//앞자음+ 뒷자음 = 콤보 아님 	
			}else{
				$j('#test').val(text+key);
				$j('#test').focus();
			}
			

		//앞에 자음만 있는경우 + 모음 
		}else if(lasttext==chosung&&key_jm=="M"){
			console.log("앞에 자음만 있는 경우 + 모음");
			key_idx = joongsung_index.indexOf(key);
			//앞 자음이 콤보인경우
			if(Jcombo_index.indexOf(lasttext)!= -1){
				var newja = Jcombo[Jcombo_index.indexOf(lasttext)];
				var newja1 = newja.substring(0,1);
				var newja2 = newja.substring(1,newja.length);
				console.log("앞 자음의 콤보 쪼개기 : " + newja1 + ", " + newja2);
				
				var newja2_idx = chosung_index.indexOf(newja2);
				
				var str_uni =( (newja2_idx*21) + key_idx ) * 28  + 44032;
				var str=String.fromCharCode(str_uni);
				
				hangeul = newja1+str;
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();	

			
			}else{//앞 자음이 콤보가 아닌 경우 ex) ㄱ + ㅏ  가 
				cho_idx = chosung_index.indexOf(chosung);
				var str_uni =( (cho_idx*21) + key_idx ) * 28  + 44032;
				
				var hangeul=String.fromCharCode(str_uni);
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();	
				
			}
				
		//앞에 모음만 있는 경우 + 자음
		}else if(lasttext==joongsung&&key_jm=="J"){
			console.log("앞에 모음만 있는 경우 + 자음");
	
			$j('#test').val(text+key);
			$j('#test').focus();	
		
		//앞에 모음만 있는 경우 + 모음 
		}else if(lasttext==joongsung&&key_jm=="M"){
			console.log("앞에 모음만 있는 경우 + 모음 ");
			var newchar = lasttext+key;
			
			//모음이 콤보인 경우
			if(Mcombo.indexOf(newchar)!=-1){
				newchar = Mcombo_index[Mcombo.indexOf(newchar)];
				
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+newchar);
				$j('#test').focus();	
				
			//모음이 콤보 아닌 경우
			}else{
		
				$j('#test').val(text+key);
				$j('#test').focus();
				
			}
			
			
			
			
		//3-1 이전글자 종성이 있는경우 + 자음
		}else if(jongsung!="" && key_jm=="J"){
			console.log("이전글자 종성이 있는 경우 + 자음");
			var newjong_idx = Jcombo.indexOf(jongsung+key);
			console.log(newjong_idx);
	
			//이전글자 종성 + 입력한 자음이 Combo에 있는 경우ex) 갈+ㄱ = 갉 
			if(newjong_idx!=-1){
				newjong=Jcombo_index[newjong_idx];
				newjong_idx=jongsung_index.indexOf(newjong);
				
				str_uni = ((cho_idx * 21) + joong_idx) * 28 + newjong_idx + 44032;
				hangeul= String.fromCharCode(str_uni);
				console.log("새로 조합한 문자 : " + hangeul);
				
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();	
			
			//이전글자 종성 + 입력한 자음이 Combo에 없는 경우  ex) 각+ㅇ =각ㅇ
			}else{
				$j('#test').val(text+key);
				$j('#test').focus();			
			}
			
				

		//3-2 이전글자 종성이 있는 경우 + 모음  ex) 강 + ㅏ  = 가아   값 + ㅏ + 갑 사
		}else if(jongsung!="" && key_jm=="M"){ 
			console.log("이전글자 종성이 있는경우 + 모음");
			var newjong_idx = Jcombo_index.indexOf(jongsung);
			key_idx=joongsung_index.indexOf(key);
			
			//종성이 콤보인경우			
			if(newjong_idx!=-1){
				var newjong = Jcombo[newjong_idx];
				var newjong1 = newjong.substring(0,1);
				var newjong2 = newjong.substring(1,newjong.length);
				
				var newjong1_idx = jongsung_index.indexOf(newjong1);
				var newjong2_idx = chosung_index.indexOf(newjong2);
				
				var str_uni1 =( (cho_idx*21) + joong_idx ) * 28 + newjong1_idx + 44032;
				var str_uni2 = ((newjong2_idx * 21) + key_idx ) * 28 + 44032;

				
				hangeul = String.fromCharCode(str_uni1) + String.fromCharCode(str_uni2);
				console.log("새로 조합한 문자 : " + hangeul);
				
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();	
				
			
				//종성이 콤보가 아닌경우 ex 강+ㅏ  가 아 
			}else{
				var newcho_idx = chosung_index.indexOf(jongsung);

				var str_uni1 =( (cho_idx*21) + joong_idx ) * 28 + 44032;
				var str_uni2 =( (newcho_idx*21) + key_idx ) * 28 + 44032;
				console.log(jong_idx);
				
				hangeul = String.fromCharCode(str_uni1) + String.fromCharCode(str_uni2);
				console.log("새로 조합한 문자 : " + hangeul);
				
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();				
				
			}
			
			
			
		//3-3 이전글자 종성이 없는 경우 + 자음 ex) 가 + ㅇ = 강, 가 + ㅉ = 가ㅉ
		}else if(jongsung=="" && key_jm=="J"){
			console.log("이전글자 종성이 없는 경우 + 자음");
			key_idx = jongsung_index.indexOf(key);
			
			//입력한 자음이 받침이 될 수 있는 경우
			if(key_idx!=-1){
			str_uni = ( (cho_idx*21)+joong_idx ) * 28 +key_idx + 44032;
			hangeul = String.fromCharCode(str_uni);
			
			console.log("새로 조합한 문자 : " + hangeul);
			
			text=text.substring(0,text.length-1);		
			$j('#test').val(text+hangeul);
			$j('#test').focus();	
			
			//입력한 자음이 받침이 될 수 없는 경우 
			}else{
				$j('#test').val(text+key);
				$j('#test').focus();
			}
			
		//3-4 이전글자 종성이 없는 경우 + 모음
		}else if(jongsung=="" && key_jm=="M"){
			console.log("이전글자 종성이 없는 경우 + 모음");
			var mcom = joongsung+key; // ㅜㅣ
			var mcom_idx = Mcombo.indexOf(mcom);	

			//이전글자 모음(중성) + 친 글자(모음) = 콤보인경우 ex. 구 + ㅣ = 귀
			 if(mcom_idx!=-1){

				mcom=Mcombo_index[mcom_idx];
				mcom_idx=joongsung_index.indexOf(mcom);
				str_uni = ((cho_idx*21 )  + mcom_idx ) * 28 + 44032;			 
				hangeul = String.fromCharCode(str_uni);
				console.log("새로 조합한 문자 : " + hangeul);
					
				text=text.substring(0,text.length-1);		
				$j('#test').val(text+hangeul);
				$j('#test').focus();	
				 
				//이전글자 모음(중성) + 친글자(모음) 콤보 아닌경우 ex.구 + ㅏ = 구ㅏ
			 }else{
				 console.log("이전글자 모음 + 친글자 모음 ");
				$j('#test').val(text+key);
				$j('#test').focus();
			 }
				
		}
		

	}//마지막 문자가 공백이 아닌경우 끝 
	
	else{//마지막 문자가 공백이면 
		//input란에  바로 출력
		$j('#test').val(text+key);
		$j('#test').focus();
	}
}

	
});

//index
var chosung_index = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ","ㄹ","ㅁ","ㅂ","ㅃ","ㅅ","ㅆ","ㅇ","ㅈ","ㅉ","ㅊ","ㅋ","ㅌ","ㅍ","ㅎ"]; //19개
var joongsung_index = ["ㅏ","ㅐ","ㅑ","ㅒ","ㅓ","ㅔ","ㅕ","ㅖ","ㅗ","ㅘ","ㅙ","ㅚ","ㅛ","ㅜ","ㅝ","ㅞ","ㅟ","ㅠ","ㅡ","ㅢ","ㅣ"]; //22개
var jongsung_index = ["", "ㄱ", "ㄲ", "ㄳ", "ㄴ", "ㄵ", "ㄶ", "ㄷ", "ㄹ","ㄺ", "ㄻ", "ㄼ", "ㄽ", "ㄾ", "ㄿ", "ㅀ", "ㅁ", //28개
      "ㅂ", "ㅄ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"];
      
var Jcombo_index=["ㄳ","ㄵ","ㄶ","ㄺ","ㄻ","ㄼ","ㄽ","ㄾ","ㄿ","ㅀ","ㅄ"]; //11개 
var Jcombo=["ㄱㅅ","ㄴㅈ","ㄴㅎ","ㄹㄱ","ㄹㅁ","ㄹㅂ","ㄹㅅ","ㄹㅌ","ㄹㅍ","ㄹㅎ","ㅂㅅ"];
var Mcombo_index =['ㅘ','ㅙ','ㅚ','ㅝ','ㅞ','ㅟ','ㅢ']; //7개 
var Mcombo=['ㅗㅏ','ㅗㅐ','ㅗㅣ','ㅜㅓ','ㅜㅔ','ㅜㅣ','ㅡㅣ'];

</script>

</body>
</html>