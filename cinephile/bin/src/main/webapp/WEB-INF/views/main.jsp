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
/* #Hz img:last-child {
    float:right;
    display:block;
} */
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
}​
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
		alert("a");
		taglist[idx]=frm.tag.value;
		$("#tagList").append("#"+taglist[idx]);
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
			alert("최대 150자 입니다.")
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
					<img alt="" src="${board}" height="800">
					<div class="row">
                    	<div class="col-md-12">
                    	</div>
                	</div>
                </div>
			</c:forEach>
			</c:if>
            </div>
        </div>
            <div style="margin: 0 auto; width: 95%; padding: 50px 0 0 0;">
				<a style="font-size: 30px; color: #111111; font-weight: 600; float: right;"	
					href="movieList" class="read-more">모든 영화 보기 <i class="fa fa-arrow-right"></i></a>
				</div>
    </section>
    <!-- Hero Section End -->
<!-- 취향집 시작 -->
${nickname }님의 취향집
	<div id="Hz">
<c:if test="${not empty favmList }">
	<c:forEach var="movielist" items="${favmList }" end="6">
    	<img src="${movielist.mv_imageurl }" width="250" height="300"> 
	</c:forEach>
	<div class="fzbt" >
	<button onclick="location.href='profileOther?c_id=${fid}'" value="더보기">더보기</button>
	<c:if test="${not empty nowid }">
    	<c:if test="${'y' eq fzgood}">
    	
        	<div class="btn btn-link" onclick="location.href='favoritegood?zip_num=${zipnum}&c_id=${nowid}&ck=y'"><img alt="" src="${path}/img/hearton.png" width="100" height="100"></div>
        	<%-- <form action="" name="frm">
        		<input type="hidden" value="${zipnum}" name="zip_num">
        		<input type="hidden" value="${nowid}" name="c_id">
        		<input type="hidden" value="y" name="ck">
        	</form>
        	<a href="javascript:void(0);" onclick="fzGood('${zipnum}','${nowid}','y');"><img id="fimg" src="${path}/img/hearton.png" alt="" width="1" height="20"></a> --%>
        </c:if>
        <c:if test="${'n' eq fzgood}">
        	<div class="btn btn-link" onclick="location.href='favoritegood?zip_num=${zipnum}&c_id=${nowid}&ck=n'"><img alt="" src="${path}/img/heartoff.png" width="100" height="100"></div>
        </c:if>
	</c:if>
    <c:if test="${empty nowid }">
    	<div class="btn btn-link"><img alt="" src="${path}/img/heartoff.png" width="100" height="100">${mono.mo_good }</div>
    </c:if>
    </div>
</c:if>
   <div class="clearfix"></div>
	</div>
    
    <!-- 쓸데없는거 Section Begin -->
    <section class="chooseus-section spad set-bg" data-setbg="img/chooseus/chooseus-bg.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="chooseus-text">
                        <div class="section-title">
                            <h4>Why choose us</h4>
                        </div>
                        <p>Ltype specimen book.</p>
                    </div>
                    <div class="chooseus-features">
                        <div class="cf-item">
                            <div class="cf-pic">
                                <img src="img/chooseus/chooseus-icon-4.png" alt="">
                            </div>
                            <div class="cf-text">
                                <h5>List your own property</h5>
                                <p>Sign up now and sell or rent your own properties</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <br><br>
    <!-- 쓸데없는거 Section End -->
    
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
    			<c:forEach var="mono" items="${moList}" varStatus="status">
    				<div class="col-lg-10">
                    <div class="testimonial-item">
                        <div class="ti-text">
                            <p>${mono.mo_content }</p>
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
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><img alt="" src="${path}/img/hearton.png" width="1" height="40">${mono.mo_good }</div>
                              		</c:if>
                                	<c:if test="${'n' eq mogoodList[status.index]}">
                                		<div class="btn btn-link" onclick="location.href='monologuegood?mo_num=${mono.mo_num}&c_id=${nowid }'"><img alt="" src="${path}/img/heartoff.png" width="1" height="40">${mono.mo_good }</div>
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
                        	<input type="text" class="form-control clo-sm-5" rows="3" name="contents">
                        	<input type="text" class="form-control clo-sm-2" name="tag" id="tag">
                        	<button type="button" onclick="addTag()">태그추가</button>
                        	<input type="hidden" name="c_id" value="${nowid }">
                        	<input type="hidden" name="tags">
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
                                <img src="img/f-logo.png" alt="">
                            </a>
                        </div>
                        <p>Lorem ipsum dolor sit amet, consect</p>
                        <p>Icons made by <a href="https://www.flaticon.com/authors/freepik" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a></p>
                        <p>Icons made by <a href="http://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a></p>
                        <div class="fs-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 col-sm-6">
                    <div class="fs-widget">
                        <h5>Help</h5>
                        <ul>
                            <li><a href="#">Privacy Policy</a></li>
                            <li><a href="#">Contact Support</a></li>
                            <li><a href="#">FAQs</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-2 col-sm-6">
                    <div class="fs-widget">
                        <h5>Links</h5>
                        <ul>
                            <li><a href="a_loginForm">Admin</a></li>
                            <li><a href="#">Register</a></li>
                            <li><a href="#">Login</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="fs-widget">
                        <h5>Newsletter</h5>
                        <p>Deserunt mollit anim id est laborum.</p>
                        <form action="#" class="subscribe-form">
                            <input type="text" placeholder="Email">
                            <button type="submit" class="site-btn">Subscribe</button>
                        </form>
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