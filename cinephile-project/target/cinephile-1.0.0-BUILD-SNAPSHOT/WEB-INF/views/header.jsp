<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
	caption{font-size:30px;}
	.err{color:red; font-weight: bold;}
</style>
<!-- pageContext.request.contextPath : /ch06 -->
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<link href="${path}/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${path}/js/jquery.js"></script>
<script type="text/javascript" src="${path}/js/bootstrap.min.js"></script>

<link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600,700,800,900&display=swap"
        rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,900&display=swap" rel="stylesheet">

    <!-- Css Styles -->
    <link rel="stylesheet" href="${path}/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/owl.carousel.min.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/magnific-popup.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${path}/css/style.css" type="text/css">
	
	<!-- Js Plugins -->
    <script src="${path}/js/jquery-3.3.1.min.js"></script>
    <script src="${path}/js/bootstrap.min.js"></script>
    <script src="${path}/js/jquery.magnific-popup.min.js"></script>
    <script src="${path}/js/mixitup.min.js"></script>
    <script src="${path}/js/jquery-ui.min.js"></script>
    <script src="${path}/js/jquery.nice-select.min.js"></script>
    <script src="${path}/js/jquery.slicknav.js"></script>
    <script src="${path}/js/owl.carousel.min.js"></script>
    <script src="${path}/js/jquery.richtext.min.js"></script>
    <script src="${path}/js/image-uploader.min.js"></script>
    <script src="${path}/js/main.js"></script>
	
	<!-- font-auesome -->
	<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
	
<!-- 로그인 체크 -->
<c:set var="nowid" value="${sessionScope.c_id }"/>
	
<!-- Offcanvas Menu Wrapper Begin -->
    <div class="offcanvas-menu-overlay"></div>
    <div class="offcanvas-menu-wrapper">
        <div class="canvas-close">
            <span class="icon_close"></span>
        </div>
        <div class="logo">
            <a href="${path }/main">
                <img src="${path}/img/cinema.png" alt="" width="65">시네필
            </a>
        </div>
        <div id="mobile-menu-wrap"></div>
        <div class="om-widget">
            <ul>
                <li><i class="icon_mail_alt"></i> Aler.support@gmail.com</li>
                <li><i class="fa fa-mobile-phone"></i> 125-711-811 <span>125-668-886</span></li>
            </ul>
            <a href="joinForm" class="hw-btn">회원가입</a>
        </div>
        <div class="om-social">
            <a href="#"><i class="fa fa-facebook"></i></a>
            <a href="#"><i class="fa fa-twitter"></i></a>
            <a href="#"><i class="fa fa-youtube-play"></i></a>
            <a href="#"><i class="fa fa-instagram"></i></a>
        </div>
    </div>
    <!-- Offcanvas Menu Wrapper End -->

    <!-- Header Section Begin -->
    <header class="header-section">
        <div class="hs-top">
            <div class="container">
                <div class="row">
                    <div class="col-lg-2">
                        <div class="logo">
                            <a href="${path }/main"><img src="${path}/img/cinema.png" alt="" width="65"></a>시네필
                        </div>
                    </div>
                    <div class="col-lg-10">
                        <div class="ht-widget">
                            <ul>
                                <li><i class="icon_mail_alt"></i> 글자</li>
                                <li><i class="fa fa-mobile-phone"></i> 125-711-811 <span>125-668-886</span></li>
                            </ul>
                            <c:if test="${empty nowid }">
                            	<a href="loginForm" class="hw-btn">로그인</a>
                            	<a href="joinForm" class="hw-btn">회원가입</a>
							
							</c:if>
                            <c:if test="${not empty nowid }">
                            	<a href="profileMain?c_id=${nowid }" class="hw-btn">개인정보</a>
							
							</c:if>
                        </div>
                    </div>
                </div>
                <div class="canvas-open">
                    <span class="icon_menu"></span>
                </div>
            </div>
        </div>
        <div class="hs-nav">
            <div class="container">
                <div class="row">
                    <div class="col-lg-9">
                        <nav class="nav-menu">
                            <ul>
                                <li class="active"><a href="${path }/main">Home</a></li>
                                <!-- <li><a href="#">게시판</a>
                                    <ul class="dropdown">
                                        <li><a href="./property.html">Property Grid</a></li>
                                        <li><a href="./profile.html">Property List</a></li>
                                        <li><a href="./property-details.html">Property Detail</a></li>
                                        <li><a href="./property-comparison.html">Property Comperison</a></li>
                                        <li><a href="./property-submit.html">Property Submit</a></li>
                                    </ul>
                                </li> -->
                                <li><a href="${path }/list">리뷰게시판</a></li>
                                <li><a href="${path }/list">영화정보게시판</a></li>
                                <li><a href="${path }/list">자유게시판</a></li>
                                <li><a href="${path }/list">공지게시판</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-3">
						<div class="agent-search-form">
							<form action="t_search">
								<input type="text" name="s_keyword" placeholder="검색어를 입력하세요">
								<button type="submit"><i class="fa fa-search"></i></button>
							</form>
						</div>
					</div>
 <!--                    <div class="col-lg-3">
                        <div class="hn-social">
                            <a href="#"><i class="fa fa-facebook"></i></a>
                            <a href="#"><i class="fa fa-twitter"></i></a>
                            <a href="#"><i class="fa fa-youtube-play"></i></a>
                            <a href="#"><i class="fa fa-instagram"></i></a>
                        </div> 
                    </div>-->
                </div>
            </div>
        </div>
    </header>
    <!-- Header End -->

