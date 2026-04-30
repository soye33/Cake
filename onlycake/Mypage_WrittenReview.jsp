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

    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PW = "abcd";

    Connection conn = null;
    PreparedStatement countStmt = null;
    ResultSet countRs = null;
    PreparedStatement listStmt = null;
    ResultSet listRs = null;

    int pageSize = 2;
    int currentPage = 1;
    int totalRecords = 0;
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        currentPage = Integer.parseInt(pageParam);
    }
    int offset = (currentPage - 1) * pageSize;
%>
    <meta charset="EUC-KR">
    <title>작성한 후기</title>
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
    height: 1000px;
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
    margin-bottom: 100px;
    margin-right: 100px;
    margin-left: 30px;
    min-height: 900px;
    position: relative; /* 추가 */
    padding-bottom: 100px; /* 페이징 공간 확보 */
}


.main h2 {
    text-align: center;
    font-size: 35px;
    color: #C31D3B;
	margin-left:80px;
} 

.main table {
    margin: 0 auto;
    border-collapse: collapse;
    border: 1px solid #744731;
    transform: translateX(40px); /* 살짝 왼쪽으로 이동 */
	margin-bottom:50px;
}


.main table td {
    border: 1px solid #744731;
    padding: 8px; /* 여백 */
    text-align: center; /* 셀 안 텍스트 가운데 정렬 */
	width:440px;
	height:70px;
	color:#744731;
	font-size:25px;
}

.main table a {
	color:#744731;
	display:block;
}
.review-box {
	width: 889px;
	margin-left: 100px;
	border-bottom: 10px solid #744731;
	min-height: 430px; /* 기본 높이는 410px 유지 */
	height: auto;      /* 내용에 따라 높이 늘어나도록 */
}

.product {
    display: flex;
    flex-direction: row;
    align-items: center;
    border-bottom: 1px solid #744731;
    padding-bottom: 10px;
	padding-top: 10px;
    position: relative; /* 이거 중요! */
}

.product img {
    width: 93px;
    height: 93px;
}

.review-info {
    font-size: 20px;
    color: #744731;
    text-align: left;
    margin-left: 10px; /* 이미지와의 간격 */
}

.view-detail {
    position: absolute;
    right: 10px;
    top: 50%;
    transform: translateY(-50%);
    font-size: 20px;
    font-weight: bold;
    color: #744731;
    text-decoration: none;
}

.view-detail:hover {
    color: #C31D3B;
}

.member {
	padding-bottom: 10px;
	padding-top: 10px;
	display: flex;
    flex-direction: row;
    align-items: center;
    position: relative; /* 이거 중요! */
}

.member img {
	width:74px;
	height:74px;
}

.member_at {
    margin-left: 10px;
    display: flex;
    flex-direction: column;
	color: #5D5D5D;
}

.member_at p:not(:last-child) {
    margin-bottom: -10px;
	color: #744731;
}


.stars {
    position: absolute;
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    display: flex;
}

.stars img {
    width: 50px;
    height: 50px;
    margin-right: 2px;
}

.text {
    display: flex; /* 수평 정렬 */
    flex-direction: row; /* 기본값이지만 명시적으로 써주면 좋아 */
    align-items: flex-start; /* 세로 정렬 기준 (top 정렬) */
    gap: 20px; /* 이미지와 텍스트 사이 간격 */
    margin-top: 10px; /* 필요하면 여백 */
}

.text img {
	width:153px;
	height:auto;
}

.text p {
	font-size:20px;
	color: #744731;
	width:690px;
	height:145px;
	text-align:left;
}

.pagination {
    position: absolute;
    bottom: 20px;
    left: 50%;
    transform: translateX(-50%);
    display: flex;
    gap: 10px;
    font-size: 32px;
}


.pagination a {
    text-decoration: none;
    color: #C31D3B;
    font-size: 32px;
    padding: 8px 12px;
    border-radius: 64px;
}

.pagination a.active {
    background-color: #C31D3B;
    color: white;
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
            <a href="Mypage_PossibleReview.jsp" id="small_menu" >작성 가능한 후기</a>
            <a href="Mypage_WrittenReview.jsp" id="small_menu" style="color: #C31D3B;">작성한 후기</a>
        </aside>
    </div>
    
    <hr class="vertical-line">
    
    <div class="main">
    <h2>작성한 후기</h2>
    <table>
        <tr>
            <td style="background-color:#C31D3B;">
                <a href="Mypage_WrittenReview.jsp" style="color:#fff; display:block;">작성한 후기</a>
            </td>
            <td>
                <a href="Mypage_PossibleReview.jsp">작성 가능한 후기</a>
            </td>
        </tr>
    </table>

    <%
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

            String countSql = "SELECT COUNT(*) FROM review WHERE memNickname = ?";
            countStmt = conn.prepareStatement(countSql);
            countStmt.setString(1, memNickname);
            countRs = countStmt.executeQuery();

            if (countRs.next()) {
                totalRecords = countRs.getInt(1);
            }

            String sql = "SELECT r.reviewIdx, r.prdNo, r.ordNo, c.prdName, c.prdImage, pd.prdDesign, " +
"r.rating, r.reviewAt, r.photoPath, r.reviewText " +
"FROM review r " +
"JOIN cake c ON r.prdNo = c.prdNo " +
"LEFT JOIN ( " +
"    SELECT prdNo, MIN(prdDesign) AS prdDesign " +
"    FROM productdetail " +
"    GROUP BY prdNo " +
") pd ON r.prdNo = pd.prdNo " +
"WHERE r.memNickname = ? ORDER BY r.reviewAt DESC LIMIT ?, ?";

            listStmt = conn.prepareStatement(sql);
            listStmt.setString(1, memNickname);
            listStmt.setInt(2, offset);
            listStmt.setInt(3, pageSize);

            listRs = listStmt.executeQuery();

            boolean hasData = false;
            while (listRs.next()) {
                hasData = true;
                int reviewIdx = listRs.getInt("reviewIdx");
                int prdNo = listRs.getInt("prdNo");
                String prdName = listRs.getString("prdName");
                String prdImage = listRs.getString("prdImage");
                String prdDesign = listRs.getString("prdDesign");
                int rating = listRs.getInt("rating");
                Timestamp reviewAt = listRs.getTimestamp("reviewAt");
                String photoPath = listRs.getString("photoPath");
                String reviewText = listRs.getString("reviewText");

                String imageSrc = "images/" + prdImage;
                if (prdNo >= 61) {
                    imageSrc = "images/designCakeImage.jpg";
                    if ("도안 케이크".equals(prdName) && prdDesign != null && !prdDesign.trim().isEmpty()) {
                        imageSrc = "/onlycake/uploads/" + prdDesign;
                    }
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String formattedDate = sdf.format(reviewAt);
    %>
    <div class="review-box">
        <div class="product">
            <img src="<%= imageSrc %>" alt="제품 이미지">
            <div class="review-info">
                <p><%= prdName %></p>
            </div>
            <a class="view-detail" href="ReviewDetail.jsp?reviewIdx=<%= reviewIdx %>">></a>
        </div>
        <div class="member">
            <img src="images/user_profile.png">
            <div class="member_at">
                <p><%= memNickname %></p>
                <p><%= formattedDate %></p>
            </div>
            <div class="stars">
            <%
                for (int i = 1; i <= 5; i++) {
                    if (i <= rating) {
            %>
                <img src="images/star_yellow.png" alt="별">
            <%
                    } else {
            %>
                <img src="images/star_brown.png" alt="빈 별">
            <%
                    }
                }
            %>
            </div>
        </div>
        <div class="text">
    <% if (photoPath != null && !photoPath.trim().isEmpty()) { %>
        <img src="/onlycake/uploads/<%= photoPath %>" alt="후기 이미지">
    <% } %>
    <p><%= reviewText.replaceAll("\n", "<br>") %></p>
</div>

    </div>
    <%
            } // while 끝

            if (!hasData) {
    %>
        <p style="text-align:center; color:#744731; font-size:20px;">작성한 후기가 없습니다.</p>
    <%
            }
        } catch (Exception e) {
            out.println("<p>DB 오류: " + e.getMessage() + "</p>");
        } finally {
            try { if (countRs != null) countRs.close(); } catch (Exception e) {}
            try { if (countStmt != null) countStmt.close(); } catch (Exception e) {}
            try { if (listRs != null) listRs.close(); } catch (Exception e) {}
            try { if (listStmt != null) listStmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    %>

    <!--  고정 위치 페이징 -->
    <div class="pagination" style="position: absolute; bottom: 20px; left: 50%; transform: translateX(-50%);">
    <%
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);
        if (currentPage > 1) {
    %>
        <a href="Mypage_WrittenReview.jsp?page=<%= currentPage - 1 %>"><</a>
    <%
        }
        for (int i = 1; i <= totalPages; i++) {
    %>
        <a href="Mypage_WrittenReview.jsp?page=<%= i %>" 
            class="<%= (i == currentPage) ? "active" : "" %>">
            <%= i %>
        </a>
    <%
        }
        if (currentPage < totalPages) {
    %>
        <a href="Mypage_WrittenReview.jsp?page=<%= currentPage + 1 %>">></a>
    <%
        }
    %>
    </div>
</div> <!-- .main 끝 -->
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