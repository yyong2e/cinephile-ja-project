<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<section class="property-section latest-property-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-5">
                    <div class="section-title">
                        <h4>예매 내역</h4><br><br><span style="color: red">90일이 지나면 자동 삭제 됩니다.</span>
                    </div>
                </div>
                
            </div>
            <c:if test="${empty bList }">
				예매 내역이 없습니다.
			</c:if>
			<c:if test="${not empty bList }">
            <div class="row property-filter">
          		 <c:forEach items="${bList }" var="book">
					<div class="col-lg-4 col-md-6 mix all house">
                    <div class="property-item">
                        <img alt="" src="${book.img }">
                        <div class="pi-text">
                            <div class="pt-price">상영 날짜 ${book.book_date }</div>
                            <h5><a href="#">${book.mv_name }</a></h5>
                            <p><span class="icon_pin_alt"></span> ${book.book_loc }</p>
                            <ul>
                                <li><i class="fa fa-money"></i> ${book.book_price}</li>
                                <li><i class="fa fa-child"></i> ${book.book_humantype }</li>
                                <li><i class="fas fa-couch"></i>좌석: ${book.book_numSeat}</li>
                            </ul>
                        </div>
                    </div>
                </div>
				</c:forEach>
            </div>
            </c:if>
        </div>
    </section>
</body>
</html>