<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ page import="java.sql.*" %>
<%
     //   로그인 상태를 유지하기 위하여, sid에 저장되었던 접속한 ID값을 
     //   session 객체로부터 가져와서 변수 id에 저장시킴 (loginOK.jsp의 43행부분 확인요망!)
	String id = (String)session.getAttribute("sid");  
	// String id = session.getAttribute("sid").toString(); 와  동일함
    String memNickname = (String) session.getAttribute("memNickname");
                                           
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <title>디자인케이크 상세페이지</title>
    
    <style>
	@font-face {
    font-family: 'NanumSquareNeoLight';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.ttf) format("truetype");
}

@font-face {
    font-family: 'NanumSquareNeo';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.ttf) format("truetype");
}

@font-face {
    font-family: 'NanumSquareNeoBold';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.ttf) format("truetype");
}

@font-face {
    font-family: 'NanumSquareNeoExtraBold';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.ttf) format("truetype");
}

@font-face {
    font-family: 'NanumSquareNeoHeavy';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.ttf) format("truetype");
}

@font-face {
    font-family: 'NanumSquareNeoVariable';
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.eot);
    src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.eot?#iefix) format("embedded-opentype"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.woff) format("woff"), url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.ttf) format("truetype");
}
body{
		background-color: #FFF6ED;
		font-family: 'NanumSquareNeo', sans-serif;
		width: 1440px;
		margin: 0 auto;
		overflow-x: hidden;
	}
a{
	text-decoration: none;
}

.header-nav-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

header {
    display: flex;
    flex-direction: column; /* 세로로 배치 */
    align-items: center; /* 로고 중앙 정렬 */
    width: 100%;
    max-width: 1200px;
    position: relative;
	height:100px;
}

.header_img {
    width:110px;
    height: 110px;
	margin-top:-40px;
}

/* 로그인, 마이페이지, 장바구니 */
#header2 {
    position: absolute;
    top: 32px;
    right: -70px; 
    display: flex;
    align-items: center;
    justify-content: center;
}

#header2 p a {
    text-decoration: none;
    color: #744731;
    margin-right: 5px;
	font-size: 12px;
}


#header2 img {
    width: 20px;
    height: 20px;
    margin-left: 5px;
}

/* 네비게이션 */
nav {
    display: flex;
    justify-content: center; /* 메뉴 왼쪽으로 정렬 */
    align-items: center;
    margin-left: -20px; /* 메뉴를 왼쪽으로 조금 이동 */
    width: 100%; /* 메뉴가 전체 너비를 차지하도록 설정 */
	height:40px;
	margin-top:-50px;
	margin-bottom:-10px;
}

nav ul {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
}

nav ul li {
    margin: 0 50px; /* 메뉴 간 간격 설정 */
    position: relative;
}

nav ul li a {
    display: inline-block; /* 수평 배치 */
    text-decoration: none;
    color: #C31D3B;
    font-size: 16px;
    font-weight: bold;
    padding: 10px 15px; /* 패딩 추가 */
}

nav ul li a:hover {
    color: #744731; /* hover 시 텍스트 색상 변경 */
}

/* 서브메뉴 스타일 */
/* 서브메뉴 기본적으로 숨김 */
.sub {
    display: none;
    position: absolute;
    top: 70px;
    left: 50%;
    transform: translateX(-50%);
    background-color: #C31D3B;
    opacity: 0.9; /* 90% 투명도 적용 */
    z-index: 1000;
    padding: 10px;
    width: 1440px;
    height: 90px;
}


/* nav에 마우스를 올리면 모든 서브메뉴가 보이게 */
.menu_area:hover .sub {
    display: block;
}

/* 서브메뉴 내부 스타일 */
.sub ul {
    list-style: none;
    padding: 0;
    margin: 0;
	flex-direction: column; /* 세로 정렬 */
	display: flex;
	margin-left:40px;
}

.sub ul li {
    margin: 5px 0;
	position: relative;
}

.sub1 {
    margin-left: 180px;
	margin-top:-10px;
	position: relative;
    display: inline-block;
}
.sub1 li:last-child {
	margin-left:-8px;
	margin-top:-10px;
	position: relative;
    display: inline-block;
}

.sub3 {
    margin-left: 855px; 
	margin-top: -50px; 
}

.sub3 li:nth-child(2), .sub3 li:last-child {
    margin-left: -7px; 
	margin-top:-10px;
}
.sub2{
	 margin-left: 398px; 
	margin-top: -80px; 
}

.sub4 {
    margin-left: 1073px; 
	margin-top: -114px; 
}

.sub ul li a {
    display: block;
    text-decoration: none;
    color: #FFF6ED;
    font-size: 16px;
    padding: 10px 15px;
}

.sub ul li a:hover {
    color: #744731;
}
.sub div {
    margin-right: 20px; /* 서브메뉴 사이 간격 */
}

.sub div:last-child {
    margin-right: 0; /* 마지막 요소의 오른쪽 여백 제거 */
}                                                              
.sub li {
    position: relative;
    display: flex;
    align-items: center;
}

/* a 태그 스타일 */
.sub li a {
    display: inline-block;
    text-decoration: none;
    color: #FFF6ED;
    font-size: 16px;
    padding: 10px 15px;
}

/* candle.png 기본적으로 숨김 */
.sub li a::after {
    content: '';
    display: inline-block;
    margin-left: 0px; /* 텍스트와의 간격 */
    width: 20px;
    height: 20px;
    background-image: url('images/candle.png');
    background-size: contain;
    background-repeat: no-repeat;
    opacity: 0;
    position: absolute;
    top: 55%; 
    transform: translateY(-50%);
    transition: opacity 0.3s ease, transform 0.3s ease;
}

/* hover 시 candle.png가 자연스럽게 나타남 */
.sub li a:hover::after {
    opacity: 1;
    transform: translateY(-50%) scale(1.1); /* 살짝 커지면서 등장 */
}      
   

        form {
            display: flex;
            flex-direction: column; /* 수직 정렬 */
            align-items: center; /* 왼쪽 정렬 */
        }

        label {
			font-size: 18px;
            width: 400px; 
            text-align: center;
            margin-bottom: 5px; /* 라벨 아래 여백 */
        }
        
        select {
            width: 400px; 
            height: 30px; 
            font-size: 17px; 
            margin-bottom: 20px; /* 선택 요소 아래 여백 */
        }
		#cake_photo {
            width: 400px; 
            height: 30px; 
            font-size: 17px; 
            margin-bottom: 20px; /* 선택 요소 아래 여백 */
        }
        
		#cake_photo_preview {
            width: 400px;
            height: auto;
            margin-top: 10px;
            display: none;
            border: 1px solid #ccc;
            padding: 5px;
        }

        #cake_deliverydate {
            width: 400px; 
            height: 50px; 
            padding: 10px; 
            box-sizing: border-box;
            overflow-y: scroll; /* 수직 스크롤만 표시 */
            overflow-x: hidden; /* 수평 스크롤 숨김 */
            font-size: 17px;
            margin-bottom: 20px;
        }
        
		
		#cake_message{  /* 특별 요청사항 */
			width: 400px; 
            height: 80px; 
            padding: 10px; 
            box-sizing: border-box;
            overflow-y: scroll; /* 수직 스크롤만 표시 */
            overflow-x: hidden; /* 수평 스크롤 숨김 */
            font-size: 15px;
			margin-bottom: 20px;
			font-family: sans-serif;
		}
        
        #date {
            width: 400px;
            margin-bottom: 20px;
            height: 30px;
			font-family: sans-serif;
        }
        
        .button_container {
            display: flex; 
            justify-content: space-between; /* 양쪽 끝으로 배치 */
            width: 440px; 
            margin-top: 40px; 
			margin-bottom:50px;
        }
        .cart_button{
			width: 440px; 
            padding: 10px; 
            font-size: 17px; 
			font-family: 'NanumSquareNeoBold', sans-serif;
			background-color: #FFF6ED;
			color: #C31D3B;
			border: 2px solid #C31D3B;
			border-radius: 30px;
		}
        .buy_button {
            width: 200px; 
            padding: 10px; 
            font-size: 17px; 
			font-family: 'NanumSquareNeoBold', sans-serif;
			background-color: #C31D3B;
			color: #fff;
			border: none;
			border-radius: 30px;
        }


.wrapper {
    display: flex; /* 가로로 배치 */
    width: 1440px; /* 총 넓이 설정 */
    height: auto; /* 화면 높이에 맞춰 전체 높이 설정 (100vh) */
    margin: 0 auto; /* 중앙 정렬 */
    justify-content: center; /* 콘텐츠를 중앙으로 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
	margin-bottom: 100px;

}

.content1 {
    display: flex;
    flex-direction: column; /* 세로 방향으로 배치 */
    height: 100%; /* 전체 높이 사용 */
    margin-left: 20px; /* canvas와의 간격 조정 */
	margin-top: 10px;
}

.cake_detail {
    width: 600px; 
    height: 200px; 
    background-color: #FFF6ED; 
    margin: 0; 
}
	.cake_detail img{
		width: 640px;
		height: 640px;
	}

.form_container {
            width: 600px;
            background-color: #FFF6ED;
            margin-top: -55px; 
            border: 1px solid #C31D3B;
            padding: 20px;
            box-sizing: border-box;
        }
.cake_detail-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
}

.cake_images {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

#canvas {
    width: 500px; 
    height: 800px; 
    background-color: #FFF6ED; 
    margin: 0; 
    align-self: flex-start; /* canvas를 왼쪽 정렬 */
	margin-top: 30px;
}

#mainImage {
    width: 500px;
    height: auto;
}
        #cake_lettering {  /* 레터링 */
            width: 400px; 
            height: 80px; 
            padding: 10px; 
            box-sizing: border-box;
            overflow-y: scroll; /* 수직 스크롤만 표시 */
            overflow-x: hidden; /* 수평 스크롤 숨김 */
            font-size: 15px;
			font-family: sans-serif;
			margin-bottom:20px;
        }

.thumbnail-images img {
    width: 178px;
    height: auto;
    cursor: pointer;
}

.cake_info {
    width: calc(100% - 620px); /* Adjusted width to account for image */
    padding-left: 20px;
}

.sub_image {
    margin-top: 10px;
    display: flex;
    gap: 20px;
}

.sub_image img {
	width:152px;
	height:auto;
}
			#footer {
                width: 1440px;
                height: 250px;
                background-color: #C31D3B;
                display: flex; 
                justify-content: space-between;
                align-items: center;
                color: #fff;
                box-sizing: border-box;
                padding: 50px;
                text-decoration: none;
            }

            #footer img {
                width: 70px;
                height: auto;
            }

            .footer-1,
            .footer-2 {
                flex: 1; /* 각 요소가 같은 비율로 공간 차지 */
                text-align: left;
            }

            #footer a {
                text-decoration: none; 
                color: #fff;
            }

            #footer a:hover {
                text-decoration: underline;
                color: #744731;
            } 

			a{
        text-decoration:none;
    }
	
			
			
			#content_1 {
                width: 1440px;
                height: auto; 
                background-color: #fff6ed;
                display: flex;
                flex-direction: column; 
                justify-content: center; 
                align-items: center;
                text-align: center;
            }
			
			#content_1 img{
				width:1440px;
				height:auto;
				justify-content: center; 
                align-items: center;
			}

            #content_1 b {
                font-size: 30px;
                color: #C31D3B;
				font-family: 'NanumSquareNeoExtraBold', sans-serif;
            }

            #content_1 p {
                font-size: 16px;
                color: #C31D3B;
				margin-top:15px;
            }
			
			#history_container{
				width: 1440px;
				height: 35px;
				display: flex;
				justify-content: center; 
				text-align: center; 
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			.history {
				width: 1100px;
				height: 35px; 
				display: flex;
				justify-content: center; 
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			.history p {
				font-size: 15px;
				color: #C31D3B;
				font-family: 'NanumSquareNeoExtraBold', sans-serif;
				position: absolute; 
				bottom: 0; /* 아래에서 위치 설정 */
				right: 0; /* 오른쪽에서 위치 설정 */
				margin: 0; /* 기본 마진 제거 */
				margin-bottom:5px;
			}
			

    </style>
</head>
<body>

   <div class="header-nav-container">
    <header>
        <div id="header2">
    <div style="display: flex; align-items: center;">
    <% if (id != null) { %>
        <a href="Logout.jsp"><img src="images/logout.png" alt="logout"></a>
    <% } else { %>
        <a href="Login.jsp" style="color: #744731; font-size: 12px; font-family: 'NanumSquareNeo', sans-serif; margin-top:-2px; margin-right:5px;">로그인 / 회원가입</a>
    <% } %>
    <a href="Mypage.jsp"><img src="images/mypage_red.png" alt="mypage"></a>
    <a href="Cart.jsp"><img src="images/cart.png" alt="cart"></a>
</div>

</div>
    </header>
    <nav class="menu_area">
    <ul class="menu">
        <li><a href="CakeDrawing.jsp">나만의 케이크</a></li>
        <li><a href="CakeBest.jsp">인기 케이크</a></li>
        <li><a href="Index.jsp"><img src="images/logo.png"  class="header_img"></a></li>
        <li><a href="CakeBirth.jsp">행복한 케이크</a></li>
        <li><a href="Review.jsp">고객 후기</a></li>
    </ul>
    
    <div class="sub">
        <ul>
		<div class="sub1">
            <li><a href="CakeDrawing.jsp">도안 케이크</a></li>
            <li><a href="CakeDesign.jsp">디자인 케이크</a></li>
		</div>
		<div class="sub2">
            <li><a href="CakeBest.jsp">인기 케이크</a></li>
        </div>
		<div class="sub3">
            <li><a href="CakeBirth.jsp">생일 케이크</a></li>
            <li><a href="CakeWedding.jsp">결혼식 케이크</a></li>
            <li><a href="CakeAnni.jsp">기념일 케이크</a></li>
		</div>
		<div class="sub4">
            <li><a href="Review.jsp">고객 후기</a></li>
		</div>
        </ul>
    </div>
</nav>
</div>

<div id="content_1">
	<img src="images/titlebar_custom.jpg">
</div>


<div id="history_container">
	<div class="history">
		<p>커스텀 케이크 > 도안 케이크</p>
	</div>
</div>


<div class="wrapper">
<div id="canvas">
<div id="imageWrapper">
    <img id="mainImage" src="images/drawingCake.png">
</div>
			</div>
    <div class="content1">    
        <div class="cake_detail">
            <p style="color:#C31D3B; font-size: 25px; font-family: 'NanumSquareNeoExtraBold', sans-serif;">도안 케이크</p>
            <p style="color:#744731; font-size: 20px; font-family: 'NanumSquareNeoBold', sans-serif;">0원(주문시 별도 가격 안내)</p>
            <p style="font-size: 14px; color: #744731;">배송비 : 기본 3,000원</p>
        </div>
    

    <div class="form_container">   <!--옵션폼-->
        <form action="CartAdd.jsp" method="post" enctype="multipart/form-data">

		<input type="hidden" name="prdName" value="도안 케이크">
		<input type="hidden" name="prdPrice" value="0">
            
            <label for="cake_photo" style="margin-top: 20px;">도안 사진</label>
			<input type="file" id="cake_photo" name="prdDesign" accept="image/*" required onchange="previewImage(event)" style="margin-bottom:-10px;">
        <img id="cake_photo_preview" alt="이미지 미리보기">
		<label for="cake_size" style="margin-top: 20px;">케이크 사이즈</label>
            <select id="cake_size" name="prdCakesize" onchange="updateSizePrice()">
                <option value="1호(+0)">1호(+0)</option>
                <option value="2호(+5,000)">2호(+5,000)</option>
                <option value="3호(+10,000)">3호(+10,000)</option>
            </select>
			<input type="hidden" name="prdSizeprice" id="prdSizeprice" value="0">
			
            <label for="cake_flavor">케이크 맛</label>
            <select id="cake_flavor" name="prdTaste">
                <option value="바닐라시트 + 우유 생크림">바닐라시트 + 우유 생크림</option>
                <option value="바닐라시트 + 초코 생크림">바닐라시트 + 초코 생크림</option>
                <option value="바닐라시트 + 녹차 생크림">바닐라시트 + 녹차 생크림</option>
                <option value="초코시트 + 우유 생크림">초코시트 + 우유 생크림</option>
                <option value="초코시트 + 초코 생크림">초코시트 + 초코 생크림</option>
                <option value="초코시트 + 녹차 생크림">초코시트 + 녹차 생크림</option>
            </select>
            <!-- 초 추가 구매 -->
<label for="cake_candle">초 추가구매</label>
<select id="cake_candle" name="prdCandle" onchange="updateCandlePrice()"> 
    <option value="초 구매 안함">초 구매 안함(+0)</option>
    <option value="일반초 5개입 세트(+1,000)">일반초 5개입 세트(+1,000)</option>
    <option value="하트초(+1,000)">하트초(+1,000)</option>
    <option value="스마일초(+1,000)">스마일초(+1,000)</option>
</select>
<input type="hidden" name="prdCandleprice" id="prdCandleprice" value="0">

<!-- 보냉포장 -->
<label for="cake_cooling">보냉포장</label>
<select id="cake_cooling" name="prdCooling" onchange="updateCoolingPrice()">
    <option value="보냉포장 X (5~8월에 선택시 자동 주문취소)" >보냉포장 X (5~8월에 선택시 자동 주문취소)</option>
    <option value="보냉포장 O (+2,000)">보냉포장 O (+2,000)</option>
</select>
<input type="hidden" name="prdCoolingprice" id="prdCoolingprice" value="0">

            
            <label for="cake_deliverydate">상품 발송 날짜 선택</label>
            <input type="date" id="date" name="prdDeliverydate" required>

			<label for="cake_lettering">레터링(케이크 윗부분 글씨)</label>
            <textarea id="cake_lettering" name="prdLettering" 
            placeholder="케이크 윗부분에 들어갈 글씨입니다. 비워두시면 공백으로 제작됩니다. 한글 10글자, 영문 20자 이내"></textarea>
            
            <label for="cake_message">특별 요청 사항</label>
            <textarea id="cake_message" name="prdMessage" 
            placeholder="알레르기 또는 요청사항 적어주시면 최대한 맞춰서 제작해드립니다."></textarea>
            
            <div class="button_container">
                <button class="cart_button" type="submit">장바구니</button> 
                <!--<button class="buy_button" type="submit">구매하기</button>-->
            </div>
        </form>
    </div>	 <!--<div class="form_container">의 닫는곳-->
	</div> <!-- <div class="content1">의 닫는곳 -->
</div>   <!--<div class="wrapper">의 닫는곳 -->


    <script>
	
   //date 날짜 선택 범위 제한하는 코드
   window.addEventListener("DOMContentLoaded", function() {
        const dateInput = document.getElementById("date");
        
        if (!dateInput) {
            console.error("[오류] 날짜 입력 필드를 찾을 수 없습니다.");
            return;
        }
        console.log("[확인] 날짜 입력 필드가 정상적으로 로드되었습니다.");

        try {
            // 오늘 날짜 가져오기
            const today = new Date();
            console.log("[확인] 오늘 날짜:", today.toString());

            // 최소 5일 후, 최대 28일 후
            const minDate = new Date(today.getTime() + (5 * 24 * 60 * 60 * 1000));
            const maxDate = new Date(today.getTime() + (28 * 24 * 60 * 60 * 1000));

            console.log("[확인] 최소 날짜 객체:", minDate.toString());
            console.log("[확인] 최대 날짜 객체:", maxDate.toString());

            // YYYY-MM-DD 형식으로 변환
            const formatDateString = (date) => {
                const year = String(date.getFullYear());
                const month = String(date.getMonth() + 1).padStart(2, '0');
                const day = String(date.getDate()).padStart(2, '0');
                
                // 형식 변환 결과 출력
                const formattedDate = year + '-' + month + '-' + day;
                console.log("[디버그] 변환된 날짜:", formattedDate);
                
                // 최종 문자열 반환
                return formattedDate;
            };

            // 형식 변환
            const formattedMinDate = formatDateString(minDate);
            const formattedMaxDate = formatDateString(maxDate);
            
            console.log("[확인] 포맷된 최소 날짜:", formattedMinDate);
            console.log("[확인] 포맷된 최대 날짜:", formattedMaxDate);

            // 필드 설정
            dateInput.setAttribute("min", formattedMinDate);
            dateInput.setAttribute("max", formattedMaxDate);
            
            // 최종 설정 확인
            console.log("[확인] dateInput.min:", dateInput.getAttribute("min"));
            console.log("[확인] dateInput.max:", dateInput.getAttribute("max"));

        } catch (error) {
            console.error("[오류] 날짜 설정 중 예외 발생:", error);
        }
    });
	
	</script>
	
	
    <div id="footer">
            <div class="footer-1">
                <img src="images/logo_white.png" />
                <p>고객센터</p>
                <b>02-339-9947</b>
                <p>평일 AM 10:00 ~ PM 20:00 주말, 공휴일 휴무</p>
            </div>
            <div class="footer-2">
                <p><a href="Footer_policy.jsp">이용약관</a> | <a href="Footer_per_info.jsp">개인정보처리방침</a> | <a href="Footer_email.jsp">이메일무단수집거부</a></p>
                <p>
                    오롯이 케이크 / 레터링 CAKE | 통신판매업신고번호 : 2025 - 서울마포 - 0061 | 사업자등록번호 : 120 - 99 -
                    48278 주식회사 오롯이케이크
                </p>
                <p>주소 : 서울시 마포구 연남동 334-25번지 2층 | 대표자: 이장 | 전화번호 : 02 - 339 - 9947</p>
                <p>Copyright onlycake. All Rights Reserved.</p>
            </div>
        </div>

	<script>
function switchImage(thumbnail) {
    const mainImage = document.getElementById('mainImage');
    mainImage.src = thumbnail.src;
}
</script>
<script>
    function previewImage(event) {
        const input = event.target;
        const preview = document.getElementById("cake_photo_preview");

        if (input.files && input.files[0]) {
            const reader = new FileReader();

            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";
            };

            reader.readAsDataURL(input.files[0]);
        } else {
            preview.src = "";
            preview.style.display = "none";
        }
    }
</script>

</body>
</html>
