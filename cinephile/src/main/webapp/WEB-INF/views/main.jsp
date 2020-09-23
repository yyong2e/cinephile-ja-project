<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="description" content="Aler Template">
    <meta name="keywords" content="Aler, unica, creative, html">
    <!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <title>시네필</title>
	<!--  배경 -->
	<link rel="icon" href="favicon.ico" type="image/x-icon" />
	
    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">
    
<style type="text/css">
#Hz {
   width:100%;
}
#Hz img {
    float:left;
    display:block;
    max-width:49%;
    /* width:250; */
    height:auto;
}
.clearfix {
   clear:both;
}
.fzbt{
	position: relative;
}
.boxoffice{
	text-align: center;
}
.fgoodimg{
width: 1px;
}
.box-office {
display:block; margin: 0px auto; padding: 20px;
}
.owl-item active{
width:600px;}
</style>
<script type="text/javascript">
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
				}
			});
		}
	});
});
	function addTag() {
		taglist[idx]=frm.tag.value;
		$("#tagList").append("#"+taglist[idx]);
		frm.tags.value+="#"+taglist[idx];
		frm.tag.value="";
		idx+=1;
	}
	function fzGood(zip_num, c_id, ck) {
		$.post('f', 'zip_num=' + zip_num + '&c_id=' + c_id + '&ck=' + ck,
				function(data) {
					document.getElementById('fimg').src = "img/" + data;
					location.reload();
				});
	}
	function textLine() {
		var str = frm.contents.value;
		if (str.length > 150) {
			alert("최대 150자 입니다.");
			return false;
		}
		if(!str){
			alert("글을 입력해 주세요");
			return false;
		}
	}
</script>

</head>
<body>
    <!-- Page Preloder -->
    <!-- <div id="preloder">
        <div class="loader"></div>
    </div> -->
    <!-- Movie Section Begin -->
    <section class="hero-section">
        <div class="container">
        		
        		<img class="box-office"alt="" src="${path}/img/BOX-OFFICE2.png" style="height:100px; width:280px;">
           
            <div class="hs-slider owl-carousel">
            
            <c:if test="${not empty imageList}">
			<c:forEach var="board" items="${imageList}" varStatus="status">
                <div class="hs-item set-bg" data-setbg="${board}" style="cursor: pointer;" onclick="location.href='movieInfo?mv_num=${codeList[status.index] }&mv_name=${nameList[status.index] }'"> <!-- img/hero/hero-1.jpg -->
					<img alt="" src="${board}" width="900" height="900" >
					<div class="row">
                    	<div class="col-md-12">
                    	</div>
                	</div>
                </div>
			</c:forEach>
			</c:if>
            </div>
        </div>
    </section>
    <div style="margin: 0 auto; width: 95%; padding: 50px 50px 50px 0;">
		<a style="font-size: 30px; color: #111111; font-weight: 600; float: right;"	href="movieList" class="read-more">모든 영화 보기 <i class="fa fa-arrow-right"></i></a>
	</div><br>
    <!-- Hero Section End -->
<!-- 취향집 시작 -->
<div class="container">
            <div class="row">
                <div class="col-lg-12">
${nickname }님의 취향집
	<div id="Hz">
<c:if test="${not empty favmList }">
	<c:forEach var="movielist" items="${favmList }" end="3">
    	<img src="${movielist.mv_imageurl }" width="250" height="300"> 
	</c:forEach>
	<div class="fzbt" >
	<button onclick="location.href='profileOther?c_id=${fid}'" class="btn btn-info" value="더보기">더보기</button>
	<c:if test="${not empty nowid }">
    	<c:if test="${'y' eq fzgood}">    	
        	<div class="btn btn-link" onclick="location.href='favoritegood?zip_num=${zipnum}&c_id=${nowid}&ck=y'"><img alt="" src="${path}/img/hearton.png" width="100" height="100"></div>
        </c:if>
        <c:if test="${'n' eq fzgood}">
        	<div class="btn btn-link" onclick="location.href='favoritegood?zip_num=${zipnum}&c_id=${nowid}&ck=n'"><img alt="" src="${path}/img/heartoff.png" width="100" height="100"></div>
        </c:if>
	</c:if>
    <c:if test="${empty nowid }">
    	<div class="btn btn-link"><img alt="" src="${path}/img/heartoff.png" width="70" height="70">${mono.mo_good }</div>
    </c:if>
    </div>
</c:if>
   <div class="clearfix"></div>
	</div>
    </div>
    </div>
    </div>
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
                                <span>Designer</span>
                                <c:if test="${not empty nowid }">
                                	<c:if test="${'y' eq mogoodList[status.index]}">
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><img alt="" src="${path}/img/hearton.png" width="0.2" height="40">${mono.mo_good }</div>
                              		</c:if>
                                	<c:if test="${'n' eq mogoodList[status.index]}">
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><img alt="" src="${path}/img/heartoff.png" width="0.2" height="40">${mono.mo_good }</div>
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
    <!-- 모놀로그 글쓰기 -->
    <section class="testimonial-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>모놀로그 글쓰기</h4>
                    </div>
                </div>
            </div>
            	<form action="monoWrite" name="frm" onsubmit="return textLine()">
                        <div class="ti-text">
                        	<input type="text" class="form-control col-sm-5" rows="3" name="contents">
                        	태그: <input type="text" class="form-control col-sm-2" name="tag" id="tag">
                        	<button type="button" onclick="addTag()">태그추가</button>
                        	<input type="hidden" name="c_id" value="${nowid }">
                        	<input type="hidden" name="tags" >
                        	<div id="tagList" ></div>
                        </div>
                        <div class="ti-author">
                        <c:if test="${not empty nowid }">
                            <div class="ta-pic">
                                <img src="${path }/img/proimg/${customer.c_proimg}" alt="" width="100" height="100"><span style="">최대 150자</span>
                            </div>
                         </c:if>
                            <div class="ta-text">
                             <c:if test="${not empty nowid }">
                             	<input type="submit" value="글올리기" class="btn btn-info">
                             </c:if>
                             <c:if test="${empty nowid }">
                             	<h5>회원만 가능합니다</h5>
                        	</c:if>
                            </div>
                        </div>
                 </form>
        </div>
    </section>
    <!-- Footer Section Begin -->
    <footer class="footer-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="fs-about">
                        <div class="fs-logo">
                            <a href="#">
                                <img src="img/cinema.png" alt="" width="77">
                                <img src="img/cinephile.png" alt="" width="77">
                            </a>
                        </div>
                        <p>영화에 대해서 소통하는 공간</p>
                        <br>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
                      
                        
                    </div>
                </div>
                <div class="col-lg-2 col-sm-6">
                    <div class="fs-widget">
                        <h5>Links</h5>
                        <ul>
                            <li><a href="a_loginForm">Admin</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="copyright-text">
                <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
  Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
            </div>
        </div>
    </footer>
    <!-- Footer Section End -->

<!--밑에 위로 옮기면 포스터 이미지 사라짐		  -->
    <!-- Js Plugins -->
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