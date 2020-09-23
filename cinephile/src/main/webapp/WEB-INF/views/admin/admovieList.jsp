<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Aler Template">
<meta name="keywords" content="Aler, unica, creative, html">
<style type="text/css">
.gradeIcon {
	width: 23px;
}

.mv_name {
	font-size: 18px;
	color: #00C89E;
	margin-bottom: 10px;
	white-space: nowrap;
	width: 360px;
	text-overflow: ellipsis;
	overflow: hidden;
}
</style>
<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
<title>::관리자 영화 목록::</title>

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section spad set-bg"
	data-setbg="${path}/webapp/img/breadcrumb-bg.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-text">
					<h4>영화 목록</h4>
					<div class="bt-option">
						<a href="./adMain"><i class="fa fa-home"></i> Main</a> <span>Movie
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

	<!-- Property Section Begin -->
	<section class="property-section spad">

		<div class="container">
			<div class="row">
				<div class="col-lg-5">
					<div class="section-title">
						<h4>모든 영화</h4>
					</div>
				</div>
				<div class="col-lg-7">
					<div class="property-controls">
						<ul>
							<li data-filter="all" class="">추천순</li>
							<li data-filter=".apart" class="active mixitup-control-active">예매순</li>

						</ul>
					</div>
				</div>
			</div>

			<div class="row">
				<c:if test="${not empty mvAll}">
					<c:forEach var="mvAll" items="${mvAll }" end="8" varStatus="i">
						<div class="col-lg-4 col-md-6">
							<input type="hidden" name="mv_num" value="${mvAll.mv_num }">
							<div class="property-item">
								<div class="pi-pic set-bg-m"
									style="background: url('${mvAll.mv_imageurl}'); background-repeat:no-repeat; background-size: cover;
										height: 500px;"
									onclick="location.href='movieInfo?mv_num=${mvAll.mv_num }&mv_name=${mvAll.mv_name}'">
								</div>
								<div class="pi-text">
									<c:if test="${not empty nowid }">
										<c:if test="${mvAll.gdchk == 1}">
											<a href="favoritechoice?mv_num=${mvAll.mv_num}&page=1"
												class="heart-icon"><i class="fa fa-heart"></i></a>
										</c:if>
										<c:if test="${mvAll.gdchk ==0 }">
											<a href="favoritechoice?mv_num=${mvAll.mv_num}&page=1"
												class="heart-icon"><i class="fa fa-heart-o"></i></a>
										</c:if>
									</c:if>
									<div class="pt-price">
										<p class="mv_name" style="font-weight: 700;">
											<c:if test="${mvAll.mv_grade == '전체 관람가' }">
												<img alt="" src="${path}/img/moviegrade-all.png"
													style="width: 23px;">
											</c:if>
											<c:if test="${mvAll.mv_grade == '12세 관람가' }">
												<img alt="" src="${path}/img/moviegrade-12.png"
													style="width: 23px;">
											</c:if>
											<c:if test="${mvAll.mv_grade == '15세 관람가' }">
												<img alt="" src="${path}/img/moviegrade-15.png"
													style="width: 23px;">
											</c:if>
											<c:if test="${mvAll.mv_grade == '19세 관람가' }">
												<img alt="" src="${path}/img/moviegrade-19.png"
													style="width: 23px;">
											</c:if>
											${mvAll.mv_name }
										</p>
									</div>
									<p>
										<i class="fa fa-video-camera"></i> ${mvAll.mv_direct }
									</p>
									<p>
										<i class="fa fa-user"></i> ${reldate[i.index] }
										<sapn>개봉</sapn>
									</p>
									
									<ul>
										<li><i class="fa fa-heart"></i> ${mvgood[i.index] }</li>
										<li><i class="fa fa-star"></i> ${mvAll.mv_rate }</li>
										<li><i class="fa fa-film"></i> ${mvAll.mv_genre }</li>

										<%-- <c:if test="${mvAll.rechk == 1 }">
										<li><button class="btn btn-success"
												onclick="location.href='reserve?mv_name=${mvAll.mv_name}'">예매</button></li>
										</c:if> --%>
									<div class="ud-links">
										<button onclick="location='mupdateForm?mv_num=${mvAll.mv_num}'" class="btn btn-success">수정</button>
										<a href="mdelete"><i class="fa fa-trash"></i></a> <a
											href="mupdateForm?mv_num=${mvAll.mv_num}" class="modify"><i
											class="fa fa-pencil-square-o"></i></a> 
									</div>


									</ul>
									<%-- <ul>
										<li><a href="mdelete"><i class="fa-trash"></i>  </a>
										<li><input type="button" value="수정"></li>
										<li><button onclick="location='mupdateForm?mv_num=${mv_num}'" class="btn btn-success">수정</button>
									</ul> --%>


									<!-- 									<div class="pi-agent">
										<div class="pa-item">
											<div class="pa-info">
												<img src="img/property/posted-by/pb-1.jpg" alt="">
												<h6>Ashton Kutcher</h6>
											</div>
											<div class="pa-text">123-455-688</div>
										</div>
									</div> -->
								</div>
							</div>
						</div>
					</c:forEach>
				</c:if>
				<div class="col-lg-12">
					<div class="loadmore-btn">
						<a href="#" onclick="loadMore()">Load more</a>
					</div>
				</div>
				<div id="append_movie"></div>
			</div>
		</div>
	</section>
	<!-- Property Section End -->
	<!-- <script type="text/javascript">
		function loadMore() {
			$('#append_movie').load("movieList",function(data){
				alert(data);
			});
			
		}
	</script> -->
</body>

</html>