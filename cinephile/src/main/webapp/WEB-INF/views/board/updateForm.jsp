<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html><html><head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head><body>
	<div class="container">
		<form action="${path}/update" method="post" name="frm" >
			<input type="hidden" name="b_num" value="${board.b_num}"> 
			<input type="hidden" name="pageNum" value="${pageNum}"> 
			<%-- <input type="hidden" name="password2" value="${board.password}"> --%>
			<table class="table table-bordered">
				<caption>게시글 수정</caption>
					<tr><td>게시판종류</td>
				<td>${board.b_type } --> <select name="b_type">
				<c:if test="${board.b_type=='reviewboard'}">
					<option value="reviewboard" selected="selected">리뷰게시판</option>
				</c:if>
				<c:if test="${board.b_type=='mvinfoboard'}">
					<option value="mvinfoboard" selected="selected">영화정보게시판</option>
				</c:if>
				<c:if test="${board.b_type=='freeboard'}">
					<option value="freeboard" selected="selected">자유게시판</option>
				</c:if>
					<option value="리뷰">리뷰게시판</option>
					<option value="영화정보">영화정보게시판</option>
					<option value="자유">자유게시판</option>
				</select></td></tr>
				
				<tr><td>카테고리</td>
				<td>${board.b_category } --> <select name="b_category">
				<c:if test="${board.b_category=='ed'}">
					<option value="ed" selected="selected">상영종료</option>
				</c:if>
				<c:if test="${board.b_category=='ing'}">
					<option value="ing" selected="selected">상영중</option>
				</c:if>
				<c:if test="${board.b_category=='will'}">
					<option value="will" selected="selected">개봉예정</option>
				</c:if>
					<option value="상영종료">상영종료</option>
					<option value="상영중">상영중</option>
					<option value="개봉예정">개봉예정</option>
				</select></td></tr>
				
				<tr><td>제목</td><td><input type="text" name="b_subject" required="required" autofocus="autofocus" value="${board.b_subject }"></td></tr>
				<tr><td>내용</td><td><textarea rows="5" cols="40" name="b_content"required="required" >${board.b_content }</textarea></td></tr>
				<tr><td colspan="2"><input type="submit" value="수정"></td></tr>
			</table>
		</form>
	</div>
</body>
</html>