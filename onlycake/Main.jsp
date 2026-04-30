<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, java.text.NumberFormat, java.util.Locale" %>

<%
    NumberFormat numberFormat = NumberFormat.getInstance(Locale.KOREA);
%>
<%
    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd"; 

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<Map<String, String>> anniversaryCakes = new ArrayList<>();

    try {
        // MySQL 드라이버 로드
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // "기념일 케이크" 카테고리 상품 가져오기 (랜덤 10개)
        String sql = "SELECT prdNo, prdName, prdImage, prdPrice FROM cake WHERE ctgType = '기념일케이크' ORDER BY RAND() LIMIT 10";

        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> cake = new HashMap<>();
			cake.put("prdNo", rs.getString("prdNo"));
            cake.put("name", rs.getString("prdName")); 
            cake.put("image", rs.getString("prdImage"));  
            cake.put("price", rs.getString("prdPrice")); 
            anniversaryCakes.add(cake);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<%
    List<Map<String, String>> birthdayCakes = new ArrayList<>();

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // "생일 케이크" 카테고리 상품 가져오기 (랜덤 3개)
        String birthdaySql = "SELECT prdNo, prdName, prdImage, prdPrice FROM cake WHERE ctgType = '생일케이크' ORDER BY RAND() LIMIT 3";

        pstmt = conn.prepareStatement(birthdaySql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> cake = new HashMap<>();
			cake.put("prdNo", rs.getString("prdNo"));
            cake.put("name", rs.getString("prdName"));
            cake.put("image", rs.getString("prdImage"));
            cake.put("price", rs.getString("prdPrice"));
            birthdayCakes.add(cake);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>


                                     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/three@0.141.0/build/three.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/three@0.141.0/examples/js/controls/OrbitControls.js"></script>
<script src="https://cdn.jsdelivr.net/npm/three@0.141.0/examples/js/loaders/GLTFLoader.js"></script>
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
body {
    background-color: #FFF6ED;
    font-family: 'NanumSquareNeo', sans-serif;
    max-width: 1440px;
    width: 100%;
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
    top: 20px;
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
    margin-top: -5px;
}


#header2 img {
	margin-top:-2px;
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
	position: relative;
}

nav ul {
    display: flex;
    list-style: none;
    padding: 0;
    margin: 0;
	
}
nav ul li {
    margin: 0 clamp(5px, 4vw, 50px); /* 최소 10px, 최대 50px까지 반응형 */
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
}

.sub ul li {
    margin: 5px 0;
	position: relative;
}

.sub {
    display: none;
    justify-content: center;
    background-color: #C31D3B;
    opacity: 0.95;
    width: 100%;
    height: 90px;
    padding: 10px 0;
    position: absolute;
    top: 50%; /* nav 아래 */
    left: 0;
    z-index: 1000;
	margin-left:10px;
}

.submenu-wrapper {
    display: flex;
    justify-content: center; /* 또는 flex-start */
    align-items: flex-start;
    gap: 100px; /* 이 값으로 간격을 조정하세요 (20~40px 추천) */
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.sub1, .sub2, .sub3, .sub4, .sub5 {
    flex: none;
    width: auto;
    text-align: center;
    white-space: nowrap; /* 줄바꿈 방지로 폭 최소화 */
}

.sub1 {
margin-left:-20px;
}


.sub1 ul,
.sub2 ul,
.sub3 ul,
.sub4 ul,
.sub5 ul
{
    text-align: center;
    align-items: center;
}

.sub1 ul li,
.sub2 ul li,
.sub3 ul li,
.sub4 ul li,
.sub5 ul li
{
	margin-top:-10px;
}


.sub ul li a {
    display: block;
    text-decoration: none;
    color: #FFF6ED;
    font-size: 16px;
}

.sub ul li a:hover {
    color: #744731;
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
                                                      
.back {
    background-image: url('images/back.jpg');
    background-repeat: repeat-y;       
    background-size: 1500px auto;     
    min-height: 100vh; /* 최소 화면 전체 높이로 설정 */
}

.part1 {
    display: flex;
    flex-direction: column;
    align-items: center; /* Center align horizontally */
    justify-content: center; /* Center align vertically */
}

.part1_name {
    width: 80%;
    height: auto;
    margin: 0 auto; /* Ensure it's centered */
}


/* 캐러셀 전체 컨테이너 */
.carousel-container {
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    width: 100%;
    overflow: hidden;
    padding: 20px 0;
	margin-top:-20px;
	height:auto;
}

/*  캐러셀 내부 슬라이드 영역 */
.carousel {
    display: flex;
    overflow-x: auto;
    scroll-behavior: smooth;
    white-space: nowrap;
    padding-bottom: 10px;
    scrollbar-width: none; /* Firefox에서 스크롤바 제거 */
}

.carousel::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Edge 등에서 스크롤바 숨김 */
}

.cake-item {
    width: clamp(160px, 22vw, 250px); /* 반응형 가로폭 */
    margin: 20px;
    flex-shrink: 0;
    border: 10px solid #fff;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.5);
    background: white;
    overflow: hidden;
    border-radius: 5px;
    position: relative;
    display: flex;
    flex-direction: column;
    transition: transform 0.3s ease-in-out;
	align-self: flex-start;
}

.cake-item:hover {
    transform: scale(1.05);
}

.cake-item::before {
    content: '';
    display: block;
    padding-top: 150%; /* 이미지 높이 확보용 (정사각형) */
}

.cake-item > a {
    position: absolute;
    inset: 0;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
    align-items: center;
    padding: 10px;
    box-sizing: border-box;
    text-align: center;
}

.cake-item:nth-child(even) {
    margin-top: 40px;
	align-self: flex-end;
}
.cake-item:nth-child(odd) {
    margin-top: 0;
}


.cake-item:hover {
    transform: scale(1.05);
}

.cake-item img {
    width: 100%;
    aspect-ratio: 1 / 1; /* 정사각형 이미지 비율 유지 */
    object-fit: cover;
    border-radius: 2px;
}

.cake-name {
    font-size: clamp(14px, 1.2vw, 18px);
    font-weight: bold;
    color:  #C31D3B;
    margin: 10px 5px 5px 5px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
	width: 90%;
}

.cake-price {
    font-size: clamp(13px, 1vw, 16px);
    color: #744731;
}


/* 좌우 버튼 스타일 (폴라로이드 컨셉 유지) */
.prev-btn, .next-btn {
	width:70px;
	height:70px;
    cursor: pointer;
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    z-index: 10;
    transition: background 0.3s, transform 0.2s;
}

.prev-btn { left: 2px; }
.next-btn { right: 2px; }

.part_image1 {
	width:744px;
	height:132px;
}
.part2 {
    position: relative;
    background-image: url('images/invitation.png');
    background-size: contain;
    background-position: center top;
    background-repeat: no-repeat;
    width: 100%;
    height: 0;
    padding-top: 60%; /* 비율 유지 */
}

.part2_content {
    position: absolute;
    top: 0%; /* 배경과 겹치는 부분 조정 */
    left: 40%;
    transform: translateX(-50%);
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
}

.birthday-item {
    display: flex;
    flex-direction: row;
    align-items: center;
    background: white;
    border-radius: 2px;
    box-shadow: 5px 5px 10px rgba(0, 0, 0, 0.1);
    width: 60%;
    max-width: 90vw;  /* 화면 크기 기준으로 줄어들게 */
    margin: 10% auto -11% 43vw;
    padding: 5px;
    box-sizing: border-box;
    transition: transform 0.3s ease-in-out;
    text-decoration: none;
}


.birthday-item img {
    flex-shrink: 0;
    width: 40%;
    max-width: 100%;
    height: auto;
    object-fit: contain;
    border-radius: 2px;
}


.birthday-text {
    width: 60%;
    padding-left: 20px;
    display: flex;
    flex-direction: column;
    justify-content: center;
}


.birthday-item:hover {
    transform: scale(1.03);
}


/* 텍스트 크기도 반응형으로 */
.birthday-name {
    font-size: clamp(14px, 1.2vw, 18px);
    font-weight: bold;
    color: #C31D3B;
    margin-bottom: 8px;
	overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
	width: 80%;
}

.birthday-price {
    font-size: clamp(12px, 1.1vw, 16px);
    color: #744731;
}



.part3 {
    position: relative;
    text-align: center;
    margin-top: 30px;
}

.part3_image {
    width: 100%;
    height: auto;
}

.part3_button {
	width:30%;
    position: absolute;
    bottom: 10%; /* 이미지 하단과 붙게 */
    left: 50%;
    transform: translateX(-50%);
}

.customer_service {
    position: relative;
    background-image: url('images/part4.png');
    background-repeat: no-repeat;
    background-size: 100% auto; /* 너비 기준으로 비율 유지하며 줄어듦 */
    background-position: top center;
    
    width: 100%;
    padding-top: 45%;  /* 배경 비율 조절 (이미지 세로 비율에 따라 수정 가능) */
    margin: 30px auto 50px auto;
    box-sizing: border-box;
}

.part4_button {
    position: absolute;
    bottom: 10%;  /* 배경 이미지 하단 기준에서 위로 */
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 0%;
    width: 80%;
    justify-content: center;
}


.part4_button a {
    display: flex;
    justify-content: center;
    align-items: center;
	margin-top:-15%;
}

.part4_button img {
    width: 50%; /* 부모 요소 크기에 맞춤 */
    height: auto;
}

/* 마지막 버튼에만 margin-left: 10px 적용 */
.part4_button a:last-child {
    margin-left: -10px;
}

	#footer {
                width: 100%;
				height:auto;
                max-height: 250px;
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
	
	#3d{
	 position: relative; /* 상대 위치 설정 */
	}
	
	#playButton {
    left: 0;
    font-family: 'NanumSquareNeoBold', sans-serif;
    font-size: clamp(12px, 1.5vw, 17px);
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    width: 100%;
    padding: 10px 20px;
    box-sizing: border-box;
    pointer-events: auto;
}


#playButton img {
    width: clamp(24px, 3vw, 50px);  /* 반응형 이미지 */
    height: auto;
}

#playButton_text {
    position: relative;
    left: 2%;
    font-size: clamp(12px, 1.5vw, 18px);
}

#click {
    position: relative;
    right: 2%;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: clamp(11px, 1.2vw, 16px);
}



@media screen and (min-width: 984px) and (max-width: 1243px) {
.header_img {
    width:100px;
    height: 100px;
	margin-top:-40px;
}


nav {
	margin-bottom:-30px;
}

#header2 {
	margin-top:-10px;
}

nav ul{
margin-top:-25px;
}

nav ul li a, .sub ul li a{
font-size:15px;
}

  
  .sub {
	margin-top:-15px;
  }
  
  .submenu-wrapper {
    display: flex;
    justify-content: center; /* 또는 flex-start */
    align-items: flex-start;
    gap: 80px; /* 이 값으로 간격을 조정하세요 (20~40px 추천) */
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.sub1 {
margin-left:-20px;
}


#playButton {
    margin-top:-15px;
}

}

@media screen and (min-width: 821px) and (max-width: 983px) {
.header_img {
    width:90px;
    height: 90px;
	margin-top:-40px;
}

nav {
	margin-bottom:-30px;
}

nav ul{
margin-top:-20px;}

nav ul li {
    margin-right:5px;
}

nav ul li a, .sub ul li a{
font-size:13px;
}

.sub {
margin-top:-15px;
}
  .submenu-wrapper {
    display: flex;
    justify-content: center; /* 또는 flex-start */
    align-items: flex-start;
    gap:40px; /* 이 값으로 간격을 조정하세요 (20~40px 추천) */
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.sub1 {
margin-left:10px;
}

#playButton {
    margin-top:-25px;
}
}

@media screen and (min-width: 700px) and (max-width: 820px) {
.header_img {
    width:80px;
    height: 80px;
	margin-top:-30px;
}

/* 로그인, 마이페이지, 장바구니 */
#header2 {
    position: absolute;
    top: -15px;
    right: 5px; 
    display: flex;
    align-items: center;
    justify-content: center;
	margin-bottom: 100px;
}

nav {
	margin-bottom:-35px;
}

nav ul{
margin-top:-40px;
}

nav ul li {
    margin-right:5px;
}

nav ul li a, .sub ul li a{
font-size:11px;
}
  .submenu-wrapper {
    display: flex;
    justify-content: center; /* 또는 flex-start */
    align-items: flex-start;
    gap: 35px; /* 이 값으로 간격을 조정하세요 (20~40px 추천) */
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.sub {
margin-top:-20px;
height:70px;
}

.sub1 {
margin-left:0px;
}

#playButton {
    margin-top:-25px;
}

}
@media screen and (min-width: 450px) and (max-width: 699px) {
body {
        padding: 0 10px;
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
    width: 50%;
    max-width: 600px;
    position: relative;
	height:50px;
	
}

.header_img {
    width:60px;
    height: 60px;
	margin-top:-20px;
}

/* 로그인, 마이페이지, 장바구니 */
#header2 {
    position: absolute;
    top: -1px;
    right: -100px; 
    display: flex;
    align-items: center;
    justify-content: center;
	margin-bottom: 100px;
}

#header2 p a {
    text-decoration: none;
    color: #744731;
    margin-right: 5px;
	font-size:9px;
}

#header2 p {
	margin-top:5px;
}

#header2 img {
    width: 20px;
    height: 20px;
    margin-left: 5px;
	margin-top:-5px;
}

	/* 네비게이션 */
nav {
    display: flex;
    justify-content: center; /* 메뉴 왼쪽으로 정렬 */
    align-items: center;
    margin-left: -20px; /* 메뉴를 왼쪽으로 조금 이동 */
    width: 100%; /* 메뉴가 전체 너비를 차지하도록 설정 */
	height:40px;
	margin-top:-35px;
	margin-bottom:-10px;
}

    nav ul {
        flex-direction: row;
		margin-top:15px;
    }

    nav ul li {
        margin: 0 5px; /* 메뉴 간 간격 설정 */
    }
	nav ul li a {
        font-size: 9px;
    }
	
	.sub ul li a {
    font-size: 9px;
}

.sub {
	margin-left:10px;
	height:60px;
	margin-top:5px;
}

.submenu-wrapper {
    display: flex;
    justify-content: center; /* 또는 flex-start */
    align-items: flex-start;
    gap: 10px; /* 이 값으로 간격을 조정하세요 (20~40px 추천) */
    width: 100%;
    max-width: 1440px;
    margin: 0 auto;
}

.sub1 {
margin-left:-15px;
}


.birthday-name {
    font-size: 9px;
    font-weight: bold;
    color: #C31D3B;
}

.birthday-price {    

    font-size: 7px;
    color: #744731;
}

.birthday-item {
    margin-bottom: -40px;
}

.birthday-item img {
    width: 40px;
    height: 40px;
}

		#footer {
                width: 100%;
                height: auto;
                background-color: #C31D3B;
                display: flex; 
                justify-content: space-between;
                align-items: center;
                color: #fff;
                box-sizing: border-box;
                padding: 25px;
                text-decoration: none;
				font-size:10px;
            }

            #footer img {
                width:65px;
                height: auto;
            }

	#playButton {
    margin-top:-50px;
}

#playButton_text {
    position: relative;
    left: 2%;
    font-size: 9px;
}

#click {
    position: relative;
    right: 2%;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 9px;
}
}
			</style>
</head>
<body>
   <div class="header-nav-container">
    <header>
        <div id="header2" style="margin-top:4px;">
            <p style="margin-top:8px;"><a href="Login.jsp">로그인 / 회원가입</a></p>
            <a href="Mypage.jsp">
			<img src="images/mypage_red.png" alt="mypage">
			</a>
            <a href="Cart.jsp">
			<img src="images/cart.png" alt="cart">
			</a>
        </div>
    </header>
    <nav class="menu_area">
    <ul class="menu">
        <li><a href="CakeDrawing.jsp">나만의 케이크</a></li>
        <li><a href="CakeBest.jsp">인기 케이크</a></li>
        <li><a href="Main.jsp"><img src="images/logo.png"  class="header_img"></a></li>
        <li><a href="CakeBirth.jsp">행복한 케이크</a></li>
        <li><a href="Review.jsp">고객 후기</a></li>
    </ul>

    <div class="sub">
  <div class="submenu-wrapper">
    <div class="sub1">
      <ul>
        <li><a href="CakeDrawing.jsp">도안 케이크</a></li>
        <li><a href="CakeDesign.jsp">디자인 케이크</a></li>
      </ul>
    </div>
    <div class="sub2">
      <ul>
        <li><a href="CakeBest.jsp">인기 케이크</a></li>
      </ul>
    </div>
    <div class="sub3">
      <ul>
        <li style="visibility: hidden;"><a href="#">빈칸 케이크크크</a></li>
      </ul>
    </div>
    <div class="sub4">
      <ul>
        <li><a href="CakeBirth.jsp">생일 케이크</a></li>
        <li><a href="CakeWedding.jsp">결혼식 케이크</a></li>
        <li><a href="CakeAnni.jsp">기념일 케이크</a></li>
      </ul>
    </div>
    <div class="sub5">
      <!-- 정렬을 맞추기 위한 빈 공간 -->
      <ul><li><a href="Review.jsp">고객 후기</a></li>
	  </ul>
    </div>
  </div>
</div>


</nav>
</div>

<div class="back">

	<div id="3d">
	<div id="playButton">
		<div id="playButton_text" style="display: flex; flex-direction: column;">
        <div style="margin-bottom: 5px;">
            * 스피커를 클릭하면 오롯이 케이크 테마송을 감상하실 수 있으며,
        </div>
        <div>
            &nbsp;&nbsp;&nbsp;마우스를 이용해 3D 공간을 회전하거나 이동할 수 있어요!
        </div>
    </div>
		<div id="click">
			<img src="images/left-click.png"> 회전 <img src="images/right-click.png"> 이동
		</div>
	</div>
</div>
	<div class="part1">
    <img src="images/part1_name.png" class="part1_name">

		<div class="carousel-container">
			<img src="images/prev.png" class="prev-btn">  <!-- 왼쪽 버튼 -->
			
			<div class="carousel">
				<% for (Map<String, String> cake : anniversaryCakes) { %>
    <div class="cake-item">
        <a href="detail.jsp?prdNo=<%= cake.get("prdNo") %>">
            <img src="images/<%= cake.get("image") %>" alt="<%= cake.get("name") %>">
            <p class="cake-name"><%= cake.get("name") %></p>
            <p class="cake-price"><%= numberFormat.format(Integer.parseInt(cake.get("price"))) %>원</p>
        </a>
    </div>
<% } %>

			</div>

			<img src="images/next.png" class="next-btn"> <!-- 오른쪽 버튼 -->
		</div>
	</div>
	<div class="part2">
		<div class="part2_content">
    <% for (Map<String, String> cake : birthdayCakes) { %>
    <a href="detail.jsp?prdNo=<%= cake.get("prdNo") %>" class="birthday-item">
        <img src="images/<%= cake.get("image") %>" alt="<%= cake.get("name") %>">
        <div class="birthday-text">
            <p class="birthday-name"><%= cake.get("name") %></p>
            <p class="birthday-price"><%= numberFormat.format(Integer.parseInt(cake.get("price"))) %>원</p>
        </div>
    </a>
<% } %>


</div>
	</div>
	<div class="part3">
		<img src="images/one_and.png" class="part3_image">
		<a href="CakeDesign.jsp"><img src="images/letsdesign.png" class="part3_button"></a>
	</div>
<div class="customer_service">
	<div class="part4_button">
		<a href="CustomerService_FAQ.jsp"><img src="images/part4_b1.png" class="part_b1"></a>
		<a href="CustomerService_Inquiry.jsp"><img src="images/part4_b2.png" class="part4_b2"></a>
		<a href="CustomerService_Refund.jsp"><img src="images/part4_b3.png" class="part4_b3"></a>
	</div>
</div>

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
    const carousel = document.querySelector(".carousel");
    const prevBtn = document.querySelector(".prev-btn");
    const nextBtn = document.querySelector(".next-btn");

    let isDragging = false;
    let startX, scrollLeft;

    // 드래그 기능 추가
    carousel.addEventListener("mousedown", (e) => {
        isDragging = true;
        startX = e.pageX - carousel.offsetLeft;
        scrollLeft = carousel.scrollLeft;
    });

    carousel.addEventListener("mouseleave", () => { isDragging = false; });
    carousel.addEventListener("mouseup", () => { isDragging = false; });

    carousel.addEventListener("mousemove", (e) => {
        if (!isDragging) return;
        e.preventDefault();
        const x = e.pageX - carousel.offsetLeft;
        const walk = (x - startX) * 2; // 스크롤 속도 조정
        carousel.scrollLeft = scrollLeft - walk;
    });

    // 터치 스와이프 이벤트 (모바일 대응)
    let touchStartX = 0;
    let touchScrollLeft = 0;

    carousel.addEventListener("touchstart", (e) => {
        touchStartX = e.touches[0].pageX;
        touchScrollLeft = carousel.scrollLeft;
    });

    carousel.addEventListener("touchmove", (e) => {
        const touchMoveX = e.touches[0].pageX;
        const touchWalk = (touchMoveX - touchStartX) * 2;
        carousel.scrollLeft = touchScrollLeft - touchWalk;
    });

    // 버튼 클릭 시 이동 (왼쪽/오른쪽)
    prevBtn.addEventListener("click", () => {
        carousel.scrollBy({ left: -250, behavior: "smooth" });
    });

    nextBtn.addEventListener("click", () => {
        carousel.scrollBy({ left: 250, behavior: "smooth" });
    });
});

const canvasWidth = 1440;
const originalAspectRatio = 1440 / 900;
const canvasHeight = canvasWidth / originalAspectRatio * 0.7;

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(45, canvasWidth / canvasHeight, 0.1, 1000);

// 초기 카메라 위치 및 target 설정
const initialCameraDistance = 0.85;
const cameraOffsetX = 0;
const targetOffsetY = -0.15; // 아래로 쳐다볼 각도 조정

camera.position.set(cameraOffsetX, 0.2, initialCameraDistance);
const target = new THREE.Vector3(0, targetOffsetY, 0); // target 위치 조정
camera.lookAt(target);

const renderer = new THREE.WebGLRenderer({ antialias: true });
renderer.setSize(canvasWidth, canvasHeight);
renderer.setPixelRatio(window.devicePixelRatio);
document.getElementById('3d').appendChild(renderer.domElement);

const controls = new THREE.OrbitControls(camera, renderer.domElement);
controls.target = target; // OrbitControls의 target 설정
controls.enableDamping = true;
controls.dampingFactor = 0.05;
controls.rotateSpeed = 1.0;
controls.enableZoom = true;
controls.enablePan = true;
controls.minDistance = 0;
controls.maxDistance = 1.5;
controls.zoomSpeed = 0.7;
controls.update();

controls.minPolarAngle = Math.PI / 5;
controls.maxPolarAngle = Math.PI / 4;
controls.minAzimuthAngle = -Math.PI / 18;
controls.maxAzimuthAngle = Math.PI / 3;
// 조명 설정
const pointLight = new THREE.PointLight(0xFFB6C1, 1.3, 25);
pointLight.position.set(0, 4, 0);
pointLight.decay = 2;
scene.add(pointLight);

const ambientLight = new THREE.AmbientLight(0xFFB6C1, 0.3);
scene.add(ambientLight);

const hemiLight = new THREE.HemisphereLight(0xFFEACF, 0x806040, 0.5);
scene.add(hemiLight);

const softSpotLight = new THREE.SpotLight(0xFFEACF, 1.0, 20, Math.PI / 6, 0.5);
softSpotLight.position.set(2, 5, 5);
softSpotLight.castShadow = true;
scene.add(softSpotLight);



// 음악 재생 변수
let audio = new Audio('/onlycake/audio/2.mp3'); // 로컬 MP3 파일 경로
audio.loop = true; // 음악 반복 재생 설정

// 음악 재생 버튼 클릭 이벤트 추가
document.getElementById('playButton').addEventListener('click', () => {
    if (audio.paused) {
        audio.play().catch(error => {
            console.error('Audio playback failed:', error);
        });
    } else {
        audio.pause();
    }
});

// GLTF 모델 로드
const loader = new THREE.GLTFLoader();
loader.load('/onlycake/object/partyroom10.gltf', function (gltf) {
    scene.add(gltf.scene);

    gltf.scene.traverse((child) => {
        if (child.isLight) {
            gltf.scene.remove(child);
        }
        if (child.isMesh) {
            child.castShadow = true;
            child.receiveShadow = true;
            child.material.roughness = 0.9;
            child.material.metalness = 0.1;
        }
    });

}, undefined, function (error) {
    console.error('Error loading model:', error);
});

// 스피커 모델 로드 및 클릭 이벤트 추가
loader.load('/onlycake/object/speaker3.gltf', function (gltf) {
    const speaker = gltf.scene;
    scene.add(speaker);

    speaker.traverse((child) => {
        if (child.isMesh) {
            child.userData.clickable = true; // 클릭 가능하도록 설정
        }
    });

    // 클릭 이벤트 추가
    window.addEventListener('click', (event) => {
        const mouse = new THREE.Vector2();
        mouse.x = (event.clientX / window.innerWidth) * 2 - 1;
        mouse.y = -(event.clientY / window.innerHeight) * 2 + 1;

        const raycaster = new THREE.Raycaster();
        raycaster.setFromCamera(mouse, camera);
        const intersects = raycaster.intersectObject(speaker, true); // true로 설정하면 내부 모든 자식까지 검사


        if (intersects.length > 0) {
            if (audio.paused) {
                audio.play().catch(error => {
                    console.error('Audio playback failed:', error);
                });
            } else {
                audio.pause();
            }
        }
    });

}, undefined, function (error) {
    console.error('Error loading speaker model:', error);
});

// 애니메이션 함수
function animate() {
    requestAnimationFrame(animate);
    controls.update();
    renderer.render(scene, camera);
}
animate();

function resizeplayButton() {
    const container = document.getElementById('3d');
    const playButton = document.getElementById('playButton');

    if (!container || !playButton) return;

    const rect = container.getBoundingClientRect();

    playButton.style.position = 'absolute';
    playButton.style.left = `${rect.left + window.scrollX}px`;
    playButton.style.top = `${rect.bottom + window.scrollY + 100}px`;

    playButton.style.width = `${rect.width}px`;
}



// 초기 로드 시 및 창 크기 변경 시 playButton 크기 조정
window.addEventListener('load', resizeplayButton);
window.addEventListener('resize', resizeplayButton);

// responsive canvas size 설정
function updateCanvasSize() {
    const container = document.getElementById('3d');

    const width = container.clientWidth;
	const height = width *0.45;

    renderer.setSize(width, height);
    camera.aspect = width / height;
    camera.updateProjectionMatrix();
}

window.addEventListener('resize', updateCanvasSize);
window.addEventListener('load', updateCanvasSize);


</script>

</body>
</html>