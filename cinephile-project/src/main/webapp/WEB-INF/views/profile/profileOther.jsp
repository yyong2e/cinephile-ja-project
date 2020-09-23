<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../header2.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${customer.c_nickname }님의 프로필</title>
<script type="text/javascript">
function follow(){
	$.post('follow','f_id='+frm.f_id.value, function(data){
		document.getElementById('fimg').src = "img/"+data;
		location.reload();
	});
}
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
    	url : 'monoOther',
    	dataType : 'json',
    	async:false,
    	data:"id="+$("#id").val(),
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
                                <c:if test="${'y' eq followCk }">
								<a href="javascript:void(0);" onclick="follow();"><img id="fimg" src="${path }/img/followmi.png"></a> 
								</c:if>
								<c:if test="${'n' eq followCk }">
									<a href="javascript:void(0);" onclick="follow();"><img id="fimg" src="${path }/img/followadd.png"></a>
								</c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="profile-agent-widget">
                            <ul>
                                <li>팔로우  <span>${followcnt }</span></li>
                                <li>팔로잉 <span>${followingcnt }</span></li>
                            </ul>
                        </div>
                    </div>
            </div>
        </div>
        </div>
    </section>

<form action="" name="frm">
	<input type="hidden" id="id" name="f_id" value="${customer.c_id }">
</form>

<div align="center">
<div>${customer.c_nickname }님의 취향집</div>
<c:if test="${not empty mList }">
<c:forEach var="movie" items="${mList }" varStatus="status" end="5">
	<a href="movieInfo?mv_num=${movie.mv_num }&mv_name=${movie.mv_name }"><img alt="" src="${movie.mv_imageurl }"></a>
</c:forEach><button onclick="location.href='favoritemovie?c_id=${customer.c_id}'" value="더보기">더보기</button>
</c:if></div>

<section class="testimonial-section spad">
        <div class="container" id="mono">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <h4>${customer.c_nickname }님의 모놀로그</h4>
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