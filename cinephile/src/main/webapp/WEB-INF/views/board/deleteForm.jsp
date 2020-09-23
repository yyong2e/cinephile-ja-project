<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function chk() {
		if (frm.c_id.value != frm.c_id.value) {
			alert("글쓴이가 아닙니다");			
			return false;
		}
	}
	function cancel() {
        history.back();
    }
</script>
</head>
<body>
<div class="container">
	<form action="${path}/delete" name="frm" onsubmit="return chk()">
		<input type="hidden" name="b_type" value="${board.b_type }">
		<input type="hidden" name="b_num" value="${board.b_num }">
		<input type="hidden" name="c_id2" value="${board.c_id}">
		<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="table table-bordered">
				<tr><th colspan="2">정말로 삭제하시겠습니까?</th><tr>
				<tr><th colspan="2">
				<input type="submit" value="확인">
    			<input type="button" onclick="cancel()" value="취소">
			</table>
	</form>
</div>
</body>
</html>