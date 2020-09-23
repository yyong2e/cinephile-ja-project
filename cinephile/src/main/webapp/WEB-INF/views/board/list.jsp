<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>
	<h4 align="center">${board.b_type }게시판</h4>
	<div class="container" align="center">
		<c:set var="b_num" value="${no }"></c:set>
		<table class="table">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>작성자</th>
				<th>좋아요</th>
				<th>게시판</th>
				<c:if test="${board.b_type != '공지'}">
					<th>카테고리</th>
				</c:if>
			</tr>
			<c:if test="${empty list }">
				<tr>
					<th colspan="8">작성된 글이 없습니다</th>
				</tr>
			</c:if>
			<c:if test="${not empty list}">
				<c:if test="${board.b_type == '공지' }">
					<c:forEach var="board" items="${list}">
						<tr>
							<td>${board.b_num }</td>
							<td><a
								href="${path}/view/b_num/${board.b_num}/pageNum/${pb.currentPage}">${board.b_subject}</a></td>
							<td>${board.b_readcount }</td>
							<td>${board.b_regdate }</td>
							<td>${board.c_id }</td>
							<td>${board.b_good }</td>
							<td colspan="2">${board.b_type }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${board.b_type != '공지' }">
					<c:forEach var="board" items="${list}">
						<tr>
							<td>${board.b_num }</td>
							<td><a
								href="${path}/view/b_num/${board.b_num}/pageNum/${pb.currentPage}">${board.b_subject}</a></td>
							<td>${board.b_readcount }</td>
							<td>${board.b_regdate }</td>
							<td>${board.c_id }</td>
							<td>${board.b_good }</td>
							<td>${board.b_type }</td>
							<td colspan="2">${board.b_category }</td>
						</tr>
					</c:forEach>
				</c:if>
			</c:if>
		</table>
		<div align="center">
			<ul class="pagination">
				<c:if test="${pb.startPage > pb.pagePerBlock}">
					<li><a
						href="${path}/list/b_type/${b_type}/pageNum/1?search=${board.search}&keyword=${board.keyword}">
							<span class="glyphicon glyphicon-backward"></span>
					</a></li>
					<li><a
						href="${path}/list/b_type/${b_type}/pageNum/${pb.startPage - 1}?search=${board.search}&keyword=${board.keyword}">
							<span class="glyphicon glyphicon-triangle-left"></span>
					</a></li>
				</c:if>
				<c:forEach var="i" begin="${pb.startPage}" end="${pb.endPage }">
					<c:if test="${i==pb.currentPage}">
						<li class="active"><a
							href="${path}/list/b_type/${b_type}/pageNum/${i}?search=${board.search}&keyword=${board.keyword}">${i}</a></li>
					</c:if>
					<c:if test="${i!=pb.currentPage}">
						<li><a
							href="${path}/list/b_type/${b_type}/pageNum/${i}?search=${board.search}&keyword=${board.keyword}">${i}</a></li>
					</c:if>
				</c:forEach>
				<c:if test="${pb.endPage < pb.totalPage}">
					<li><a
						href="${path}/list/b_type/${b_type}/pageNum/${pb.endPage + 1}?search=${board.search}&keyword=${board.keyword}">
							<span class="glyphicon glyphicon-triangle-right"></span>
					</a></li>
					<li><a
						href="${path}/list/b_type/${b_type}/pageNum/${pb.totalPage}?search=${board.search}&keyword=${board.keyword}">
							<span class="glyphicon glyphicon-forward"></span>
					</a></li>
				</c:if>
			</ul>
		</div>
<%-- 		<form action="${path}/list/pageNum/1">
			<select name="search">
				<c:forTokens var="sh" items="c_id,b_subject,b_content,subcon" delims="," varStatus="i">
					<c:if test="${sh==board.search}">
						<option value="${sh}" selected="selected">${tit[i.index] }</option>
					</c:if>
					<c:if test="${sh!=board.search}">
						<option value="${sh}">${tit[i.index] }</option>
					</c:if>
				</c:forTokens>
			</select> 
			<input type="text" name="keyword" value="${board.keyword}">
			<input type="submit" value="검색">
		</form> --%>
		<c:choose>
			<c:when test="${empty c_id }">
				<h5>로그인 후에 글쓰기를 사용할 수 있습니다.</h5>
			</c:when>
			<c:when
				test="${not empty c_id && board.b_type=='리뷰' || board.b_type=='영화정보' || board.b_type=='자유'}">
				<a href="${path}/insertForm/nm/null/pageNum/1/b_type/${b_type}"
					class="btn btn-info">게시글 입력</a>
			</c:when>
			<c:when test="${board.c_id=='master' && board.b_type=='공지'}">
				<a href="${path}/insertForm/nm/null/pageNum/1/b_type/${b_type}"
					class="btn btn-info">게시글 입력</a>
			</c:when>
		</c:choose>
	</div>
</body>
</html>
