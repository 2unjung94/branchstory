<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%=request.getContextPath()%>"/>
<c:set var="dt" value="<%=System.currentTimeMillis()%>"/>


<jsp:include page="./layout/header.jsp" />

    <div class="main-title nanum">
      <h1>작품이 되는 이야기, 브런치스토리</h1>
      <p>브런치스토리에 담긴 아름다운 작품을 감상해 보세요.<br/>
      그리고 다시 꺼내 보세요.<br/>
      <span>서랍 속 간직하고 있는 글과 감성을.</span></p>
    </div>
      
    <div class="section">
      <div class="main-slide">
        
      </div>
    </div>
    
    <div class="section">
      <div class="s-title">
        <h3 class="nanum">BRUNCH KEYWORD</h3>
        <p>키워드로 분류된 다양한 글 모음</p>
      </div>
      <div class="keyword-wrap">
        <ul>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="1" >지구한바퀴<br/>세계여행</a></li>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="2">그림·웹툰</a></li>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="3">IT<br/>트렌드</a></li>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="4">사진·촬영</a></li>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="5">취향저격<br/>영화 리뷰</a></li>
          <li><a href="javascript:fnKeywordList()" class="keyword-list" data-keyword-no="6">오늘은<br/>이런 책</a></li>
        </ul>
      </div>
    </div>
    
  
  <script>
  
	const contextPath = '<%= request.getContextPath() %>';

	const fnMainList = () => {
	  const mainList = $('.main-slide');
	  $.ajax({
	    type: 'get',
	    url: contextPath + '/blog/mainList.do',
	    dataType: 'json',
	    success: (resData) => {
	      console.log(resData);
	      mainList.empty();
	      $.each(resData.blogList, (i, blog) => {
	        let str = '<div class="blog-item">'; 
	        str += '<a href="' + contextPath + '/blog/detail.do?blogListNo=' + blog.blogListNo + '">';
	        str += '<div class="img-wrap">';
	        if (blog.contents.includes('<img')) {
	          let thumbnailUrl = $(blog.contents).find('img').first().attr('src');
	          str += '<div class="list-thumbnail" style="background: url(' + thumbnailUrl + ')"></div>';
	        } else {
	          str += '<div class="list-thumbnail"><img src="' + contextPath + '/resources/images/wh-image.png"></div>';
	        }
	        str += '</div>'; // img-wrap 종료
	        str += '<div class="text-wrap">';
	        str += '<h4 class="slide-title nanum">';
	        str += blog.title;
	        str += '</h4>';
	        str += '<p class="slide-contents">';
	        str += blog.contents;
	        str += '</p>';
	        str += '<span class="slide-by">by</span><span class="slide-user">';
	        str += blog.user.nickname;
	        str += '</span>  ';
	        str += '</div>'; 
	        str += '</a>'; 
	        str += '</div>'; 
	        mainList.append(str);
	      });

	      // 슬라이드를 초기화하고 새로 추가된 슬라이드를 반영합니다.
	      $('.main-slide').slick({
	        dots: true,
	        dotsClass: 'bn-controller',
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
	    },
	    error: (jqXHR) => {
	      alert(jqXHR.statusText + '(' + jqXHR.status + ')');
	    }
	  });
	}

	const fnKeywordList = () => {
	  $('.keyword-list').on('click', (evt)=>{
	    const keywordNo = evt.target.dataset.keywordNo;
	    location.href = '${contextPath}/blog/keyword.do?keywordNo=' + keywordNo;
	  })
	}
	  
	fnMainList();
	fnKeywordList();
  </script>

<%@ include file="./layout/footer.jsp" %>