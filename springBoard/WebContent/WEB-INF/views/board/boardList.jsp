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
				<c:if test="${userId==null}">
					<a href="/board/LoginForm.do">login</a>
					<a href="/board/boardJoin.do">join</a> 
				</c:if>
				<c:if test="${userId!=null}">
					[${userName}]님 로그인
				</c:if> 
		total : ${totalCnt}</td>

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
			<td align="right"><a href="/board/boardWrite.do">글쓰기</a>
			<c:if test="${userId!=null}">
			<a href="/board/Logout.do">로그아웃</a>
			</c:if> 
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



</script>

</body>
</html>