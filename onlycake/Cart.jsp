<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    NumberFormat currencyFormat = NumberFormat.getInstance(Locale.KOREA);
    request.setCharacterEncoding("EUC-KR");

    String id = (String) session.getAttribute("sid");
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='Login.jsp';</script>");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    List<Map<String, String>> cartItems = new ArrayList<>();
    int totalPrice = 0;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "SELECT c.*, p.prdName, p.prdImage, p.prdPrice, p.ctgType FROM cart c " +
                     "JOIN cake p ON c.prdNo = p.prdNo WHERE c.memId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("ctNo", rs.getString("ctNo"));
            item.put("prdNo", rs.getString("prdNo"));
            item.put("ctQty", rs.getString("ctQty"));
            item.put("memId", rs.getString("memId"));
            item.put("memNickname", rs.getString("memNickname"));

            String[] columns = {
                "prdCakesize", "prdTaste", "prdFruit", "prdTopcream", "prdBottomcream",
                "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage", "prdLettering",
                "prdFruitprice", "prdCandleprice", "prdCoolingprice", "prdSizeprice", "prdDesign"
            };
            for (String col : columns) {
                try {
                    item.put(col, rs.getString(col));
                } catch (SQLException e) {
                    item.put(col, null);
                }
            }

            item.put("prdName", rs.getString("prdName"));
            item.put("prdImage", rs.getString("prdImage"));
            item.put("prdPrice", rs.getString("prdPrice"));
            item.put("ctgType", rs.getString("ctgType"));

            int ctQty = parseIntSafe(item.get("ctQty"));
            int itemTotal = 0;

            String prdName = item.get("prdName");
            String ctgType = item.get("ctgType");

            if ("도안 케이크".equals(prdName)) {
                itemTotal = 0;
            } else if ("디자인 케이크".equals(prdName)) {
                int prdPrice = parseIntSafe(item.get("prdPrice"));
                int prdSizeprice = parseIntSafe(item.get("prdSizeprice"));
                int prdFruitprice = parseIntSafe(item.get("prdFruitprice"));
                int prdCandleprice = parseIntSafe(item.get("prdCandleprice"));
                int prdCoolingprice = parseIntSafe(item.get("prdCoolingprice"));
                itemTotal = (prdPrice + prdSizeprice + prdFruitprice + prdCandleprice + prdCoolingprice) * ctQty;
            } else if ("생일케이크".equals(ctgType) || "결혼식케이크".equals(ctgType) || "기념일케이크".equals(ctgType)) {
                int prdPrice = parseIntSafe(item.get("prdPrice"));
                int prdCandleprice = parseIntSafe(item.get("prdCandleprice"));
                int prdCoolingprice = parseIntSafe(item.get("prdCoolingprice"));
                itemTotal = (prdPrice + prdCandleprice + prdCoolingprice) * ctQty;
            } else {
                int prdPrice = parseIntSafe(item.get("prdPrice"));
                itemTotal = prdPrice * ctQty;
            }

            item.put("itemTotal", String.valueOf(itemTotal));
            totalPrice += itemTotal;

            cartItems.add(item);
        }

        if (!cartItems.isEmpty()) totalPrice += 3000;

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color: red;'>에러 발생: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>

<%! 
    public int parseIntSafe(String value) {
        try {
            return (value == null || value.trim().isEmpty()) ? 0 : Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return 0;
        }
    }
%>








<html>
<head>
    <title>장바구니</title>
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
     

.form-container {
    margin-bottom: 100px; /* 기존보다 더 늘려서 푸터와 간격 확보 */
}

.container h1 {
            font-size: 48px;
            padding-top: 130px;
            padding-bottom: 70px;
            padding-left: 60px;
			color:#C31D3B;
        }
        .left-menu {
			width:300px;
			margin-right: 60px;
}
.container {
    display: flex;
    align-items: flex-start;
    height: 100vh; 
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
    margin-left:40px;
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


.vertical-line {
    width: 1px;
    background-color: #744731;
    margin: 90px 20px;
    flex-shrink: 0;
    height: 1000px;
}

hr {
    border: none; / 기본 테두리 제거 /
    border-top: 2px solid #C31D3B;
    margin-top: -80px;
    height: 0; / 높이를 0으로 설정하여 선만 보이게 함 */
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



.stage {
    display: flex; /* Flexbox 활성화 */
    flex-direction: row; /* 수평 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    gap: 5px; /* 요소 간 간격 추가 (필요에 따라 조정) */
	margin-top:-50px;
	color: #744731;
	margin-left:770px;
}

.stage p {
	font-size:16px;
}

.stage img {
	width:16px;
	height:16px;
}

.cart_hr {
    border: none; /* 기본 테두리 제거 */
    border-top: 3px solid #744731; /* 두께 3px, 색상 #744731 */
    margin-top: 5px; /* 필요에 따라 여백 조정 */
    width: 950px;
	margin-left:50px;
}

/* Cart Items */
.cart-item {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 전체적으로 좌우 정렬 */
    width: 950px;
    min-height: 150px;
    border-bottom: 1px solid #744731;
    padding: 20px 0;
    margin-left: 50px;
    gap: 20px; /* 요소 간 간격 추가 */
}

/* 체크박스 */
.checkbox {
    width: 29px;
    height: 29px;
}

/* 상품 이미지 */
.cart-item img {
    width: 114px;
    height: 114px;
    margin-right: 20px; /* 이미지와 상품명 간 간격 */
}

/* 상품 정보 컨테이너 */
.prd-container {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    width: 300px; /* 상품 정보 영역 너비 지정 */
    margin-left: 10px; /* 적절한 여백 추가 */
}

/* 상품 정보와 오른쪽 요소들 간 자동 여백 */
.cart-item .prd-container {
    flex-grow: 1;
}

/* 상품명 */
.prdName {
    font-size: 22px;
    color: #744731;
    font-weight: bold;
}

/* 상품 가격 */
.prd-container p {
    font-size: 18px;
    color: #744731;
    font-weight: bold;
    margin: 5px 0;
}

/* 상세 옵션 */
.item-details {
    font-size: 14px;
    color: #744731;
    line-height: 1.5;
    max-width: 280px; /* 최대 너비 지정 */
}

.cart-actions {
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: flex-end;
    width: 300px; /* 고정된 너비 */
    gap: 20px; /* 요소 간격 */
    margin-left: auto; /* 자동 여백으로 오른쪽 정렬 */
}

/* 수량 조정 폼 */
.quantity-form {
    display: flex;
    align-items: center;
    gap: 5px;
}

.quantity-form input[type="text"] {
    width: 30px;
    height: 30px;
    text-align: center;
    font-size: 16px;
    border: 1px solid #744731;
    border-radius: 5px;
}

.quantity-form button {
    width: 30px;
    height: 30px;
    font-size: 18px;
    background-color: #FFF6ED;
    color: #744731;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

.quantity-form button:hover {
    background-color: #C31D3B;
    color: white;
}

/* 총 가격 */
.item-total {
    font-size: 24px;
    font-weight: bold;
    color: #744731;
	width:120px;
	text-align:right;
}

/* 삭제 버튼 */
.delete-btn {
    border: none;
    background: none;
    padding: 0;
    display: inline-block;
}

.delete-btn button {
    border: none;
    background: none;
    padding: 0;
    display: inline-block;
}

.delete-btn img {
    width: 24px;
    height: 24px;
    cursor: pointer;
}


.price {
	margin-top:70px;
}

	.price h2 {
		font-size:32px;
		color: #744731;
		margin-left:70px;
	}
	
	.price_box {
    background-color: #f2e9df;
    width: 916px;
    height: 146px;
    border-radius: 10px;
    margin-left: 70px;
    display: flex;
    align-items: center;
    justify-content: space-between; /* 요소들을 양쪽 끝에 배치 */
    padding: 20px;
    position: relative;
}

/* 총 상품 금액 및 배송비 (왼쪽) */
.expected_price, .b_price {
    text-align: center; 
	font-size: 24px;
}	

.left_price {
    display: flex; /* flexbox 활성화 */
    flex-direction: row; /* 가로 배치 */
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: center; /* 요소 가운데 정렬 */
    gap: 30px; /* 요소 사이 간격 */
	margin-left: 70px;
}


/* 총 결제 예정 금액 (오른쪽) */
.total_price {
    flex: 1; 
    text-align: center;
    margin-left: 110px;
	font-size: 24px;
}

/* 수직선 가운데 정렬 */
.price_hr {
    width: 1px; 
    height: 110px;
    background-color: #744731;
    border: none;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
	margin-top:10px;
}

/* 총 상품 수량 */
.totalquantity {
    font-size: 24px;
    color: #744731;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: center;
    width: 916px;
    height: 73px;
    margin-left: 70px;
}

.checkout-btn {
    display: block;
    margin-top: 50px;
    margin-bottom: 100px;
    margin-left: 300px;
    width: 457px;
    height: 69px;
    font-size: 24px;
    border-radius: 10px;
    background-color: #C31D3B;
    color: #fff;
    text-align: center;
    line-height: 69px; /* 버튼 높이와 동일하게 설정하여 수직 중앙 정렬 */
	font-weight: bold;
}

.empty {
	text-align:center;
	margin-left:80px;
	color: #744731;
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
            <a href="Mypage.jsp" id="small_menu"> 정보 수정 및 탈퇴</a>
            <a href="DeliveryHistory.jsp" id="small_menu">주문/배송 내역</a>
            <a href="Cart.jsp" id="small_menu" style="color: #C31D3B;">장바구니</a>
            <a href="Wishlist.jsp" id="small_menu">위시리스트</a>
            <a href="Mypage_PossibleReview.jsp" id="small_menu">작성 가능한 후기</a>
            <a href="Mypage_WrittenReview.jsp" id="small_menu">작성한 후기</a>
        </aside>
    </div>

    <hr class="vertical-line"> 

    
    <div class="main">
        <div class="mainheader">
            <h2>장바구니</h2>
        </div>
		<div class="stage">
			<p style="font-family:'NanumSquareNeoBold', sans-serif; color:#C31D3B;">장바구니</p>
			<img src="images/arrow.png" />
			<p>결제하기</p>
			<img src="images/arrow.png" />
			<p>주문완료</p>
		</div>

<hr class="cart_hr">

<% if (cartItems.isEmpty()) { %>
    <p class="empty">장바구니가 비어 있습니다.</p>
<% } else { 
    for (Map<String, String> item : cartItems) {
        String prdName = item.get("prdName");
        String ctgType = item.get("ctgType");
%>
<div class="cart-item">
    <!-- 체크박스 -->
    <input type="checkbox" name="selectedItems" value="<%= item.get("ctNo") %>" class="checkbox">

    <%-- 이미지 처리 --%>
    <%
        String imageSrc = "images/" + item.get("prdImage");
        if ("도안 케이크".equals(prdName)) {
            String designImg = item.get("prdDesign");
            if (designImg != null && !designImg.trim().isEmpty()) {
                imageSrc = "/onlycake/uploads/" + designImg;
            } else {
                imageSrc = "images/default_drawingcake.jpg";
            }
        } else if ("디자인 케이크".equals(prdName)) {
            imageSrc = "images/designCakeImage.jpg";
        }
    %>
    <img src="<%= imageSrc %>" alt="<%= prdName %>" style="max-width: 180px; max-height: 180px;">

    <div class="prd">
        <span class="prdName"><%= prdName %></span>

        <!-- 기본 가격 -->
        <% if ("도안 케이크".equals(prdName)) { %>
            <p>0 원</p>
        <% } else { %>
            <p><%= currencyFormat.format(Integer.parseInt(item.get("prdPrice"))) %> 원</p>
        <% } %>

        <!-- 옵션 출력 -->
        <div class="item-details">
        <%
            String[] keys = {};

            if ("도안 케이크".equals(prdName)) {
                keys = new String[] { "prdTaste", "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage", "prdDesign" };
            } else if ("디자인 케이크".equals(prdName)) {
                keys = new String[] { "prdTaste", "prdCakesize", "prdFruit", "prdTopcream", "prdBottomcream",
                                      "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage", "prdLettering" };
            } else if ("생일케이크".equals(ctgType) || "결혼식케이크".equals(ctgType) || "기념일케이크".equals(ctgType)) {
                keys = new String[] { "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage" };
            } else {
                keys = new String[] { "prdCandle", "prdCooling", "prdDeliverydate" };
            }

            boolean isFirst = true;
            for (String key : keys) {
                String value = item.get(key);
                if (value != null && !value.trim().isEmpty()) {
                    if (!isFirst) out.print(" / ");
                    isFirst = false;

                    if ("prdDeliverydate".equals(key)) {
        %>
                        <span><%= value %> (발송예정일)</span>
        <%
                    } else if ("prdDesign".equals(key)) {
        %>
                        <span>도안 이미지 첨부 완료</span>
        <%
                    } else {
        %>
                        <span><%= value %></span>
        <%
                    }
                }
            }
        %>
        </div>
    </div>

    <!-- 수량 변경 -->
    <form class="quantity-form" action="CartUpdate.jsp" method="post">
        <input type="hidden" name="ctNo" value="<%= item.get("ctNo") %>">
        <button type="submit" name="changeQty" value="-1">-</button>
        <input type="text" name="ctQty" value="<%= item.get("ctQty") %>" readonly>
        <button type="submit" name="changeQty" value="1">+</button>
    </form>

    <!-- 총 가격 -->
    <p class="item-total" id="itemTotal_<%= item.get("ctNo") %>">
        <%
            int prdPrice = parseIntSafe(item.get("prdPrice"));
            int ctQty = parseIntSafe(item.get("ctQty"));
            int prdSizeprice = parseIntSafe(item.get("prdSizeprice"));
            int prdFruitprice = parseIntSafe(item.get("prdFruitprice"));
            int prdCandleprice = parseIntSafe(item.get("prdCandleprice"));
            int prdCoolingprice = parseIntSafe(item.get("prdCoolingprice"));

            int itemTotal = 0;
            if ("도안 케이크".equals(prdName)) {
                itemTotal = 0;
            } else if ("디자인 케이크".equals(prdName)) {
                itemTotal = (prdPrice + prdSizeprice + prdFruitprice + prdCandleprice + prdCoolingprice) * ctQty;
            } else {
                itemTotal = (prdPrice + prdCandleprice + prdCoolingprice) * ctQty;
            }
        %>
        <%= currencyFormat.format(itemTotal) %> 원
    </p>

    <!-- 삭제 버튼 -->
    <form action="CartDelete.jsp" method="post" class="delete-btn">
        <input type="hidden" name="ctNo" value="<%= item.get("ctNo") %>">
        <button type="submit"><img src="images/delete.png" alt="삭제"></button>
    </form>
</div>
<% } %>

<!-- 총 수량 계산 -->
<%
    int totalQuantity = 0;
    for (Map<String, String> item : cartItems) {
        totalQuantity += parseIntSafe(item.get("ctQty"));
    }
%>

<!-- 결제 영역 -->
<div class="price">
    <h2>선택한 상품 결제 예정 금액</h2>
    <div class="price_box">
        <div class="left_price">
            <div class="expected_price">
                <p>총 상품 금액</p>
                <p id="selectedTotalPrice" style="font-weight: bold; margin-top:-10px;">0원</p>
            </div>

            <p style="font-size: 32px;">+</p>

            <div class="b_price">
                <p>배송비</p>
                <p style="font-weight: bold; margin-top:-10px;">3,000원</p>
            </div>
        </div>

        <hr class="price_hr">

        <div class="total_price">
            <p>총 결제 예정 금액</p>
            <p id="finalTotalPrice" style="font-weight: bold; margin-top:-10px;">0원</p>
        </div>
    </div>

    <div class="totalquantity">
        <p>총 상품 수량</p>
        <p id="selectedTotalQuantity" style="font-weight: bold; margin-left:10px;">0</p>
    </div>
</div>

</form>

<a href="javascript:void(0);" class="checkout-btn" onclick="goToPayment()">결제하기</a>
<% } %>

		</div> </div>
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

<script src="js/cart.js"></script>

</body>
</html>
