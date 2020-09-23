<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		$('#rbdListDisp').load('${path}/replyList/bno/${board.b_num}');
		$('#rInsert').click(function() {
			var sendData = $('#frm').serialize();
			$.post('${path}/rInsert', sendData, function(data) {
				alert('댓글이 작성 되었습니다');
				$('#rbdListDisp').html(data);
				frm.replytext.value = "";
			});
		});
	});
	
</script>
</head>
<body>
	<div class="container" align="center">
		<table class="table table-hover">
			<caption class="text-primary">게시글 상세 내역</caption>
			<tr>
				<th align="left">${board.b_type }게시판&nbsp / &nbsp 영화 : ${board.b_category} &nbsp / &nbsp 게시글제목 : ${board.b_subject }</th>
				<c:if test="${empty c_id}">
					<th align="right">추천은 로그인후 사용 가능합니다.</th>
				</c:if>
				<c:if test="${ not empty c_id }">
					<c:if test="${ck=='n' }">
					<th align="right">게시글 좋아요 : ${board.b_good }
						<div class="btn btn-warning" onclick="location.href='${path}/boardGood?b_num=${board.b_num}&pageNum=${pageNum }&ck=${ck }'">
						<img alt="" src="${path}/img/heartoff.png" width="20" height="20"><!-- </button> --></div></th>
					</c:if>
					<c:if test="${ck=='y' }">
					<th align="right">게시글 좋아요 : ${board.b_good }
						<div class="btn btn-warning" onclick="location.href='${path}/boardGood?b_num=${board.b_num}&pageNum=${pageNum }&ck=${ck }'">
						<img alt="" src="${path}/img/hearton.png" width="20" height="20"><!-- </button> --></div></th>
					</c:if>
				</c:if>
			</tr>
			<tr>
				<th align="left">작성자 : ${board.c_id }
				<td align="right">작성일 : ${board.b_regdate} &nbsp 조회수 : ${board.b_readcount }</td>
			</tr>
			<tr>
				<th>내용</th>
			</tr>
			<tr>
				<td>${board.b_content }</td>
			</tr>
			<c:if test="${not empty c_id && board.c_id == c_id }">
				<tr>
					<td colspan="2"><a href="${path}/list/b_type/${board.b_type}/pageNum/${pageNum}" class="btn btn-info">게시글 목록</a> 
									<a href="${path}/updateForm/b_num/${board.b_num}/pageNum/${pageNum}" class="btn btn-warning">수정</a> 
									<a href="${path}/deleteForm/b_num/${board.b_num}/pageNum/${pageNum}" class="btn btn-danger">삭제</a></td>
				</tr>
			</c:if>
		</table>
		<c:if test="${not empty c_id }">
			<form action="" name="frm" id="frm">
				<input type="hidden" name="bno" value="${board.b_num}">
				<table class="table table-hover">
					<caption>댓글 작성</caption>
					<!-- 회원 게시글인 경우는 작성자는 로그인 한 사람의 이름 또는 id -->
					<tr>
						<td>작성자</td>
						<td><input type="text" name="replyer" value="${c_id}"
							size="4" readonly="readonly"></td>
						<td>댓글</td>
						<td><textarea rows="3" cols="30" name="replytext"
								maxlength="100"></textarea></td>
						<td><input type="button" value="댓글입력" id="rInsert"></td>
					</tr>
				</table>
			</form>
			<div id="rbdListDisp"></div>
		</c:if>
		<c:if test="${empty c_id }">
			<h5>로그인 후에 댓글 내용을 확인할 수 있습니다.</h5>
		</c:if>
	</div>
</body>
</html>

