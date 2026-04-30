<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

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
        return;
    }

    request.setCharacterEncoding("EUC-KR");

    String reviewIdxParam = request.getParameter("reviewIdx");
    if (reviewIdxParam == null || reviewIdxParam.isEmpty()) {
%>
    <script>
        alert("리뷰 번호가 올바르지 않습니다.");
        history.back();
    </script>
<%
        return;
    }

    int reviewIdx = Integer.parseInt(reviewIdxParam);

    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PW = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String prdName = "";
    int prdNo = 0;
    String prdImage = "";
    String prdDesign = "";
    int rating = 0;
    String reviewText = "";
    String photoPath = "";
    Timestamp reviewAt = null;
	java.sql.Date ordDate = null;
	int reviewCount = 0; 
	String writerNickname = "";


    try {
    Class.forName("org.gjt.mm.mysql.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

    // 조회수 증가 쿼리 먼저 실행
    String updateCountSql = "UPDATE review SET reviewCount = reviewCount + 1 WHERE reviewIdx = ?";
    pstmt = conn.prepareStatement(updateCountSql);
    pstmt.setInt(1, reviewIdx);
    pstmt.executeUpdate();
    pstmt.close();

    //  리뷰 상세 정보 가져오기
    String sql = "SELECT r.*, c.prdName, c.prdNo, c.prdImage, pd.prdDesign, o.ordDate " +
                 "FROM review r " +
                 "JOIN cake c ON r.prdNo = c.prdNo " +
                 "LEFT JOIN productdetail pd ON r.prdNo = pd.prdNo " +
                 "JOIN orderinfo o ON r.ordNo = o.ordNo " +
                 "WHERE r.reviewIdx = ?";
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, reviewIdx);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        prdName = rs.getString("prdName");
        prdNo = rs.getInt("prdNo");
        prdImage = rs.getString("prdImage");
        prdDesign = rs.getString("prdDesign");
        rating = rs.getInt("rating");
        reviewText = rs.getString("reviewText");
        photoPath = rs.getString("photoPath");
        reviewAt = rs.getTimestamp("reviewAt");
        ordDate = rs.getDate("ordDate");
        reviewCount = rs.getInt("reviewCount");  //  조회수 가져오기
		writerNickname = rs.getString("memNickname");

    } else {
%>
    <script>
        alert("해당 리뷰를 찾을 수 없습니다.");
        history.back();
    </script>
<%
        return;
    }

    } catch (Exception e) {
        out.println("<p>DB 오류: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }

    // 상품 이미지 경로 설정
    String imagePath = "images/" + prdImage;
    if (prdNo >= 61) {
        imagePath = "images/designCakeImage.jpg";
        if ("도안 케이크".equals(prdName) && prdDesign != null && !prdDesign.trim().isEmpty()) {
            imagePath = "/onlycake/uploads/" + prdDesign;
        }
    }
%>

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

.main {
    flex: 1;
    margin-top: 60px;
    margin-bottom: 20px;
    margin-right: 100px;
    margin-left: 30px;
    height: auto;
    align-items: center;
    display: flex;
    flex-direction: column;
}


.main h2 {
    text-align: center;
    font-size: 35px;
    color: #C31D3B;
	margin-left:80px;
} 

.member {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between; /* 요소들을 좌/우 정렬 */
    gap: 30px;
    border-bottom: 1px solid #744731;
    padding-bottom: 5px;
	margin-left:50px;
}

.member img {
	width:74px;
	height:74px;
}

.name_date {
    display: flex;
    flex-direction: column;
    justify-content: center;    /* 세로 정렬 시 중심 기준 */
    height: 100%;               /* 부모 기준 높이 필요 시 명시 */
}


.main_writer {
    font-size: 20px;
    color: #744731;
	margin-bottom:-5px;
}

.main_date {
	color: #5D5D5D;
	font-size: 20px;
}

.review_product {
	width: 100%;
    display: flex;
    align-items: center;
    justify-content: center; /* 요소들을 좌/우 정렬 */
    gap: 30px;
    border-bottom: 1px solid #744731;
    padding-bottom: 5px;
	margin-left:50px;
}

.review_product2 {
	width: 100%;
    display: flex;
    align-items: center;
    justify-content: center; /* 요소들을 좌/우 정렬 */
    gap: 30px;
	margin-left:-30px;
}

.review_product img {
	width:110px;
	height:110px;
	padding-bottom: 5px;
	padding-top: 10px;
}

.star-rating {
    display: flex;
    gap: 5px;
    justify-content: center;
    align-items: center;
    flex: 1; /* 가운데 정렬을 위해 flex-grow */
	margin-left:-110px;
}

.star-rating img.star {
    width: 67px;
    height: 67px;
}

.writen_date {
    margin-left: auto;
    text-align: right;
    white-space: nowrap;
    font-size: 26px;
    color: #744731;

    display: flex;
    align-items: center;  /* 수직 가운데 정렬 */
    height: 100%;
}


        .textbox {
    width: 100%;
    min-height: 300px; /* 기본 높이 유지 */
    height: auto;      /* 내용에 따라 자동 증가 */
    padding: 30px;
    border-bottom: 1px solid #744731;
    margin-left: 90px;
    background-color: #FFF6ED;
    text-align: center;
    display: flex;
    flex-direction: column;
	margin-left:50px;
}


.photo img {
    width: 500px;
    height: auto;
}

.textbox2 {
	font-size:20px;
	color: #744731;
	text-align: center;
	margin-top:30px;
	margin-bottom:30px;
	margin-left:70px;
	width:690px;
	height:auto;
}

.button-container {
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    margin-top: 50px; /* 위쪽 여백 추가 */
	margin-bottom:300px;
}

.button-container {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin-top: 50px;
    margin-bottom: 300px;
}

.button-container a {
    display: flex; /* 내부 컨텐츠를 정렬하기 위해 flex 사용 */
    justify-content: center; /* 가운데 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    width: 200px; /* 버튼 크기 고정 */
    height: 30px; /* 버튼 높이 고정 */
    padding: 15px 0; /* 버튼 높이를 균일하게 */
    font-size: 20px;
    font-family: 'NanumSquareNeoBold', sans-serif;
    color: #FFF6ED;
    background-color: #C31D3B;
    border-radius: 10px;
    text-decoration: none;
    transition: background-color 0.3s ease-in-out;
    border: none;
    cursor: pointer;
    text-align: center;
}

.button-container a:hover {
    background-color: #A11B2F;
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
			
			.view {
    display: flex;
    align-items: center;
    justify-content: right; /* 요소를 양쪽 끝으로 배치 */
    width: 100%;
    margin: 0 auto;
	margin-left:-50px;
}

.view p {
	font-size:20px;
	color: #744731;
    text-align: right; /* 오른쪽 정렬 */
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
	
    <div class="main">
            <h2>후기</h2>
			<div class="member">
				<img src="images/user_profile.png">
				<div class="name_date">
					<p class="main_writer"><%= writerNickname %></p>

					<%
						String formattedDate = new SimpleDateFormat("yyyy-MM-dd").format(reviewAt);
						String formattedOrdDate = new SimpleDateFormat("yyyy-MM-dd").format(ordDate);
					%>
					<p class="main_date">주문일: <%= formattedOrdDate %></p>
				</div>
				<div class="star-rating" id="starRating">
				<%
					for (int i = 1; i <= 5; i++) {
						if (i <= rating) {
				%>
					<img src="images/star_yellow.png" class="star" alt="별">
				<%
						} else {
				%>
					<img src="images/star_brown.png" class="star" alt="빈 별">
				<%
						}
					}
				%>
				</div>
				<p class="writen_date"><%= formattedDate %></p>
			</div> <!-- 1 -->

			<div class="review_product">
			<div class="review_product2">
				<img src="<%= imagePath %>" alt="상품 이미지">
				<div style="font-size: 26px; color: #744731;"><%= prdName %></div>
				</div>
			</div> <!-- 2 -->
			
	<div class="textbox">
        
        <% if (photoPath != null && !photoPath.trim().isEmpty()) { %>
    <div class="photo">
        <img src="/onlycake/uploads/<%= photoPath %>" alt="리뷰 이미지">
    </div>
<% } else { %>
    <div class="photo" style="text-align: center; color: #744731; font-size: 18px; margin-top: 20px;">
        등록된 이미지가 없습니다.
    </div>
<% } %>

    </div>
	<div class="textbox2">
		<p><%= reviewText.replaceAll("\n", "<br>") %></p>
	</div>
</div> <!--main 닫기 -->
<div class="view">
	<p> 조회수: <%= reviewCount %></p>
</div>

<script>
    // 비밀번호 입력 창을 띄우고 삭제 요청을 보냄
function confirmDelete(reviewIdx) {
    let password = prompt("후기 삭제를 위해 비밀번호를 입력하세요:");
    if (password !== null && password.trim() !== "") {
        // 비밀번호 입력되었을 때 폼 제출
        document.getElementById("deleteForm").reviewPwd.value = password;
        document.getElementById("deleteForm").reviewIdx.value = reviewIdx;
        document.getElementById("deleteForm").submit();
    } else {
        alert("비밀번호를 입력해야 합니다.");
    }
}


    // 비밀번호 입력 창을 띄우고 수정 페이지로 이동
    function confirmEdit(reviewIdx, prdNo) {
    let password = prompt("후기 수정을 위해 비밀번호를 입력하세요:");
    if (password != null && password.trim() !== "") {
        let url = "UpdateReview.jsp?reviewIdx=" + reviewIdx + 
                  "&reviewPwd=" + encodeURIComponent(password) + 
                  "&prdNo=" + prdNo;
        location.href = url;
    } else {
        alert("비밀번호를 입력해야 합니다.");
    }
}

</script>

<div class="button-container">
    <!-- 삭제 버튼 -->
    <a href="javascript:void(0);" onclick="confirmDelete(<%= reviewIdx %>)" class="delete-button">후기 삭제하기</a>

    <!-- 수정 버튼 -->
    <a href="javascript:void(0);" onclick="confirmEdit(<%= reviewIdx %>, <%= prdNo %>)" class="edit-button">후기 수정하기</a>


    <!-- 전체 목록으로 이동 -->
    <a href="Review.jsp" class="view-all-button">다른 후기보기</a>
</div>

<!-- 삭제 요청을 처리하는 숨겨진 폼 -->
<form id="deleteForm" method="post" action="DeleteReview.jsp" style="display: none;">
    <input type="hidden" name="reviewIdx">
    <input type="hidden" name="reviewPwd">
</form>
			</div>
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
</body>
</html>