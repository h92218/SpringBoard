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
	<form id="LoginForm">
		<table align="center">
			<tr>
			<td>
				<table id="LoginTable" border="1" >
					<tr>
						<td width="50px">ID</td>
						<td><input type="text" name="userId" id="userId" autocomplete="off"></td>
					</tr>
					<tr>
						<td>PW</td>
						<td><input type="password" name="userPw" id="userPw"></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
			<td align="right">
				<input type="button" id="loginSubmit" value="login">
			</td>
			</tr>
		</table>
	</form>
</body>
<script>

$j("#loginSubmit").on("click",function(){
	
	var $frm = $j('#LoginForm :input');
	var param = $frm.serialize();
	
	
	if($j('#userId').val()==''){
		alert("아이디를 입력하세요");
		$j('#userId').focus();
		return false;
	}
	
	if($j('#userPw').val()==''){
		alert("비밀번호를 입력하세요");
		$j('#userPw').focus();
		return false;
	}
	
	else{
	$j.ajax({
	    url : "/board/LoginAction.do",
	    dataType: "json",
	    type: "POST",
	    data : param,
	    success: function(data)
	    {
	    	if(data.result=="존재하지 않는 ID" || data.result=="비밀번호가 틀렸습니다"){
	    		alert(data.result);
				location.href = "/board/LoginForm.do";
	    	}else{
	    		alert(data.result);
	    		location.href = "/board/boardList.do";
	    	}
			
	    },
	    error: function ()
	    {
	    	alert("로그인 실패하였습니다");
	    	

	    }
	});
	
	}
});

</script>
</html>