<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardView</title>
</head>
<body>
<table align="center">
	<tr>
		<td>
			<table border ="1">
				<tr>
					<td align="center">
					Type
					</td>
					<td>
					${codeMap[board.boardType]}
					</td>
				</tr>
				<tr>
					<td width="120" align="center">
					Title
					</td>
					<td width="400">
					${board.boardTitle}
					</td>
				</tr>
				<tr>
					<td height="300" align="center">
					Comment
					</td>
					<td>
					${board.boardComment}
					</td>
				</tr>
				<tr>
					<td align="center">
					Writer
					</td>
					<td>
					${userName}
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a onclick="deleteConfirm()" style="cursor:pointer;text-decoration:underline;color:blue;">삭제하기</a>
			<a href="/board/boardModify.do?boardNum=${board.boardNum}&boardType=${board.boardType}">수정하기</a>
			<a href="/board/boardList.do">List</a>
		</td>
	</tr>
</table>	

<script>
function deleteConfirm(){
	
	if(confirm("삭제하시겠습니까?") == true){
		$j.ajax({
		    url : "/board/boardDelete.do",
		    dataType: "json",
		    type: "POST",
		    data : {boardNum:'${board.boardNum}',boardType:'${board.boardType}'},
		    success: function(data, textStatus, jqXHR)
		    {
				alert("삭제완료");
				
				alert("메세지:"+data.success);
				
				location.href = "/board/boardList.do";
		    },
		    error: function (jqXHR, textStatus, errorThrown)
		    {
		    	alert("삭제실패");
		    }
		});
		
		
	}else{
		return false;
	}
	
	
}



</script>
</body>
</html>