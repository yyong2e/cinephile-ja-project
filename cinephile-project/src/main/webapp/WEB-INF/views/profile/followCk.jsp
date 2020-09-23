<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${not empty cusList }">
	<c:forEach items="${cusList}" var="cus">
		<img alt="" src="img/proimg/${cus.c_proimg }" width="100" height="100"><a href="profileOther?c_id=${cus.c_id }">${cus.c_nickname }</a>
	</c:forEach>
</c:if>
</body>
</html>