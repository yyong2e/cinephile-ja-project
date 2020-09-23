<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="a_header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>::관리자 태그 목록::</title>

<!-- Breadcrumb Section Begin -->
<section class="breadcrumb-section spad set-bg"
	data-setbg="${path}/webapp/img/breadcrumb-bg.jpg">
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="breadcrumb-text">
					<h4>태그 목록</h4>
					<div class="bt-option">
						<a href="./adMain"><i class="fa fa-home"></i> Main</a> <span>Tag
							List</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Breadcrumb Section End -->
</head>
<body>

<div class="property-comparison-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 p-0">
                    <div class="pc-table">
<span style="color: red;" >태그 삭제시 모놀로그, 영화에 있는 태그들도 삭제됩니다.</span>
                        <table>
                            <tbody>
                            	<c:forEach items="${tList }" var="tag">
                            	<tr>
                                    <td>${tag.tag_con }</td>
                                    <td><button class="btn btn-info" onclick="location.href='tagDel?tag_num=${tag.tag_num}'">태그 삭제</button></td>
                                </tr>
								</c:forEach>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>