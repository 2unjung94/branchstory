<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>


<jsp:include page="./layout/header.jsp" />

<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js" integrity="sha512-HGOnQO9+SP1V92SrtZfjqxxtLmVzqZpjFFekvzZVWoiASSQgSr4cw9Kqd2+l8Llp4Gm0G8GIFJ4ddwZilcdb8A==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" integrity="sha512-6lLUdeQ5uheMFbWm3CP271l14RsX1xtx+J5x2yeIDkkiBpeVTNhTqijME7GgRKKi6hCqovwCoBTlRBEC20M8Mg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css" integrity="sha512-yHknP1/AwR+yx26cB1y0cjvQUMvEa2PFzt1c9LlS4pRQ5NOTZFWbhBig+X9G9eYW/8m0/4OXNx8pxJ6z57x0dw==" crossorigin="anonymous" referrerpolicy="no-referrer" />

  <div class="wrap">
    
    <div class="main-title nanum">
      <h1>작품이 되는 이야기, 브런치스토리</h1>
      <p>브런치스토리에 담긴 아름다운 작품을 감상해 보세요.<br/>
      그리고 다시 꺼내 보세요.<br/>
      <span>서랍 속 간직하고 있는 글과 감성을.</span></p>
    </div>
      
    <div class="section">
      <div class="main-slide">
        <div>
          <div class="img-wrap"></div>
          <div class="text-wrap">
            <h4 class="slide-title nanum">불편한 마음, 진전할 기회</h4>
            <p class="slide-contents">불편한 마음, 진전할 기회 내용입력</p>
            <span class="slide-by">by</span><span class="slide-user">현안 XianAn 스님</span>  
          </div>
        </div>
        <div>
          <div class="img-wrap"></div>
          <div class="text-wrap">
            <h4 class="slide-title nanum">불편한 마음, 진전할 기회</h4>
            <p class="slide-contents">불편한 마음, 진전할 기회 내용입력</p>
            <span class="slide-by">by</span><span class="slide-user">현안 XianAn 스님</span>  
          </div>
        </div>
        <div>
          <div class="img-wrap"></div>
          <div class="text-wrap">
            <h4 class="slide-title nanum">불편한 마음, 진전할 기회dddddd</h4>
            <p class="slide-contents">불편한 마음, 진전할 기회 내용입력</p>
            <span class="slide-by">by</span><span class="slide-user">현안 XianAn 스님</span>  
          </div>
        </div>
        <div>
          <div class="img-wrap"></div>
          <div class="text-wrap">
            <h4 class="slide-title nanum">불편한 마음, 진전할 기회</h4>
            <p class="slide-contents">불편한 마음, 진전할 기회 내용입력</p>
            <span class="slide-by">by</span><span class="slide-user">현안 XianAn 스님</span>  
          </div>
        </div>
        <div>
          <div class="img-wrap"></div>
          <div class="text-wrap">
            <h4 class="slide-title nanum">불편한 마음, 진전할 기회</h4>
            <p class="slide-contents">불편한 마음, 진전할 기회 내용입력</p>
            <span class="slide-by">by</span><span class="slide-user">현안 XianAn 스님</span>  
          </div>
        </div>
      </div>
    </div>
    
    <div class="section">
      <div class="s-title">
        <h3 class="nanum">BRUNCH KEYWORD</h3>
        <p>키워드로 분류된 다양한 글 모음</p>
      </div>
      <div class="keyword-wrap">
        <ul>
          <li><a href=""><span>지구한바퀴<br/>세계여행</span></a></li>
          <li><a href=""><span>그림·웹툰</span></a></li>
          <li><a href=""><span>IT<br/>트렌드</span></a></li>
          <li><a href=""><span>사진·촬영</span></a></li>
          <li><a href=""><span>취향저격<br/>영화 리뷰</span></a></li>
          <li><a href=""><span>오늘은<br/>이런 책</span></a></li>
        </ul>
      </div>
    </div>
    
  </div>
  
  <script>
  $(document).ready(function(){
	  $('.main-slide').slick({
		  dots: true,
		  dotsClass:'bn-controller',
		  customPaging: function(slide, i) {
        return (i + 1).toString().padStart(2, "0")
      },
		  infinite: false,
		  speed: 300,
		  slidesToShow: 1,
		  slidesToScroll: 1,
		  centerMode: true,
		  variableWidth: true
	  });
	});
  </script>

<%@ include file="./layout/footer.jsp" %>