<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>boardWrite</title>

</head>
<script type="text/javascript">
	/* $j(document).ready(function(){
	
		$j("#submit").on("click",function(){
			
		 	var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			alert(param); 
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    traditional : true,
			 
			    success: function(data, textStatus, jqXHR)
			    {
					alert("작성완료");
					
					alert("메세지:"+data.success);
					
					location.href = "/board/boardList.do";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
		});
	});
 */

</script>
<body>
<form:form commandName="boardVo" class="boardWrite" action="/board/boardWriteAction.do">
	<table align="center">
		<tr>
			<td align="right">
			<input type="button" value="행추가" onclick="addRow()">
			<input type="submit" id="submit" value="작성">
			</td>
		</tr>
		<tr>
			<td>
				<table border ="1"> 
				<tbody id="boardTable">
					<tr>
						<td align="center">
						Type
						</td>
						<td>
							<select name="boardVoList[0].boardType" >
								<c:forEach items="${codeList}" var="list">
								<option value="${list.codeId}">${list.codeName}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td width="120" align="center">
						Title
						</td>
						<td width="400">
						<input name="boardVoList[0].boardTitle" type="text" size="50" maxlength="24"> 
						</td>
					</tr>
					<tr>
						<td height="300" align="center">
						Comment<br>
						</td>
						<td valign="top">
						<textarea name="boardVoList[0].boardComment"  rows="20" cols="55" id="boardComment0" maxlength="499">${board.boardComment}</textarea>
						</td>
					</tr>
					<tr>
						<td align="center"> 파일 첨부 </td>
						<td><input type="file" name="boardFile" id="boardFile"/>
						</td>
					</tr>
					<tr>
						<td align="center">
						Writer
						</td>
						<td>
						${userName}<input type="hidden" name="boardVoList[0].creator" value="${userId}">				
						</td>
					</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>
</form:form>	
<script>

//행 추가하기 
var rowCount=1;
function addRow(){
	var table = document.getElementById('boardTable');
	
	var rowType = table.insertRow(table.rows.length-1);
	var rowTitle = table.insertRow(table.rows.length-1);
	var rowComment = table.insertRow(table.rows.length-1);
	
	var cellType1 = rowType.insertCell(0);
	var cellType2 = rowType.insertCell(1);
	
	var cellTitle1 = rowTitle.insertCell(0);
	var cellTitle2 = rowTitle.insertCell(1);
	
	var cellComment1 = rowComment.insertCell(0);
	var cellComment2 = rowComment.insertCell(1);
	
	cellType1.style.cssText="text-align:center;"
	cellType1.innerHTML="Type";
	cellType2.innerHTML='<select name="boardVoList['+rowCount+'].boardType">'+
						'<c:forEach items="${codeList}" var="list">'+
						'<option value="${list.codeId}">${list.codeName}</option></c:forEach></select>';
	
	cellTitle1.style.cssText="text-align:center;"
	cellTitle1.innerHTML="Title";
	cellTitle2.innerHTML='<input name="boardVoList['+rowCount+'].boardTitle" type="text" size="50"  maxlength="24"> ';
	
	
	cellComment1.style.cssText="text-align:center;"
	cellComment1.innerHTML='Comment<br><input type="button" value="행 지우기"  onclick="deleteRow(this)">';
	cellComment2.innerHTML='<textarea name="boardVoList['+rowCount+'].boardComment"  rows="20" cols="55"  maxlength="499">${board.boardComment}</textarea>'+
							'<input type="hidden" name="boardVoList['+rowCount+'].creator" value="${userId}">';
	
	rowCount++;

}


//행 삭제하기
function deleteRow(obj){

 	/* alert($j(obj).parent().parent().index());
	alert(obj.parentNode.parentNode.rowIndex); */
	var tr=$j(obj).parent().parent();
	
	tr.prev().remove();
	tr.prev().remove();
	tr.remove();

}



</script>
</body>
</html>