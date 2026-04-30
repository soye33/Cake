<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<%
    String id = (String) session.getAttribute("sid");
	String memNickname = (String) session.getAttribute("memNickname");

    if (id == null || id.isEmpty()) {
%>
    <script>
        alert("로그인을 먼저 해주세요.");
        location.href = "Login.jsp";
    </script>
<%
    return; // 이후 코드 실행을 방지
}
%>

    <meta charset="EUC-KR">
    <title>문의 작성하기</title>
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
	/* 헤더 스타일 */
/* 헤더 & 네비게이션 컨테이너 */
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
    top: -1px;
    right: 5px; 
    display: flex;
    align-items: center;
    justify-content: center;
	margin-bottom: 100px;
}

#header2 p a {
    text-decoration: none;
    color: #744731;
    margin-right: 10px;
	font-size:12px;
}

#header2 p {
	margin-top:20px;
}

#header2 img {
    width: 30px;
    height: 30px;
    margin-left: 10px;
	margin-top:11px;
}

/* 네비게이션 */
nav {
    display: flex;
    justify-content: center; /* 메뉴 왼쪽으로 정렬 */
    align-items: center;
    margin-left: -30px; /* 메뉴를 왼쪽으로 조금 이동 */
    width: 100%; /* 메뉴가 전체 너비를 차지하도록 설정 */
	height:40px;
	margin-top:-42px;
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
    top: 80px;
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
	margin-left:20px;
}

.sub ul li {
    margin: 5px 0;
	position: relative;
}

.sub1 {
    margin-left: 190px;
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
    margin-left: 880px; 
	margin-top: -50px; 
}

.sub3 li:nth-child(2), .sub3 li:last-child {
    margin-left: -7px; 
	margin-top:-10px;
}
.sub2{
	 margin-left: 416px; 
	margin-top: -80px; 
}

.sub4 {
    margin-left: 1080px; 
	margin-top: -113px; 
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


.left-menu {
    width: 250px;
    margin-right: 5px;
    height: 100%; 
}

.left-menu h1{
	font-size: 28px;
    padding-top: 90px;
    padding-bottom: 40px;
    color: #C31D3B;
	margin-left:100px;
	margin-bottom:10px;
}

.left-menu a {
    color: #744731;
    font-size: 20px;
    text-decoration: none;
    font-weight: bold;
	margin-left:100px;
	margin-bottom:10px;
}

.left-menu #small_menu {
    display: block;
    color: #744731;
    font-size: 18px;
    text-decoration: none;
	margin-top:20px;
	margin-bottom:35px;
}

.left-menu #small_menu:hover {
	color: #C31D3B;
	text-decoration: underline;
}


/* 수직 hr */
.vertical-line {
    width: 1px;
    background-color: #744731;
    margin: 90px 20px;
    flex-shrink: 0;
    height: 600px;
}

hr {
    border: none; /* 기본 테두리 제거 */
    border-top: 2px solid #C31D3B;
    margin-top: -80px;
    height: 0; /* 높이를 0으로 설정하여 선만 보이게 함 */
    width: 100%; 
}

.container {
    width: 1440px;
    display: flex;
    align-items: flex-start;
    height: auto; 
}

.title {
    font-size: 64px;
    text-align: center;
    color: #C31D3B;
	margin-top:100px;
}
.person-information {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 요소를 양쪽 끝으로 배치 */
    width: 1070px;
    margin: 0 auto;
}

.person-information img {
    width: 74px;
    height: 74px;
}

.person-information p {
    font-size: 36px;
    color: #744731;
    margin: 0;
    flex-grow: 1; /* 닉네임이 중앙에 위치하도록 유동적으로 배치 */
    margin-left: 20px;
}

.person-information span {
    font-size: 36px;
    color: #744731;
    margin: 0;
    text-align: right; /* 오른쪽 정렬 */
    min-width: 150px; /* 최소 너비 지정 (조정 가능) */
}

.form-content  {
    width: 1070px; /* 원하는 크기로 조정 */
    height: 90px; /* 높이 조정 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 5px 10px;
	align-items: center;
    justify-content: center;
	display: flex;
    flex-direction: row;
	margin-top:10px;
}

.form-content3  {
    width: 1070px; /* 원하는 크기로 조정 */
    height: 90px; /* 높이 조정 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 5px 10px;
    flex-direction: row;
	margin-top:10px;
	display: flex; /* Flexbox 활성화 */
    align-items: center; /* 수직 정렬 */
    justify-content: flex-start; /* 텍스트를 왼쪽 정렬 */
    text-align: left; 
}

.form-content2{
	width: 1070px; /* 원하는 크기로 조정 */
    height: 470px; /* 높이 조정 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 5px 10px;
	align-items: center;
    justify-content: center;
	display: flex;
    flex-direction: row;
	margin-top:10px;
}
.form-content-pass {
    width: 1070px; /* 원하는 크기로 조정 */
    height: 90px; /* 높이 조정 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 5px 10px;
    display: flex; /* Flexbox 적용 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: flex-start; /* 내부 요소를 왼쪽 정렬 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    margin: 10px auto; /* 자동 마진을 사용하여 부모 요소 기준으로 중앙 정렬 */
    gap: 20px; /* label과 input 간격 추가 */
}

.form-content-pass label {
    font-size: 36px;
    color: #744731;
    white-space: nowrap; /* 줄 바꿈 방지 */
    min-width: 150px; /* label의 최소 너비 지정 (조절 가능) */
    text-align: left; /* 왼쪽 정렬 */
	margin-left:30px;
}

.form-content-pass input[type="password"] {
    flex-grow: 1; /* 남은 공간을 모두 차지 */
    height: 80px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
    font-size: 32px;
    color: #744731;
    padding: 0 10px; /* 안쪽 여백 추가 */
    text-align: left; /* 입력값 왼쪽 정렬 */
}

.form-content-pass input[type="password"]::placeholder {
    color: #744731; /* placeholder 색상도 동일하게 */
    opacity: 0.7; /* 조금 연하게 */
    font-size: 32px;
    font-family: 'NanumSquareNeo', sans-serif;
}


.inquiry{
	display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
	flex-direction: column;
}

.form-content label{
	font-size:36px;
	margin-left:30px;
	color: #744731;
}

.form-content input[type="text"] {
    height: 80px;
	width:800px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
	font-size: 32px;
	position: relative;
    left: -110px; /* Move left by 100px */
}

.form-content input[type="text"]::placeholder{
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-size: 32px;
	font-family:'NanumSquareNeo', sans-serif;
}

.form-content3 label{
	font-size:36px;
	margin-left:30px;
	color: #744731;
}

.form-content3 select {
	font-size: 32px;
	margin-left:30px;
	height:50px;
	width:640px;
	font-family:'NanumSquareNeo', sans-serif;
	color: #744731;
}

.form-content2 textarea {
    height:400px;
	width:1000px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
	font-size: 32px;
	resize: none;
}

.form-content2 textarea::placeholder{
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-size: 32px;
	font-family:'NanumSquareNeo', sans-serif;
	position: absolute;
    top: 30px;
    left: 10px;
    transform: translateY(-50%);
}

	#footer {
                width: 100%;
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
				width: 130px;
				height: auto;
				}

	.footer-1,
	.footer-2 {
                flex: 1; / 각 요소가 같은 비율로 공간 차지 /
                text-align: left; / 텍스트 왼쪽 정렬 /
				}

	#footer a {
				text-decoration: none; / 밑줄 제거 /
				color: #fff; / 글씨 색상 변경 (필요시 수정 가능) /
				}

            #footer a:hover {
                text-decoration: underline; 
                color: #c31d3b; 
            }
        .create {
            display: block;
            width: 300px;
            height: 80px;
            font-size: 30px;
            margin-left: 570px;
            margin-top: 100px;
            margin-bottom: 88px;
            background-color: #C31D3B;
            color: white;
            border: none;
            border-radius: 64px;
            cursor: pointer;
        }
		.photo{
			align-items: center;
			justify-content: center;
			display: flex;
			flex-direction: row;
            width: 1100px;
            height: 80px;
            font-size: 30px;
            margin-top: 30px;
            border: 2px solid #C31D3B;
            color: #C31D3B;
            border-radius: 10px;
            cursor: pointer;
			background-color: #FFF6ED;
		}
    </style>
</head>
<body>
   <div class="header-nav-container">
    <header>
        <div id="header2">
    <% if (id != null) { %>
        <a href="Logout.jsp"><img src="images/logout.png" alt="logout"></a>
        <a href="Mypage.jsp"><img src="images/mypage_red.png" alt="mypage"></a>
        <a href="Cart.jsp"><img src="images/cart.png" alt="cart"></a>
    <% } else { %>
        <p><a href="Login.jsp">로그인 / 회원가입</a></p>
        <a href="Mypage.jsp"><img src="images/mypage_red.png" alt="mypage"></a>
        <a href="Cart.jsp"><img src="images/cart.png" alt="cart"></a>
    <% } %>
</div>
        </div>
    </header>
    <nav class="menu_area">
    <ul class="menu">
        <li><a href="CakeDrawing.jsp">커스텀 케이크</a></li>
        <li><a href="CakeBest.jsp">인기 케이크</a></li>
        <li><a href="Index.jsp"><img src="images/logo.png"  class="header_img"></a></li>
        <li><a href="CakeBirth.jsp">행복한 케이크</a></li>
        <li><a href="Review.jsp">후기</a></li>
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
<div class="container">
    <div class="left-menu">
        <a href="Mypage.jsp"><h1>마이페이지</h1></a>
        <aside class="left-menu">
            <a href="Mypage.jsp" id="small_menu">정보 수정 및 탈퇴</a>
            <a href="DeliveryHistory.jsp" id="small_menu">주문/배송 내역</a>
            <a href="Cart.jsp" id="small_menu">장바구니</a>
            <a href="Wishlist.jsp" id="small_menu">위시리스트</a>
            <a href="Review.jsp" id="small_menu">후기 모아보기</a>
            <a href="Mypage_PossibleReview.jsp" id="small_menu" style="color: #C31D3B;">작성 가능한 후기</a>
            <a href="Mypage_WrittenReview.jsp" id="small_menu">작성한 후기</a>
        </aside>
    </div>
    
    <hr class="vertical-line">
    
    <div class="content">
        <div class="content2">
            <h2 class="title">후기 작성하기</h2>
			<form method="post" action="InsertReview_Ok.jsp" enctype="multipart/form-data">

			<div class="information">
				
			</div>
            
            <div class="star">
				
			</div>
			<div class="form-content4">
    <label for="photoUpload" class="photo" style="font-family: 'NanumSquareNeoBold', sans-serif; cursor: pointer;">
        사진 첨부하기
    </label>
    <input type="file" id="photoUpload" accept="image/*" style="display: none;" name="photoUpload">
    <div id="fileInfo" style="margin-top: 10px; font-family: 'NanumSquareNeoBold', sans-serif;"></div>
    <img id="previewImage" src="" alt="미리보기" style="display: none; width: 150px; margin-top: 10px;">
			</div>
			</div>
            
        </div>
    </div>
	
    <div class="container2">
        <button type="submit" class="create" style="font-family: 'NanumSquareNeoBold', sans-serif;">후기 등록하기</button>
    </div>
	</form>
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
    document.addEventListener("DOMContentLoaded", function () {
        let today = new Date();
        let formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        document.getElementById("currentDate").textContent = formattedDate;
    });
</script><script>
    document.getElementById("photoUpload").addEventListener("change", function(event) {
        const file = event.target.files[0];
        const fileInfo = document.getElementById("fileInfo");
        const previewImage = document.getElementById("previewImage");

        if (file) {
            fileInfo.textContent = `${file.name}`;

            const reader = new FileReader();
            reader.onload = function(e) {
                previewImage.src = e.target.result;
                previewImage.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            fileInfo.textContent = "";
            previewImage.style.display = "none";
        }
    });
</script>
</body>
</html>