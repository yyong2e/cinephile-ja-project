<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
</head>
<body>


	<!--WRAP-->
	<div class="container">
	
		<div class="col-lg-12">

			<div class="row">
				<div class="col-lg-6">
					<div class="pd-title">
						
					</div>
				</div>
				<!-- 이부분에 붙일 내용있으면 div col-lg-6으로 붙이기 -->
			</div>



			<div class="property-comparison-section spad-2">
				<div class="container">
					<div class="row">
						<div class="col-lg-7">
							<div class="pc-table">

								<form action="editSuccess" method="post" name="frm" onsubmit="return chk()">
								<!-- 프로필 -->

								<div class="as-item">

									<div class="as-pic">
									
													<img src="${path }/img/proimg/${customer.c_proimg}" width="150" height="150"  alt="">
									</div>
									<input type="hidden" name="c_id" value="${customer.c_id }">
										<div class="as-text">
										<div class="at-title">
										 
											<h6>${customer.c_nickname }</h6>
										</div>
										<ul>
											<li>아이디 <span>${customer.c_id }</span></li>
											<li>이름 <span>${customer.c_name }</span></li>
											<li>비밀번호 <span><input type="password" name="c_password" max="12" min="4" required="required" autofocus="autofocus"></span></li>
											<li>주소<span><input type="text" name="c_address" value="${customer.c_address }"></span></li>
											<li>연락처 <span><input type="tel" name="c_tel" value="${customer.c_tel }"></span></li>
											<li>Email <span><input type="email" name="c_email" value="${customer.c_email }"></span></li>
											<li>가입일 <span>${customer.c_regdate}</span></li>
										</ul>
										<a href="editMember.html?c_id=${customer.c_id }" class="primary-btn" type="submit">정보 수정</a> 
										
									</div>	
								</div>
								<!-- /프로필 -->
</form>
							</div>

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