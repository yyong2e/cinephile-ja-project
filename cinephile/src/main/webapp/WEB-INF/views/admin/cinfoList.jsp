<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>::관리자 회원 목록::</title>

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section spad set-bg"
	data-setbg="${path}/webapp/img/breadcrumb-bg.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-text">
					<h4>회원 관리</h4>
					<div class="bt-option">
						<a href="./adMain"><i class="fa fa-home"></i> Main</a> <span>Customer
							List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Breadcrumb Section End -->


<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap"
	rel="stylesheet">
</head>
<body>


	<!--WRAP-->
	<div class="container">
		
		<div class="col-lg-12">

			<div class="row">
				<div class="col-lg-6">
					<div class="pd-title">
						<%-- <c:set var="admin" value="${sessionScope.c_id }" />
						<c:if test="${not empty admin }">
							<h4>접속자: ${admin }</h4>
						</c:if> --%>

					</div>
				</div>
				<!-- 이부분에 붙일 내용있으면 div col-lg-6으로 붙이기 -->
			</div>



					<div class="property-comparison-section spad-2">
						<div class="container">
							<div class="row">
								<div class="col-lg-12">
									<div class="pc-table">
				<%-- 					<c:set var="num" value="${no }" /> --%>
										<table>
											<thead>
												<tr>
													<th >번호</th>
													<th >유저ID</th>
													<th >이름</th>
													<th >닉네임</th>
													<th >주소</th>
													<th >전화번호</th>
													<th >이메일</th>
													<th >가입날짜</th>
													<th >탈퇴여부</th>

												</tr>
											</thead>
											<tbody>
												<c:forEach items="${customerList }" var="customer">
													<tr>
														<td>${customer.rn }</td>
														<td><a href="cinfoDetail.html?c_id=${customer.c_id }">${customer.c_id}</a></td>
														<td class="#">${customer.c_name }</td>
														<td>${customer.c_nickname }</td>
														<td class="#">${customer.c_address }</td>
														<td>${customer.c_tel }</td>
														<td class="#">${customer.c_email}</td>
														<td>${customer.c_regdate}</td>
														<td class="#">${customer.c_del }</td>
													</tr>
													<%-- <c:set var="num" value="${num -1 }" /> --%>
												</c:forEach>
											</tbody>
										</table>
									</div>
									
											<!--페이징-->
					<div class="blog-pagination property-pagination ">
                       <c:if test="${pb.startPage > pb.pagePerBlock }">
                       <a href="cinfoList?start=${pb.startPage - 10 }" class="icon"><span class="arrow_left"></span></a>
                       </c:if>
                        <c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
							<c:if test="${i == pb.currentPage }">
								<a href="cinfoList?start=${i }">${i }</a>
							</c:if>
							<c:if test="${i!=pb.currentPage }">
							<a href="cinfoList?start=${i }">${i }</a>
							</c:if>
						</c:forEach>
						<c:if test="${pb.endPage < pb.totalPage }">
                        <a href="cinfoList?start=${pb.endPage + 1}" class="icon"><span class="arrow_right"></span></a>
                   </c:if>
                    </div>
					<!--/페이징-->
									
								</div>
							</div>
						</div>
					</div>




			
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>