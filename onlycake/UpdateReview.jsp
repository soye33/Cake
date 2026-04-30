<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<%
    String id = (String) session.getAttribute("sid");
    String memNickname = (String) session.getAttribute("memNickname");
    if (id == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    request.setCharacterEncoding("EUC-KR");

    String reviewIdxStr = request.getParameter("reviewIdx");
    String reviewPwd = request.getParameter("reviewPwd");
    String prdNoParam = request.getParameter("prdNo");

    if (reviewIdxStr == null || reviewPwd == null || prdNoParam == null ||
        reviewIdxStr.isEmpty() || reviewPwd.isEmpty() || prdNoParam.isEmpty()) {
%>
    <script>
        alert("잘못된 접근입니다.");
        history.back();
    </script>
<%
        return;
    }

    int reviewIdx = Integer.parseInt(reviewIdxStr);
    int prdNo = Integer.parseInt(prdNoParam);

    String dbUrl = "jdbc:mysql://localhost:3306/cake";
    String dbId = "multi";
    String dbPw = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String reviewText = "";
    int rating = 0;
    String photoPath = "";

    String prdName = "";
    String prdImage = "";
    String prdDesign = "";
    String imagePath = ""; // 중복 선언 제거 후 이 위치에 선언

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(dbUrl, dbId, dbPw);

        // 리뷰 정보
        String sql = "SELECT reviewText, rating, photoPath FROM review WHERE reviewIdx = ? AND reviewPwd = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, reviewIdx);
        pstmt.setString(2, reviewPwd);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            reviewText = rs.getString("reviewText");
            rating = rs.getInt("rating");
            photoPath = rs.getString("photoPath");
        } else {
%>
    <script>
        alert("비밀번호가 일치하지 않거나 리뷰를 찾을 수 없습니다.");
        history.back();
    </script>
<%
            return;
        }
        rs.close();
        pstmt.close();

        // 상품 정보
        sql = "SELECT c.prdName, c.prdImage, pd.prdDesign " +
              "FROM cake c LEFT JOIN productdetail pd ON c.prdNo = pd.prdNo " +
              "WHERE c.prdNo = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, prdNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            prdName = rs.getString("prdName");
            prdImage = rs.getString("prdImage");
            prdDesign = rs.getString("prdDesign");
        }

        // 이미지 경로 결정
        imagePath = "images/" + prdImage;
        if (prdNo >= 61) {
            imagePath = "images/designCakeImage.jpg";
            if ("도안 케이크".equals(prdName) && prdDesign != null && !prdDesign.trim().isEmpty()) {
                imagePath = "/onlycake/uploads/" + prdDesign;
            }
        }

    } catch (Exception e) {
        out.println("<p>DB 오류: " + e.getMessage() + "</p>");
        return;
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
<html>
<head>
    <meta charset="EUC-KR">
    <title>후기 작성하기</title>
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
	margin-top:-52px;
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

.main {
    flex: 1;
    margin-top: 60px;
    margin-bottom: 20px;
    margin-right: 100px;
    margin-left: 30px; 
    height: auto; 
}

.main h2 {
    text-align: center;
    font-size: 35px;
    color: #C31D3B;
	margin-left:80px;
} 

.review_product {
	display: flex; 
	align-items: center; 
	gap: 30px; 
	margin-top:20px;
	margin-left:90px;
	justify-content: left;
	padding-bottom:20px;
	border-bottom:1px solid #744731;
	width:885px;
}

.review_product img {
	width:130px;
	height:130px;
}

.star-rating {
	margin-left:-400px;
}

.star-rating img.star {
    width: 80px;
    height: 80px;
    cursor: pointer;
    transition: transform 0.2s ease;
	
}
.star-rating img.star:hover {
    transform: scale(1.1);
}

.review-form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        .review-form textarea {
            width: 885px;
            height: 300px;
            font-size: 20px;
            padding: 10px;
            border: 2px solid #744731;
            border-radius: 10px;
            resize: none;
			margin-left:90px;
			background-color:#FFF6ED;
			font-family: 'NanumSquareNeo', sans-serif;
			color:#744731;
        }

		.review-form textarea::placeholder {
			font-family: 'NanumSquareNeo', sans-serif;
			color:#744731;
		}

        .photo-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
			width: 885px;
			margin-left:90px;
        }
        .photo-upload label {
            background-color: #FFF6ED;
            border: 2px solid #C31D3B;
            color: #C31D3B;
            padding: 20px 30px;
            border-radius: 10px;
            cursor: pointer;
            font-size: 18px;
			width: 825px;
			text-align:center;
        }
        .photo-upload input[type="file"] {
            display: none;
        }
        .preview {
            margin-top: 10px;
        }
        .preview img {
    width: 150px;
    margin-left: -440px;
    display: block; /* 수정: 항상 보이게 */
}


		.form-content-pass {
    width: 865px; /* 원하는 크기로 조정 */
    height: 50px; /* 높이 조정 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 5px 10px;
    display: flex; /* Flexbox 적용 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: flex-start; /* 내부 요소를 왼쪽 정렬 */
    text-align: left; /* 텍스트 왼쪽 정렬 */
    margin-left:90px;
    gap: 20px; /* label과 input 간격 추가 */
}

.form-content-pass label {
    font-size: 20px;
    color: #744731;
    white-space: nowrap; /* 줄 바꿈 방지 */
    min-width: 150px; /* label의 최소 너비 지정 (조절 가능) */
    text-align: left; /* 왼쪽 정렬 */
	margin-left:30px;
}

.form-content-pass input[type="password"] {
    flex-grow: 1; /* 남은 공간을 모두 차지 */
    height: 50px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
    font-size: 20px;
    color: #744731;
    padding: 0 10px; /* 안쪽 여백 추가 */
    text-align: left; /* 입력값 왼쪽 정렬 */
}

.form-content-pass input[type="password"]::placeholder {
    color: #744731; /* placeholder 색상도 동일하게 */
    opacity: 0.7; /* 조금 연하게 */
    font-size: 20px;
    font-family: 'NanumSquareNeo', sans-serif;
}
		
        .submit-btn {
            margin-top: 40px;
            padding: 15px 40px;
            font-size: 22px;
            background-color: #C31D3B;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
			margin-left:90px;
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
    <div class="main">
    <h2>후기 수정하기</h2>
    <form method="post" action="UpdateReview_Ok.jsp" enctype="multipart/form-data" class="review-form">
        <input type="hidden" name="prdNo" value="<%= prdNoParam %>" />
        <input type="hidden" name="reviewIdx" value="<%= reviewIdx %>" />
        <input type="hidden" name="reviewPwd" value="<%= reviewPwd %>" />

        <div class="review_product">
            <img src="<%= imagePath %>" alt="상품 이미지">
            <div style="font-size: 24px; color: #744731;"><%= prdName %></div>
        </div>

        <div class="star-rating" id="starRating">
            <% for (int i = 1; i <= 5; i++) { %>
                <img src="images/<%= i <= rating ? "star_yellow.png" : "star_brown.png" %>" class="star" data-value="<%= i %>" />
            <% } %>
        </div>
        <input type="hidden" name="rating" id="ratingValue" value="<%= rating %>" />

        <textarea name="reviewContent"><%= reviewText %></textarea>

        <div class="photo-upload">
            <label for="photoUpload">사진 수정 (선택)</label>
            <input type="file" id="photoUpload" name="photoUpload" accept="image/*">
            <% if (photoPath != null && !photoPath.trim().isEmpty()) { %>
                <div class="preview">
                    <img src="/onlycake/uploads/<%= photoPath %>" width="150">
                </div>
            <% } %>
        </div>

        <button type="submit" class="submit-btn">수정 완료</button>
    </form>
</div>


<script>
    // 별점 선택 처리
    const stars = document.querySelectorAll(".star-rating .star");
    const ratingInput = document.getElementById("ratingValue");
    stars.forEach(star => {
        star.addEventListener("click", function () {
            const selectedRating = parseInt(this.getAttribute("data-value"));
            ratingInput.value = selectedRating;
            stars.forEach(s => {
                s.src = parseInt(s.getAttribute("data-value")) <= selectedRating
                    ? "images/star_yellow.png"
                    : "images/star_brown.png";
            });
        });
    });

    // 파일 업로드 시 미리보기 이미지 변경
    const fileInput = document.getElementById("photoUpload");
    const previewImg = document.querySelector(".preview img");

    fileInput.addEventListener("change", function () {
        if (fileInput.files && fileInput.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                if (previewImg) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = "block"; // 혹시 숨겨져 있을 경우 표시
                }
            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    });
</script>

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
</body>
</html>