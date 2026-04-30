<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.sql.*, java.net.URLEncoder, java.net.URLDecoder" %>
<%@ page import="java.io.UnsupportedEncodingException" %>


<%
request.setCharacterEncoding("utf-8");

    String id = (String) session.getAttribute("sid");
    String memNickname = (String) session.getAttribute("memNickname");

    // 페이지네이션 관련 변수
    int currentPage = 1; // 기본 페이지
    int pageSize = 4; // 한 페이지당 표시할 문의 개수

    // GET 요청에서 'page' 값을 받아 처리
    String pageParam = request.getParameter("page");
    if (pageParam != null) {
        try {
            currentPage = Integer.parseInt(pageParam);
            if (currentPage < 1) currentPage = 1; // 음수 방지
        } catch (NumberFormatException e) {
            currentPage = 1; // 잘못된 값이 들어오면 기본 페이지로 설정
        }
    }

    int startRow = (currentPage - 1) * pageSize; // MySQL에서 가져올 시작 행 계산

    // 검색 관련 변수
    // 검색 관련 변수
// 검색 관련 변수
String searchCategory = request.getParameter("category");
String keyword = request.getParameter("keyword");

if (keyword != null) {
    try {
        keyword = URLDecoder.decode(keyword, "UTF-8");
    } catch (UnsupportedEncodingException e) {
        e.printStackTrace();
    }
}



    // DB 연결을 위한 변수 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    int totalRecords = 0; // 전체 문의 개수 저장

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake?characterEncoding=EUC-KR";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 전체 데이터 개수 가져오기
        String countQuery = "SELECT COUNT(*) FROM question WHERE 1=1";
if (searchCategory != null && keyword != null && !keyword.trim().isEmpty()) {
    switch (searchCategory) {
        case "writer":
            countQuery += " AND memNickname LIKE ?";
            break;
        case "title":
            countQuery += " AND questionTitle LIKE ?";
            break;
        case "category":
            countQuery += " AND questionCategory LIKE ?";
            break;
    }
}

        pstmt = conn.prepareStatement(countQuery);
if (searchCategory != null && keyword != null && !keyword.trim().isEmpty()) {
    pstmt.setString(1, "%" + keyword + "%");
}

        rs = pstmt.executeQuery();
if (rs.next()) {
    totalRecords = rs.getInt(1);  // 🔹 꼭 필요!
}
rs.close();
pstmt.close();

        // 기본 SQL 쿼리 작성
        // 기본 SQL 쿼리 작성
String sql = "SELECT questionIdx, questionCategory, questionTitle, memNickname, questionAt FROM question WHERE 1=1";


// 검색 조건 추가
if (searchCategory != null && keyword != null && !keyword.trim().isEmpty()) {
    switch (searchCategory) {
        case "writer":
            sql += " AND memNickname LIKE ?";
            break;
        case "title":
            sql += " AND questionTitle LIKE ?";
            break;
        case "category":
            sql += " AND questionCategory LIKE ?";
            break;
    }
}

sql += " ORDER BY questionAt DESC LIMIT ?, ?";


        // SQL 실행 준비
pstmt = conn.prepareStatement(sql);
int paramIndex = 1;

// 검색 조건이 있을 경우 파라미터 설정
if (searchCategory != null && keyword != null && !keyword.trim().isEmpty()) {
    pstmt.setString(paramIndex++, "%" + keyword + "%");
}

// 페이지네이션 파라미터 설정
pstmt.setInt(paramIndex++, startRow);
pstmt.setInt(paramIndex++, pageSize);


        rs = pstmt.executeQuery();
%>

<html>
<head>
    <meta charset="utf-8">
    <title>고객센터 - 문의</title>
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

			#content_1 {
                width: 1440px;
                height: auto; 
                background-color: #fff6ed;

                display: flex;
                flex-direction: column; /* 수직 방향으로 정렬 */
                justify-content: center; /* 수직 중앙 정렬 */
                align-items: center; /* 수평 중앙 정렬 */
                text-align: center; /* 텍스트 중앙 정렬 */
                padding-top: 50px;

            }

            #content_1 b {
                font-size: 30px;
                color: #C31D3B;
				font-family: "NanumSquareNeoExtraBold", sans-serif;
            }

            #content_1 p {
                font-size: 20px;
                color: #C31D3B;
            }
			

            #sub_nav {
                width: 1440px;
                height: 170px;
                background-color: #fff6ed;
                display: flex;
                justify-content: center;
                align-items: center;
				
            }

            #sub_nav button {
                width: 280px;
                height: 60px;
                background-color: #fff6ed;
                border: solid 2px #C31D3B;
                border-radius: 50px;
                margin: 0 20px; /* 좌우에 20px의 간격 추가 (각 버튼 사이에 총 40px) */
                color: #C31D3B;
                font-size: 25px;
                font-family: "NanumSquareNeoExtraBold", sans-serif;
            }

            #sub_nav button:hover {
                background-color: #C31D3B;
                color: #fff6ed;
            }
			
			#content_2 {
				display: flex;
				justify-content: center; /* 수평 중앙 정렬 */
				align-items: center; /* 수직 중앙 정렬 */
				height: 170px; /* 원하는 높이로 수정 가능 */
				margin-bottom: 50px;
			}

			
			#content_2 img {
				width:200px;
				height: 200px;
			}



        .inquiry-btn {
    text-decoration: none;
    background-color: #C31D3B;
    color: white;
    padding: 15px 150px;
    border-radius: 10px;
    font-size: 27px;
    margin: 20px auto;  /* 위 여백 20px + 좌우 자동 정렬 */
    display: block; /* 블록 요소로 변경하여 중앙 정렬 가능 */
    text-align: center;
    width: fit-content; /* 내용에 맞게 크기 조정 */
}

        .inquiry-table {
            width: 80%;
            margin: 30px auto;
            border-collapse: collapse;
			margin-bottom:150px;
        }

        .inquiry-table td {
            border-bottom: 1px solid #744731;
            padding: 20px;
            text-align: center;
			color: #744731;
			font-size: 22px;
        }

        .inquiry-table th {
            border-top: 4px solid #C31D3B;
			border-bottom: 1px solid #744731;
            color: #C31D3B;
			padding: 20px;
            text-align: center;
			font-size: 22px;
        }

		.pagination {
    display: flex;
    justify-content: center; /* 가운데 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    margin-top: 20px; /* 위쪽 여백 추가 */
    gap: 10px; /* 버튼 사이 여백 */
	margin-bottom:100px;
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

.search-container {
    width: 100%;
    max-width: 1270px;   /* 적당한 최대 너비 */
    margin: 40px auto 100px auto;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 10px;
    padding-top: 16px;
    border-top: 1px solid #C31D3B;
    border-bottom: 1px solid #C31D3B;
}


.search-category {
	width:216px;
    font-size: 22px;
    padding: 10px;
    border: 1px solid #C31D3B;
    border-radius: 5px;
    color: #C31D3B;
    background-color: #FFF6ED;
	font-family: 'NanumSquareNeo', sans-serif;
}

.search-input {
    font-size: 22px;
    padding: 10px;
    width: 659px;
    border: 1px solid #C31D3B;
    border-radius: 5px;
	background-color:#FFF6ED;
}

.search-input::placeholder {
    font-size: 22px;
    font-family: 'NanumSquareNeo', sans-serif;
    color: rgba(195, 29, 59, 0.4); /* C31D3B 색상의 40% 투명도 */
}


.search-button {
	width: 216px;
    font-size: 22px;
    padding: 0; /* 기존 padding 제거 */
    height: 52px; /* 고정 높이 */
    line-height: 52px; /* 텍스트를 수직 가운데 정렬 */
    text-align: center;
    border: none;
    background-color: #C31D3B;
    color: white;
    border-radius: 5px;
    cursor: pointer;
    font-family: 'NanumSquareNeo', sans-serif;
}


.search-button:hover {
    background-color: #A51A32;
}

.search-category,
.search-input,
.search-button {
    height: 52px;
    line-height: 52px;
    box-sizing: border-box;
    vertical-align: middle; /* 추가!! */
}


.pagination {
    margin-bottom: 60px;
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
			.button-container {
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    margin-top: 50px; /* 위쪽 여백 추가 */
	margin-bottom:300px;
}

.inquiry-table a {
    color: #744731; 
    text-decoration: none; 
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
        <a href="LoginOK.jsp"><b>문의</b></a><br>
        <p>신속하고 정확한 지원으로 여러분을 맞이합니다.</p>
    </div>

	
    <a href="InsertInquiry.jsp" class="inquiry-btn">문의 하기</a>
    
    <table class="inquiry-table">
        <tr>
            <th>분류</th>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        <%
        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
            String questionCategory = rs.getString("questionCategory");
            String questionTitle = rs.getString("questionTitle");
            String writerNickname = rs.getString("memNickname");
            String questionAt = rs.getString("questionAt");
    %>
            <tr>
    <td><%= questionCategory %></td>
    <td><a href="InsertInquiry_Result.jsp?questionIdx=<%= rs.getInt("questionIdx") %>"><%= questionTitle %></a></td>

    <td><%= writerNickname %></td>
    <td><%= questionAt.substring(0, 10) %></td> <!-- YYYY-MM-DD 형식으로 출력 -->
</tr>

   <%
        }

        if (!hasData) {
    %>
    <tr>
        <td colspan="4">문의 내역이 없습니다.</td>
    </tr>
    <%
        }
    %>
</table>

<!-- 페이징 버튼 -->
<div class="pagination">
    <%
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        if (currentPage > 1) {
    %>
        <a href="?page=<%= currentPage - 1 %>">이전</a>
    <%
        }

        for (int i = 1; i <= totalPages; i++) {
    %>
        <a href="?page=<%= i %>" class="<%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
    <%
        }

        if (currentPage < totalPages) {
    %>
        <a href="?page=<%= currentPage + 1 %>">다음</a>
    <%
        }
    %>
</div>
<div class="search-container">
    <form id="searchForm" method="GET" action="CustomerService_Inquiry.jsp">
        <select class="search-category" name="category">
            <option value="writer" <%= "writer".equals(searchCategory) ? "selected" : "" %>>작성자</option>
            <option value="title" <%= "title".equals(searchCategory) ? "selected" : "" %>>제목</option>
            <option value="category" <%= "category".equals(searchCategory) ? "selected" : "" %>>분류</option>
        </select>
        <input type="text" class="search-input" name="keyword" value="<%= (keyword != null) ? keyword : "" %>" placeholder="검색어를 입력해 주세요.">
        <button type="submit" class="search-button">검색</button>
    </form>
</div>

<%
    } catch (Exception e) {
%>
<tr>
    <td colspan="4" style="color: red;">데이터를 불러오는 중 오류가 발생했습니다.</td>
</tr>
<%
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

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