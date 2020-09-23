<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="nowid" value="${sessionScope.c_id }"/>
</head>
<body>
<c:if test="${result > 0 }">
<script type="text/javascript">
	alert("수정 완료입니다.");
	location.href="main";
</script>
</c:if>

<c:if test="${result == -1 }">
	<script type="text/javascript">
	alert("현재 비밀번호가 틀렸거나, 닉네임이 중복됩니다. 다시 입력해주세요.");
	history.go(-1);
	</script>
</c:if>
</body>
</html>