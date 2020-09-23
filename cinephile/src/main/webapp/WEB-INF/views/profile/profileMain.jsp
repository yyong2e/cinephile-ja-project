<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header2.jsp" %>
<%@include file="../loginsessionck.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필</title>
<style>
      .au {
        overflow: auto;
      }  
.card {
  position: relative;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-direction: column;
  flex-direction: column;
  min-width: 0;
  word-wrap: break-word;
  background-color: #fff;
  background-clip: border-box;
  border: 1px solid rgba(0, 0, 0, 0.125);
  border-radius: 0.25rem;
  margin: 5;
}
.card-body {
  -ms-flex: 1 1 auto;
  flex: 1 1 auto;
  min-height: 1px;
  padding: 1.25rem;
}
.card-header {
  padding: 0.75rem 1.25rem;
  margin-bottom: 0;
  background-color: rgba(0, 0, 0, 0.03);
  border-bottom: 1px solid rgba(0, 0, 0, 0.125);
}
.card-footer {
  padding: 0.75rem 1.25rem;
  background-color: rgba(0, 0, 0, 0.03);
  border-top: 1px solid rgba(0, 0, 0, 0.125);
}
.card-header-tabs {
  margin-right: -0.625rem;
  margin-bottom: -0.75rem;
  margin-left: -0.625rem;
  border-bottom: 0;
}
.card-header-pills {
  margin-right: -0.625rem;
  margin-left: -0.625rem;
}
</style>
<script type="text/javascript">
	var monolist=[];
	var idx=6;
	$(window).scroll(function() {
		if($(window).scrollTop()>=$(document).height() - $(window).height()){
			if(idx<monolist.length){
			for(var i=idx;i<idx+3;i++){
				if(i>=monolist.length){
					break;
				}
				var str="";
				str+="<div class='row'>"
				+"<div class='col-md-10 mb-5'>"
				+"<div class='card h-100'>"
				+"<div class='card-body'>"
				+"<p class='card-text'>"+monolist[i].mo_content+"</p></div>"
				+"<div class='card-footer'>"
				+"좋아요 수:"+monolist[i].mo_good+" "
				+"<div class="+"'btn btn-danger btn-sm'"
				+"onclick="+"location.href='monoDelete?mo_num="+monolist[i].mo_num+"'>삭제"
				+"</div></div></div></div>"
				$("#mono").append(str);
				
				
				/* str+="<form action='monoWrite'>"
				+"<div class="+"'ti-text'"+">"
				+monolist[i].mo_content+"<input type='hidden'name='c_id' value='${nowid }'>"
				+"</div>"
				+"<div class='ti-author'>"
				+"<div class='ta-pic'>"
				+"좋아요수:"+monolist[i].mo_good
				+"</div>"
				+"<div class="+"'btn btn-danger'"
				+"onclick="+"location.href='monoDelete?mo_num="+monolist[i].mo_num+"'>삭제"
				+"</div>"
				+"</div>"
				+"</form>"
				$("#mono").append(str); */
			}
			idx+=3;
			}
		}
		
	});
	
	$(document).ready(function() {
	    $.ajax({
	    	type: 'POST',
	    	url : 'mono',
	    	dataType : 'json',
	    	async:false,
	    	success : function(data) {
	    		monolist=data;
	    	}
	   });
	    
	});
</script>
</head>
<body>
<section class="profile-section spad">
        <div class="container">
            <div class="profile-agent-content">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="profile-agent-info">
                            <div class="pi-pic">
                                <img src="${path }/img/proimg/${customer.c_proimg}" width="100" height="120" alt="">
                            </div>
                            <div class="pi-text">
                                <h5>${customer.c_nickname}</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="profile-agent-widget">
                            <ul>
                                <li><a href="followCk" >팔로우  <span>${followcnt }</span></a></li>
                                <li><a href="followingCk">팔로잉 <span>${followingcnt }</span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="profile-agent-widget">
                            <ul>
                                <li><div class="btn btn-info" onclick="location.href='cusUpdateForm?c_id=${nowid}'">개인정보 수정</div></li>
                                <li><div class="btn btn-info" onclick="location.href='bookChk'">예매 내역 확인</div></li>
                            </ul>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>

<c:if test="${not empty mList }">
<div align="center">
<c:forEach var="movie" items="${mList }" varStatus="status" end="5">
	<a href="movieInfo?mv_num=${movie.mv_num }&mv_name=${movie.mv_name }"><img alt="" src="${movie.mv_imageurl }"></a>
</c:forEach><button onclick="location.href='favoritemovie?c_id=${nowid}'" value="더보기">더보기</button>
</div>
</c:if>

	<section class="testimonial-section spad">
		<div class="container" id="mono">
			<div class="row">
				<div class="col-lg-12">
					<div class="section-title">
						<h4>나의 모놀로그</h4>
					</div>
				</div>
			</div>
			<c:forEach var="tlist" items="${mlList }" begin="0" end="5">
				<div class="row">
					<div class="col-md-10 mb-5">
						<div class="card h-100">
							<div class="card-body">
								<p class="card-text">${tlist.mo_content }</p>
							</div>
							<div class="card-footer">
								좋아요수:${tlist.mo_good }
								<div class="btn btn-danger btn-sm" onclick="location.href='monoDelete?mo_num=${tlist.mo_num}'">삭제
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			</div>
	</section>
</body>
</html>