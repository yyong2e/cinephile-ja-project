<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result >0 }">
		<script type="text/javascript">
			alert("수정되었습니다");
			location.href = "${path }/admovieList";
		</script>
	</c:if>
	<c:if test="${result ==0 }">
		<script type="text/javascript">
			alert("다시 수정해주십시오");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>