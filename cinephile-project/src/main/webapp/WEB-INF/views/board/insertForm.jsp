<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<form action="${path}/insert" method="post" name="frm">
			<input type="hidden" name="b_del" value="${b_del}"> 
			<input type="hidden" name="pageNum" value="${pageNum}">
			<table class="table table-bordered">
				<caption>게시글 입력</caption>
				<tr>
					<td>게시판종류</td>
					<td><select name="b_type">
							<option value="리뷰" selected="selected">리뷰게시판</option>
							<option value="영화정보">영화정보게시판</option>
							<option value="자유">자유게시판</option>
							<c:if test="${board.c_id=='master'}">
								<option value="공지" >공지게시판</option>
							</c:if>
					</select></td>
				</tr>

				<tr>
					<td>카테고리</td>
					<td><select name="b_category">
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
					</select></td>
				</tr>

				<tr>
					<td>제목</td>
					<td><input type="text" name="b_subject" required="required"
						autofocus="autofocus"></td>
				</tr>
				<tr>
					<td>내용</td>
					<td><textarea rows="5" cols="40" name="b_content"
							required="required"></textarea></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="작성"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>