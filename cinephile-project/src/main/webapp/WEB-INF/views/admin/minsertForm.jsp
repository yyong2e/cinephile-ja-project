<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>::관리자 영화 등록::</title>
</head>
<body>



	<!-- Breadcrumb Section Begin -->
	<section class="breadcrumb-section spad set-bg"
		data-setbg="${path}/webapp/img/breadcrumb-bg.jpg">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="breadcrumb-text">
						<h4>영화 등록</h4>
						<div class="bt-option">
							<a href="./adMain"><i class="fa fa-home"></i> Main</a> <span>Movie
								Upload</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Breadcrumb Section End -->

	<!-- Property Submit Section Begin -->
	<section class="property-submit-section spad">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="property-submit-form">
						<form action="minsert" class="cc-form" method="post">
							<div class="pf-title">
								<h4>영화 제목</h4>
								<input type="text" placeholder="영화제목" name="mv_name">
							</div>



							<!-- 배우 /제작진 -->
							<div class="pf-location">
								<h4>배우/제작진</h4>
								<div class="location-inputs">
									<input type="text" placeholder="감독" name="mv_direct"> <input
										type="text" placeholder="주연" name="mv_mjactor"> <input
										type="text" placeholder="조연" name="mv_minactor">
								</div>
							</div>
							<!-- / 배우/제작진 end -->

							<!-- 영화 정보  -->
							<div class="pf-location">
								<h4>영화 정보</h4>
								<div class="location-inputs">
									<input type="text" placeholder="개봉일 ( ex: 2020.01.01 개봉)"
										name="mv_reldate"> <input type="number"
										placeholder="러닝타임 (분단위 )" name="mv_runtime"> <input
										type="text" placeholder="평점(소수점 한자리 )" name="mv_rate1">
									<input type="text" placeholder="관람등급 ( ex: 12세 관람가 )"
										name="mv_grade"> <input type="number"
										placeholder="영화 코드 넘버 " name="mv_num">
								</div>
								<!-- 영화 줄거리  -->
								<textarea placeholder="영화 줄거리" name="mv_content"></textarea>
							</div>
							<!-- /영화정보 -->

							<!-- 영화 장르 -->
							<div class="pf-feature">
								<h4>장르</h4>
								<div class="features-list">
									<div class="feature-item">
										<label for="드라마">드라마 <input type="checkbox" id="드라마"
											name="mv_genre" value="드라마"> <span class="checkbox"></span>
										</label> <label for="판타지">판타지 <input type="checkbox" id="판타지"
											name="mv_genre" vlaue="판타지"> <span class="checkbox"></span>
										</label> <label for="서부">서부 <input type="checkbox" id="서부"
											name="mv_genre" vlaue="서부"> <span class="checkbox"></span>
										</label> <label for="공포">공포 <input type="checkbox" id="공포"
											name="mv_genre" value="공포"> <span class="checkbox"></span>
										</label> <label for="멜로/로맨스">멜로/로맨스 <input type="checkbox"
											id="멜로/로맨스" name="mv_genre" value="멜로/로맨스"> <span
											class="checkbox"></span>
										</label> <label for="무협">무협 <input type="checkbox" id="무협"
											name="mv_genre" value="무협"> <span class="checkbox"></span>
										</label> <label for="실험">실험 <input type="checkbox" id="실험"
											name="mv_genre" value="실험"> <span class="checkbox"></span>
										</label>
									</div>
									<div class="feature-item">
										<label for="모험">모험 <input type="checkbox" id="모험"
											name="mv_genre" value="모험"> <span class="checkbox"></span>
										</label> <label for="스릴러">스릴러 <input type="checkbox" id="스릴러"
											name="mv_genre" value="스릴러"> <span class="checkbox"></span>
										</label> <label for="느와르">느와르 <input type="checkbox" id="느와르"
											name="mv_genre" value="느와르"> <span class="checkbox"></span>
										</label> <label for="컬트">컬트 <input type="checkbox" id="컬트"
											name="mv_genre" value="컬트"> <span class="checkbox"></span>
										</label> <label for="다큐먼터리">다큐먼터리 <input type="checkbox"
											id="다큐먼터리" name="mv_genre" value="다큐먼터리"> <span
											class="checkbox"></span>
										</label> <label for="액션">액션 <input type="checkbox" id="액션"
											name="mv_genre" value="액션"> <span class="checkbox"></span>
										</label> <label for="공연실황">공연실황 <input type="checkbox"
											id="공연실황" name="mv_genre" value="공연실황"> <span
											class="checkbox"></span>
										</label>
									</div>
									<div class="feature-item">
										<label for="코미디">코미디 <input type="checkbox" id="코미디"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="가족">가족 <input type="checkbox" id="가족"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="미스터리">미스터리 <input type="checkbox"
											id="미스터리"> <span class="checkbox"></span>
										</label> <label for="전쟁">전쟁 <input type="checkbox" id="전쟁">
											<span class="checkbox"></span>
										</label> <label for="블랙코미디">블랙코미디 <input type="checkbox"
											id="블랙코미디" name="mv_genre"> <span
											class="checkbox"></span>
										</label> <label for="서사">서사 <input type="checkbox" id="서사"
											name="mv_genre"> <span class="checkbox"></span>
										</label>
									</div>
									<div class="feature-item">
										<label for="애니메이션">애니메이션 <input type="checkbox"
											id="애니메이션" name="mv_genre"> <span
											class="checkbox"></span>
										</label> <label for="범죄">범죄 <input type="checkbox" id="범죄"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="뮤지컬">뮤지컬 <input type="checkbox" id="뮤지컬"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="SF">SF <input type="checkbox" id="SF"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="에로">에로 <input type="checkbox" id="에로"
											name="mv_genre"> <span class="checkbox"></span>
										</label> <label for="서스펜스">서스펜스 <input type="checkbox"
											id="서스펜스" name="mv_genre"> <span
											class="checkbox"></span>
										</label>
									</div>

								</div>
							</div>

							<!-- /영화정보  -->

							<!-- 영화 포스터 -->
							<div class="pf-feature-image">
								<h4>영화 포스터 이미지</h4>
								<div class="feature-image-content">
									<div class="image-uploader">
										<input type="text" placeholder="네이버 영화 url 입력"
											name="mv_imageurl">

									</div>
								</div>
							</div>
							<!-- /영화포스터 -->



							<input type="submit" class="site-btn" value="영화 등록">
							<button type="submit" class="site-btn">영화 등록</button>
						</form>
					</div>
				</div>
			</div>
		</div>


	</section>
	<!-- Property Submit Section End -->

</body>
</html>