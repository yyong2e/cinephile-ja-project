<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
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
.mv_name{
    font-size: 18px;
    color: #00C89E;
    margin-bottom: 10px;
    white-space: nowrap;
    width: 360px;
    text-overflow: ellipsis;
    overflow: hidden;
}
</style>
<script type="text/javascript">
var x = 9;
	$(function() {
		$("#list0").show();
		$("#list1").show();
		$("#list2").show();
		$("#list3").show();
		$("#list4").show();
		$("#list5").show();
		$("#list6").show();
		$("#list7").show();
		$("#list8").show();
		$("#load").click(function(e) {
			e.preventDefault();
			var y = x+9; 
			for(x; x<y; x++)
				$("#list"+x+":hidden").show();
		});
	});
</script>
<!-- <meta name="viewport" content=         "width=device-width, initial-scale=1.0"> -->
<title>시네필 영화전체목록</title>

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

		<div class="container" id="mvAllB">
			<div class="row">
				<div class="col-lg-5">
					<div class="section-title">
						<h4>모든 영화</h4>
					</div>
				</div>
				<div class="col-lg-7">
					<div class="property-controls">
						<ul>
							<li onclick="location.href='movieList'">추천순</li>
							<li onclick="location.href='movieListBook'">예매순</li>
							<li onclick="location.href='movieListRate'">별점순</li>
						</ul>
					</div>
				</div>
			</div>
			
			
			<div class="row" >
				<c:if test="${not empty mvAllB}">
					<c:forEach var="mvAllB" items="${mvAllB }" varStatus="i">
					<div id="list${i.index }" style="display: none;">
						<div class="col-lg-4 col-md-6">
							<div class="property-item">
								<div class="pi-pic set-bg"
									style="background: url('${mvAllB.mv_imageurl}'); background-repeat:no-repeat; background-size: cover;
										height: 500px;"
									onclick="location.href='movieInfo?mv_num=${mvAllB.mv_num }&mv_name=${mvAllB.mv_name}'">
								</div>
								<div class="pi-text">
									<c:if test="${not empty nowid }">
										<c:if test="${mvAllB.gdchk == 1}">
											<a href="favoritechoice?mv_num=${mvAllB.mv_num}&page=1" class="heart-icon"><i class="fa fa-heart"></i></a>
										</c:if>
										<c:if test="${mvAllB.gdchk ==0 }">
											<a href="favoritechoice?mv_num=${mvAllB.mv_num}&page=1" class="heart-icon"><i class="fa fa-heart-o"></i></a>
										</c:if>
									</c:if>
									<div class="pt-price">
									<p class="mv_name" style="font-weight: 700;">
										<c:if test="${mvAllB.mv_grade == '전체 관람가' }">
											<img alt="" src="${path}/img/moviegrade-all.png"
												style="width: 23px;">
										</c:if>
										<c:if test="${mvAllB.mv_grade == '12세 관람가' }">
											<img alt="" src="${path}/img/moviegrade-12.png"
												style="width: 23px;">
										</c:if>
										<c:if test="${mvAllB.mv_grade == '15세 관람가' }">
											<img alt="" src="${path}/img/moviegrade-15.png"
												style="width: 23px;">
										</c:if>
										<c:if test="${mvAllB.mv_grade == '19세 관람가' }">
											<img alt="" src="${path}/img/moviegrade-19.png"
												style="width: 23px;">
										</c:if>
										${mvAllB.mv_name }</p>
									</div>
									<p>
										<i class="fa fa-video-camera"></i> ${mvAllB.mv_direct }
									</p>
									<p>
										<i class="fa fa-user"></i> ${reldate[i.index] }
										<sapn>개봉</sapn>
									</p>
									<ul>
										<li><i class="fa fa-heart"></i> ${mvgood[i.index] }</li>
										<li><i class="fa fa-star"></i> ${mvAllB.mv_rate }</li>
										<li><i class="fa fa-film"></i> ${mvAllB.mv_genre }</li>
										<c:if test="${mvAllB.rechk == 1 }">
										<li><button class="btn btn-success"
												onclick="location.href='reserve?mv_name=${mvAllB.mv_name}'">예매</button></li>
										</c:if>
									</ul>
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
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
				<div class="col-lg-12">
					<div class="loadmore-btn">
						<a href="#" id="load">Load more</a>
					</div>
				</div>
	</section>
	<!-- Property Section End -->
</body>

</html>