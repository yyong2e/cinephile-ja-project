<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Aler Template">
<meta name="keywords" content="Aler, unica, creative, html">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<title>시네필 통합검색</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap"
	rel="stylesheet">
<style type="text/css">
	.set-bg{
		width:210px;
	}
</style>
<script type="text/javascript">
	function fzGood(zip_num, c_id, ck) {
		$.post('f', 'zip_num=' + zip_num + '&c_id=' + c_id + '&ck=' + ck,
				function(data) {
					document.getElementById('fimg').src = "img/" + data;
					location.reload();
				});
	}
</script>

</head>

<body>

	<section class="blog-section spad">

		<div class="container">
			            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>영화정보</h4>
                    </div>
                </div>
            </div>
			<!-- 여기서부터 foreach적용 -->
			<c:if test="${empty mvList }">
				<div style="margin: 0 auto; width: 95%;">
					<h5>조회 된 내용이 없습니다</h5>
				</div>
			</c:if>
			<c:if test="${not empty mvList}">
				<c:forEach var="mvList" items="${mvList }" end="2">
					<div class="row">
						<div class="col-lg-12">
							<div class="blog-item-list">
								<div class="blog-item">
									<div class="bi-text">
										<div style="margin: 0 auto; width: 95%;">
											<div class="col-lg-3">
												<div class="about-pic set-bg" data-setbg="${mvList.mv_imageurl }" style="height: 300px;">
													<%-- <img alt="" src="${mvList.mv_imageurl }"> --%>
												</div>
											</div>
											<div style="position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);">
											<h5>
												<a href="movieInfo?mv_num=${mvList.mv_num }&mv_name=${mvList.mv_name}">${mvList.mv_name }</a>
											</h5>
											<ul>
												<li>감독 <span>${mvList.mv_direct }</span></li>
												<li>${mvList.mv_genre }</li>
												<li>좋아요 개수</li>
											</ul>
											<p>${mvList.mv_content }</p>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 					<div class="blog-pagination property-pagination ">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"
							class="icon">→</a>
					</div> -->
						</div>
					</div>
				</c:forEach>
				<div style="margin: 0 auto; width: 95%;">
					<a style="font-size: 14px; color: #111111; font-weight: 600; float: right;"
						href="searchMovieList?s_keyword=${s_keyword }" class="read-more">더보기 <i
						class="fa fa-arrow-right"></i></a>
				</div>
			</c:if>
			<!-- 여기까지 foreach적용 -->
			<div style="height: 80;"></div>
		</div>

<c:if test="${search == 'tag' }">
		    <!-- 모놀로그 Begin -->
    <section class="testimonial-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>모놀로그</h4>
                    </div>
                </div>
            </div>
            <div class="row testimonial-slider owl-carousel">
            	<c:if test="${not empty  moList}">
    			<c:forEach var="mono" items="${moList}" varStatus="status" >
    				<div class="col-lg-10">
                    <div class="testimonial-item">
                        <div class="ti-text">
                            <p>${mono.mo_content }</p>
                            <c:if test="${not empty mtagConList[status.index] }">
                            	<c:forEach var="tag" items="${mtagConList[status.index]}" varStatus="sta" >
                            		#${tag }
                            	</c:forEach>
                            </c:if>
                        </div>
                        <div class="ti-author">
                            <div class="ta-pic">
                                <img src="img/proimg/${moCusList[status.index].c_proimg }" alt="">
                            </div>
                            <div class="ta-text">
                                <a href="profileOther?c_id=${mono.c_id }"><h5>${moCusList[status.index].c_nickname }</h5></a>
                                <c:if test="${not empty nowid }">
                                	<c:if test="${'y' eq mogoodList[status.index]}">
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><i class="fa fa-heart"></i>${mono.mo_good }</div>
                              		</c:if>
                                	<c:if test="${'n' eq mogoodList[status.index]}">
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><i class="fa fa-heart-o"></i>${mono.mo_good }</div>
                              		</c:if>
                                </c:if>
                                <c:if test="${empty nowid }">
                                	<div class="btn btn-link"><img alt="" src="${path}/img/heartoff.png" width="1" height="40">${mono.mo_good }</div>
                                </c:if>
                                
                                <div class="ta-rating">
                                </div>
                            </div>
                            <div>
                            	<a href="">신고</a>
                            </div>
                        </div>
                    </div>
                	</div>
    			</c:forEach>
			</c:if>
            </div>
        </div>
    </section>
    <!-- Testimonial Section End -->
</c:if>		
		
		<div class="container">
			            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>리뷰 게시판</h4>
                    </div>
                </div>
            </div>
			<!-- 여기서부터 foreach적용 -->
			<c:if test="${empty rbList }">
				<div style="margin: 0 auto; width: 95%;">
					<h5>조회 된 내용이 없습니다 (게시글 제목으로 검색하세요)</h5>
				</div>
			</c:if>
			<c:if test="${not empty rbList}">
				<c:forEach var="rbList" items="${rbList }" end="2">
					<div class="row">
						<div class="col-lg-12">
							<div class="blog-item-list">
								<div class="blog-item">
									<div class="bi-text">
										<div style="margin: 0 auto; width: 95%;">
											<h5>
												<a href="${path }/view/b_num/${rbList.b_num}/pageNum/1">${rbList.b_subject }</a>
											</h5>
											<ul>
												<li>작성자 <span>${rbList.c_id }</span></li>
												<li>${rbList.b_regdate }</li>
												<li>좋아요 개수 <span>${rbList.b_good }</span></li>
											</ul>
											<p>${rbList.b_content }</p>
										</div>
									</div>
								</div>
							</div>
							<!-- 					<div class="blog-pagination property-pagination ">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"
							class="icon">→</a>
					</div> -->
						</div>
					</div>
				</c:forEach>
				<div style="margin: 0 auto; width: 95%;">
					<a
						style="font-size: 14px; color: #111111; font-weight: 600; float: right;"
						href="${path}/list/b_type/리뷰/pageNum/1" class="read-more">더보기 <i
						class="fa fa-arrow-right"></i></a>
				</div>
			</c:if>
			<!-- 여기까지 foreach적용 -->
			<div style="height: 80;"></div>
		</div>
		
		<div class="container">
			            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>영화정보게시판</h4>
                    </div>
                </div>
            </div>
			<!-- 여기서부터 foreach적용 -->
			<c:if test="${empty ibList }">
				<div style="margin: 0 auto; width: 95%;">
					<h5>조회 된 내용이 없습니다 (게시글 제목으로 검색하세요)</h5>
				</div>
			</c:if>
			<c:if test="${not empty ibList}">
				<c:forEach var="ibList" items="${ibList }" end="2">
					<div class="row">
						<div class="col-lg-12">
							<div class="blog-item-list">
								<div class="blog-item">
									<div class="bi-text">
										<div style="margin: 0 auto; width: 95%;">
											<h5>
												<a href="${path }/view/b_num/${ibList.b_num}">${ibList.b_subject }</a>
											</h5>
											<ul>
												<li>작성자 <span>${ibList.c_id }</span></li>
												<li>${ibList.b_regdate }</li>
												<li>좋아요 개수 <span>${ibList.b_good }</span></li>
											</ul>
											<p>${ibList.b_content }</p>
										</div>
									</div>
								</div>
							</div>
							<!-- 					<div class="blog-pagination property-pagination ">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"
							class="icon">→</a>
					</div> -->
						</div>
					</div>
				</c:forEach>
				<div style="margin: 0 auto; width: 95%;">
					<a
						style="font-size: 14px; color: #111111; font-weight: 600; float: right;"
						href="${path}/list/b_type/영화정보/pageNum/1" class="read-more">더보기 <i
						class="fa fa-arrow-right"></i></a>
				</div>
			</c:if>
			<!-- 여기까지 foreach적용 -->
			<div style="height: 80;"></div>
		</div>
		<div class="container">
			            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>자유게시판</h4>
                    </div>
                </div>
            </div>
			<!-- 여기서부터 foreach적용 -->
			<c:if test="${empty fbList }">
				<div style="margin: 0 auto; width: 95%;">
					<h5>조회 된 내용이 없습니다 (게시글 제목으로 검색하세요)</h5>
				</div>
			</c:if>
			<c:if test="${not empty fbList}">
				<c:forEach var="fbList" items="${fbList }" end="2">
					<div class="row">
						<div class="col-lg-12">
							<div class="blog-item-list">
								<div class="blog-item">
									<div class="bi-text">
										<div style="margin: 0 auto; width: 95%;">
											<h5>
												<a href="${path }/view/b_num/${fbList.b_num}">${fbList.b_subject }</a>
											</h5>
											<ul>
												<li>작성자 <span>${fbList.c_id }</span></li>
												<li>${fbList.b_regdate }</li>
												<li>좋아요 개수 <span>${fbList.b_good }</span></li>
											</ul>
											<p>${fbList.b_content }</p>
										</div>
									</div>
								</div>
							</div>
							<!-- 					<div class="blog-pagination property-pagination ">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"
							class="icon">→</a>
					</div> -->
						</div>
					</div>
				</c:forEach>
				<div style="margin: 0 auto; width: 95%;">
					<a
						style="font-size: 14px; color: #111111; font-weight: 600; float: right;"
						href="${path}/list/b_type/자유/pageNum/1" class="read-more">더보기 <i
						class="fa fa-arrow-right"></i></a>
				</div>
			</c:if>
			<!-- 여기까지 foreach적용 -->
			<div style="height: 80;"></div>
		</div>
		<div class="container">
			            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>공지게시판</h4>
                    </div>
                </div>
            </div>
			<!-- 여기서부터 foreach적용 -->
			<c:if test="${empty nbList }">
				<div style="margin: 0 auto; width: 95%;">
					<h5>조회 된 내용이 없습니다 (게시글 제목으로 검색하세요)</h5>
				</div>
			</c:if>
			<c:if test="${not empty nbList}">
				<c:forEach var="nbList" items="${nbList }" end="2">
					<div class="row">
						<div class="col-lg-12">
							<div class="blog-item-list">
								<div class="blog-item">
									<div class="bi-text">
										<div style="margin: 0 auto; width: 95%;">
											<h5>
												<a href="${path }/view/b_num/${nbList.b_num}">${nbList.b_subject }</a>
											</h5>
											<ul>
												<li>작성자 <span>${nbList.c_id }</span></li>
												<li>${nbList.b_regdate }</li>
												<li>좋아요 개수 <span>${nbList.b_good }</span></li>
											</ul>
											<p>${nbList.b_content }</p>
										</div>
									</div>
								</div>
							</div>
							<!-- 					<div class="blog-pagination property-pagination ">
						<a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"
							class="icon">→</a>
					</div> -->
						</div>
					</div>
				</c:forEach>
				<div style="margin: 0 auto; width: 95%;">
					<a
						style="font-size: 14px; color: #111111; font-weight: 600; float: right;"
						href="${path}/list/pageNum/1" class="read-more">더보기 <i
						class="fa fa-arrow-right"></i></a>
				</div>
			</c:if>
			<!-- 여기까지 foreach적용 -->
			<div style="height: 80;"></div>
		</div>

	</section>
	<script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.magnific-popup.min.js"></script>
    <script src="js/mixitup.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.nice-select.min.js"></script>
    <script src="js/jquery.slicknav.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <script src="js/jquery.richtext.min.js"></script>
    <script src="js/image-uploader.min.js"></script>
    <script src="js/main.js"></script>

</body>

</html>