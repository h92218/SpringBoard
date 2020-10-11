<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>
</head>
<script type="text/javascript">

	$j(document).ready(function(){
		
		$j("#submit").on("click",function(){
			var $frm = $j('.boardModify :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/boardModifyAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("수정완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("수정실패");
			    	

			    }
			});
		});
	});
	

</script>
<body>
<form class="boardModify">
	<table align="center">
		<tr>
			<td align="right">
			<input id="submit" type="button" value="수정완료">
			</td>
		</tr>
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
						<input type="hidden" name="boardNum" value="${board.boardNum}">
						<input type="hidden" name="boardType" value="${board.boardType}">
						<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment
						</td>
						<td valign="top">
						<textarea name="boardComment"  rows="20" cols="55">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${userName} <input type="hidden" name="creator" value="${board.creator}">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form>	
</body>
</html>