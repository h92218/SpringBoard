<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="joinForm" >
		<table align="center">
			<tr>
				<td>List</td>	
			</tr>
			<tr>
				<td>
					<table border="1" width="450px">
						<tr>
							<td>id</td>
							<td><input type="text" id="userId" name="userId" maxlength="15">
								<input type="button" value="중복확인" id="confirmId">
							</td>
						</tr>

						<tr>
							<td>pw</td>
							<td><input type="password" id="pw" name="userPw" class="pwpw" maxlength="12">
								<span id="pwMessage"></span>
							</td>
						</tr>

						<tr>
							<td>pw check</td>
							<td><input type="password" id="pwcheck" class="pwpw" maxlength="12">
								<span id="pwCheckMessage"></span>
							</td>
						</tr>

						<tr>
							<td>name</td>
							<td><input type="text" id="userName" name="userName" maxlength="6"></td>
						</tr>

						<tr>
							<td>phone</td>
							<td>
								<select name="userPhone1" id="userPhone1">
								<c:forEach items="${codeList}" var="list">
								<option value="${list.codeId}">${list.codeName}</option>
								</c:forEach>								
							</select>
							-<input type="text" name="userPhone2" size="3" maxlength="4" id="userPhone2" class="phone">
							-<input type="text" name="userPhone3" size="3" maxlength="4" id="userPhone3" class="phone">
							<span id="phoneMessage"></span>
							</td>
						</tr>

						<tr>
							<td>postNo</td>
							<td><input type="text" id="postNo" name="userAddr1" placeholder="xxx-xxx" maxlength="7">
								<span id="postNoMessage"></span>
							
							</td>
						</tr>

						<tr>
							<td>address</td>
							<td><input type="text" id="userAddr2" name="userAddr2" maxlength="75"><span id="userAddr2Byte"></span></td>
							
						</tr>

						<tr>
							<td>company</td>
							<td><input type="text" id="userCompany" name="userCompany" maxlength="30"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
				<input id="submit" type="button" value="join">
				</td>
			</tr>
		</table>
	</form>
<script>
//아이디 형식 체크(영문,숫자만 사용)

	$j('#userId').keyup(function() {
			  var inputVal = $j(this).val();
			  $j(this).val((inputVal.replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:;.`/\-\\\"\'{}= ]/g,'')));
	
	});

	//아이디 중복체크
	var checkedId = 0;
	var UserId="";
	$j('#confirmId').click(function() {
		if ($j('#userId').val() == '') {
			alert('아이디를 입력하세요');
			$j('#userId').focus();
		} else { //아이디 입력하고 중복 조회
			$j.ajax({
				url : "/board/checkId.do",
				dataType : "json",
				type : "POST",
				data : {
					userId : $j('#userId').val()
				},
				success : function(data) { //조회 성공인경우
					if (data.result == 'idAvailable') {
						alert("ID 사용 가능");
						UserId=$j('#userId').val();
						checkedId = 1;
					} else if (data.result == 'idNotAvailable') {
						alert("중복된 ID 입니다. 사용 불가능");
						checkedId = 0;
					} else {
						alert("아이디 중복체크 실패");
						checkedId = 0;
					}
				},
				error : function() { //조회 실패한 경우
					alert("아이디 조회 실패");
					checkedId = 0;
				}
			});
		}
	});

	//비밀번호 확인 일치 여부 체크
	var checkedpw = 0;
	var checklength = 0;

	$j('.pwpw')
			.keyup(
					function() {
						if ($j('#pw').val() == '' && $j('#pwcheck').val() == '') {
							$j('#pwCheckMessage').text('');
							$j('#pwMessage').text('');
							checkedpw = 0;
							checklength = 0;
						} else if (($j('#pw').val().length < 6)
								|| ($j('#pw').val().length > 12)) {
							$j('#pwMessage').css('color', 'red').text(
									'비밀번호는 6~12자');
							checkedpw = 0;
							checklength = 0;
						} else if ($j('#pwcheck') == '') {
							$j('#pwMessage').text('');
							checklength = 1;
							checkedpw = 0;
						} else if ($j('#pw').val() != $j('#pwcheck').val()) {
							$j('#pwMessage').text('');
							$j('#pwCheckMessage').css('color', 'red').text(
									'비밀번호가 일치하지 않음');
							checklength = 1;
							checkedpw = 0;
						} else {
							$j('#pwMessage').text('');
							$j('#pwCheckMessage').css('color', 'green').text(
									'비밀번호 일치');
							checkedpw = 1;
							checklength = 1;
						}
					});//비밀번호 확인란 입력시 끝
					
	//이름 한글만 체크

	$j('#userName').keyup(function() {
			  var inputVal = $j(this).val();
			  $j(this).val((inputVal.replace(/[[a-zA-Z0-9~!@#$%^&*()_+|<>?:;.`/\-\\\"\'{}= ]/g,'')));

	
	});
					
	//폰번호 형식체크 (숫자만, 4자리 )
	var phone1Check =0;
	var phone2Check =0;
	$j('.phone').keyup(function() {
		var inputVal = $j(this).val();
		$j(this).val((inputVal.replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:;.`/\-\\\"\'{}= a-zA-Z]/g,'')));
		
		if($j('#userPhone2').val().length!=4){
			$j('#phoneMessage').css('color', 'red').text("각 4자리의 숫자 입력");
			phone1Check=0;
			phone2Check=1;
		}else if($j('#userPhone3').val().length!=4){
			$j('#phoneMessage').css('color', 'red').text("각 4자리의 숫자 입력");
			phone1Check=1;
			phone2Check=0;
		}else{
			$j('#phoneMessage').text("");
			phone1Check=1;
			phone2Check=1;
		}
	
	});


	//POSTNO 양식 체크
	var postNoCheck = RegExp(/[0-9]{3}-[0-9]{3}/);
	var postChecked = 0;


	$j('#postNo').keyup(function() {
		
		var inputVal = $j(this).val();
		$j(this).val((inputVal.replace(/[ㄱ-힣~!@#$%^&*()_+|<>?:;.`/\\\"\'{}= a-zA-Z]/g,'')));
		
		//양식 체크
		if ($j('#postNo').val() == '') {
			$j('#postNoMessage').text("");
			postChecked = 0;
		} else if (!postNoCheck.test($j('#postNo').val())) {
			$j('#postNoMessage').css('color', 'red').text("형식에 맞지 않음");
			postChecked = 0;
		} else {
			$j('#postNoMessage').text("");
			postChecked = 1;
		}
		
		var postNoCheck3 = RegExp(/^\-[0-9]*/);
		if(event.keyCode==8 && postNoCheck3.test($j('#postNo').val())){
			$j('#postNo').val($j('#postNo').val().replace("-",""));
		}
		
	});

	var postNoCheck1 = RegExp(/^[0-9]{3}$/);
	var postNoCheck2 = RegExp(/-[0-9]$/);
	var postNoCheck3 = RegExp(/-/);
	//우편번호 - 자동추가 및 삭제 설정
	$j('#postNo').keydown(function() {
		
	
		// - 자동 추가
		 if(postNoCheck1.test($j('#postNo').val()) && event.keyCode !=8 && event.keyCode!=189){
			$j('#postNo').val($j('#postNo').val()+"-");
			}
		// - 자동 제거
		 if(event.keyCode==8 && postNoCheck2.test($j('#postNo').val())){
			$j('#postNo').val($j('#postNo').val().replace("-",""));
		} 
		
		//- 한 번 쓰면 못 씀 
		if(postNoCheck3.test($j('#postNo').val()) && event.keyCode ==189){
			return false;
		}
		
	});

	
	//주소 입력값  크기 체크
	var Hanguel = RegExp(/[ㄱ-힣]/);
	var addrbyte=0;
	$j('#userAddr2').keyup(function() {
		
		if($j('#userAddr2').val()==''){
			addrbyte=0;
		}else{
			addrbyte=0;
			for(var i=0; i<$j('#userAddr2').val().length;i++){
				if(Hanguel.test($j('#userAddr2').val().charAt(i))){
					addrbyte+=2;
				}else{
					addrbyte+=1;
				}
			}
	}
		
	});
	
	//회사 입력값 크기 체크
	$j('#userCompany').val()
	
	
	//제출전 양식 체크
	
	$j('#submit').on("click", function() {	

		if (checkedId == 0 || UserId!=$j('#userId').val()) { //아이디 중복확인 했는지 체크
			alert("아이디 중복체크 필요. ID는 필수항목");
			$j('#userId').focus();
			return false;
		}
		
		if (checklength == 0) { //비번 체크
			alert("비밀번호를 확인하세요.비밀번호는 필수항목");
			$j('#pw').focus();
			return false;
		} 
		
		if(checkedpw == 0){//비번 확인
			alert("비밀번호가 일치하지 않습니다.");
			$j('#pwcheck').focus();
			return false;
		}

		if ($j('#userName').val() == '') { //이름 체크
			alert("이름을 입력하세요. 이름은 필수항목");
			$j('#userName').focus();
			return false;
		}

		if (phone1Check == 0) { //폰번 체크
			alert("휴대폰번호를 확인하세요");
			$j('#userPhone2').focus();
			return false;
		}

		if(phone2Check == 0){//폰번 체크
			alert("휴대폰번호를 확인하세요");
			$j('#userPhone3').focus();
			return false;	
		}
		
		if(postChecked ==0 && $j('#postNo').val()!= ''){	
				alert("우편번호를 확인하세요");
				$j('#postNo').focus();
				return false;

		} else{
			var $frm = $j('#joinForm :input');
			var param = $frm.serialize();

			$j.ajax({
				url : "/board/boardJoinAction.do",
				dataType : "json",
				type : "POST",
				data : param,
				success : function(data) {
					alert(data.result);

					location.href = "/board/boardList.do";
				},
				error : function() {
					alert("가입 실패입니다");
				}
			});

		}

	});
</script>
</body>
</html>