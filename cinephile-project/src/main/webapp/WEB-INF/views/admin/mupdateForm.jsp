<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script>
/*var taglist=[];
var idx=0;

$(document).ready(function() {
	$("#tag").autocomplete({
		source : function(request, response) {
			$.ajax({
				type : 'POST',
				url : 'tagGet',
				dataType : 'json',
				//data : {con:$("#tag").val()},
				success : function(data) {
					
					//var result = data;
					//response(result);
					response(
							$.map(data,function(item){
								return{
									label:item+"label",
									value:item,
									test :item+"test"
								}
							})
							);
				}
			});
		},
		focs : function(event,ui){
			return false;
		},
		minLength:1,
		autoFocus:true,
		classes:{
			"ui-autocomplete":"highlight"
		},
		delay:500, // 검생창에 글 쓰고 autocomplete 창 뜰때까지 딜레이 ms
		position:{my:"right top",at:"right bottom"},
		close:function(event){
			console.log(evetn);
		}
				 errozr: function(data) {
					alert("에러 발생");
				} 
			});
		
	}); */
	
	var taglist=[];
	var idx=0;
	$(document).ready(function() {
		$("#tag").autocomplete({
			source : function(request, response) {
				$.ajax({
					type : 'POST',
					url : 'tagGet',
					dataType : 'json',
					data : {con:$("#tag").val()},
					success : function(data) {
						var result = data;
						
						response(result);
					},
					
					error: function(data) {
						alert("에러 발생");
					},
					delay: 500,
					position:{ my: "right top", at: "right bottom"},
					close: function(event){
						console.log(event);
					}
				});
			}
		});
	});
	function addTag() {
		taglist[idx]=f.tag.value;
		$("#tagList").append("#"+taglist[idx]);
		f.tags.value+="#"+taglist[idx];
		f.tag.value="";
		idx+=1;
	}
	function textLine(){
		return false;
	}
</script>

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
						<h4>영화 수정</h4>
						<div class="bt-option">
							<a href="./adMain"><i class="fa fa-home"></i> Main</a> <span>Movie
								Modify</span>
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
						<form action="mupdate" class="cc-form" method="post" name="f">
							<div class="pf-title">
								<h4>영화 제목</h4>
								<input type="text" value='${movie.mv_name }' name="mv_name">
							</div>



							<!-- 배우 /제작진 -->
							<div class="pf-location">
								<h4>배우/제작진</h4>
								<div class="location-inputs">
									<input type="text" value="${movie.mv_direct }" name="mv_direct">
									<input type="text" value="${movie.mv_mjactor }"
										name="mv_mjactor"> <input type="text"
										value="${movie.mv_minactor }" name="mv_minactor">

								</div>
							</div>
							<!-- / 배우/제작진 end -->

							<!-- 영화 정보  -->
							<div class="pf-location">
								<h4>영화 정보</h4>
								<div class="location-inputs">
									<input type="text" value='${movie.mv_reldate }' name="mv_reldate">
									<input type="number" value="${movie.mv_runtime }"
										name="mv_runtime"> <input type="text"
										value="${movie.mv_rate }" name="mv_rate1"> <input
										type="text" value="${movie.mv_grade }" name="mv_grade">
									<input type="number" value="${movie.mv_num }" name="mv_num">
								</div>
								<!-- 영화 줄거리  -->
								<textarea name="mv_content">${movie.mv_content }</textarea>

							</div>
							<!-- /영화정보 -->



							<!-- 영화 장르 -->
							<div class="pf-feature">
								<h4>장르</h4>
								<div class="features-list">
									<!-- 1단 -->
									<div class="feature-item">
										<c:forEach var="gn" items="${gn_list }" varStatus="i"
											begin="0" end="6">
											<c:if test="${movie.mv_genre ==gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" checked="checked"
													name="mv_genre" value="${gn.gn_name }"> <span
													class="checkbox"></span>
												</label>
											</c:if>
											<c:if test="${movie.mv_genre !=gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" name="mv_genre"
													value="${gn.gn_name }"> <span class="checkbox"></span>
												</label>
											</c:if>
										</c:forEach>
									</div>
									<!-- 2단 -->
									<div class="feature-item">
										<c:forEach var="gn" items="${gn_list }" varStatus="i"
											begin="7" end="13">
											<c:if test="${movie.mv_genre ==gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" checked="checked"
													name="mv_genre" value="${gn.gn_name }"> <span
													class="checkbox"></span>
												</label>
											</c:if>
											<c:if test="${movie.mv_genre !=gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" name="mv_genre"
													value="${gn.gn_name }"> <span class="checkbox"></span>
												</label>
											</c:if>
										</c:forEach>
									</div>
									<!-- 3단 -->
									<div class="feature-item">
										<c:forEach var="gn" items="${gn_list }" varStatus="i"
											begin="14" end="19">
											<c:if test="${movie.mv_genre ==gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" checked="checked"
													name="mv_genre" value="${gn.gn_name }"> <span
													class="checkbox"></span>
												</label>
											</c:if>
											<c:if test="${movie.mv_genre !=gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" name="mv_genre"
													value="${gn.gn_name }"> <span class="checkbox"></span>
												</label>
											</c:if>
										</c:forEach>
									</div>
									<!-- 4단 -->
									<div class="feature-item">
										<c:forEach var="gn" items="${gn_list }" varStatus="i" 
											begin="20" end="25">
											<c:if test="${movie.mv_genre ==gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" checked="checked"
													name="mv_genre" value="${gn.gn_name }"> <span
													class="checkbox"></span>
												</label>
											</c:if>
											<c:if test="${movie.mv_genre !=gn.gn_name}">
												<label for="${gn.gn_name }">${gn.gn_name } <input
													type="checkbox" id="${gn.gn_name }" name="mv_genre"
													value="${gn.gn_name }"> <span class="checkbox"></span>
												</label>
											</c:if>
										</c:forEach>
									</div>

								</div>
							</div>
							<!-- /영화정보  -->

							<!-- 영화 포스터 -->
							<div class="pf-feature-image">
								<h4>영화 포스터 URL</h4>
								<div class="feature-image-content">
									<div class="image-uploader">
										<input type="text" value="${movie.mv_imageurl }"
											name="mv_imageurl">
									</div>
								</div>
							</div>
							<!-- /영화포스터 -->

							<!-- 태그 -->
							<h4>태그 검색</h4>
			 				태그: <input type="text" class="form-control clo-sm-2" name="tag" id="tag" >
                        	<button type="button" onclick="addTag()">태그추가<i class="fa fa-search"></i></button>
                        	<!-- <input type="text" class="form-control clo-sm-2" name="블록버스터" id="current_tag" value="블록버스터" > -->
                         	<input type="hidden" name="c_id" value="${nowid }">
                        	<input type="hidden" name="tags" >
                        	<div id="tagList">
                        	</div>
							<input type="submit" class="site-btn" value="영화 수정">
							<!-- 		<button type="submit" class="site-btn">영화 수정</button> -->
						</form>
	                        <c:forEach  var="tl" items="${tagList }" begin="0" >
	                        <span >${tl.tag_con }</span>
	                        
	                        </c:forEach>
					</div>
				</div>
			</div>
		</div>


	</section>
	<!-- Property Submit Section End -->

</body>
</html>