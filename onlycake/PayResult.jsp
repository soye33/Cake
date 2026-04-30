<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.text.NumberFormat, java.util.*" %>

<%
    request.setCharacterEncoding("EUC-KR");

    String id = (String) session.getAttribute("sid");
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='Login.jsp';</script>");
        return;
    }

    String ordNo = request.getParameter("ordNo");
    if (ordNo == null || ordNo.isEmpty()) {
        out.println("<script>alert('주문번호가 없습니다.'); location.href='Index.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    List<Map<String, String>> orderItems = new ArrayList<>();
    Map<String, String> orderInfo = new HashMap<>();

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 주문 기본 정보
        pstmt = conn.prepareStatement("SELECT * FROM orderinfo WHERE ordNo = ? LIMIT 1");
        pstmt.setString(1, ordNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            orderInfo.put("ordNo", ordNo);
            orderInfo.put("ordDate", rs.getString("ordDate"));
            orderInfo.put("ordReceiver", rs.getString("ordReceiver"));
            orderInfo.put("ordRcvaddress", rs.getString("ordRcvaddress"));
            orderInfo.put("ordRcvphone", rs.getString("ordRcvphone"));
            orderInfo.put("ordPay", rs.getString("ordPay"));
            orderInfo.put("ordBank", rs.getString("ordBank"));
            orderInfo.put("ordBankname", rs.getString("ordBankname"));
            orderInfo.put("shippingRequest", rs.getString("shippingRequest"));
        }
        rs.close();
        pstmt.close();

        // 주문된 상품들 조회 (상품명 포함)
        pstmt = conn.prepareStatement(
            "SELECT p.prdName, d.*, o.ordQty " +
            "FROM productDetail d " +
            "JOIN cake p ON d.prdNo = p.prdNo " +
            "JOIN orderinfo o ON d.ordNo = o.ordNo AND d.prdNo = o.prdNo " +
            "WHERE d.ordNo = ?"
        );
        pstmt.setString(1, ordNo);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            ResultSetMetaData meta = rs.getMetaData();
            for (int i = 1; i <= meta.getColumnCount(); i++) {
                item.put(meta.getColumnLabel(i), rs.getString(i));
            }
            orderItems.add(item);
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>에러: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }

    NumberFormat currencyFormat = NumberFormat.getInstance(Locale.KOREA);
%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <title>주문 완료</title>
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

.receipt-box {
    width: 700px;
    background: rgba(255, 255, 255, 0.8); /* 흰색에 90% 불투명도 */
    margin: 50px auto;
    padding: 40px;
    border: 3px dashed #C31D3B; /* 빨간 바느질 느낌 */
    border-radius: 10px;
    box-shadow: 5px 5px 15px rgba(0,0,0,0.2);
    font-family: 'NanumSquareNeo';
    font-size: 16px;
    color: #744731;
    line-height: 1.8;
    position: relative;
    clip-path: polygon(
        0% 0%, 100% 0%, 100% 95%, 
        98% 97%, 95% 94%, 92% 97%, 89% 94%, 86% 97%, 83% 94%, 
        80% 97%, 77% 94%, 74% 97%, 71% 94%, 68% 97%, 65% 94%, 
        62% 97%, 59% 94%, 56% 97%, 53% 94%, 50% 97%, 47% 94%, 
        44% 97%, 41% 94%, 38% 97%, 35% 94%, 32% 97%, 29% 94%, 
        26% 97%, 23% 94%, 20% 97%, 17% 94%, 14% 97%, 11% 94%, 
        8% 97%, 5% 94%, 2% 97%, 0% 95%
    );
}

.receipt-box h2 {
    text-align: center;
    margin-bottom: 20px;
    padding-bottom: 10px;
}

.receipt-box .section {
    margin-bottom: 20px;
}

.receipt-box .label {
    display: inline-block;
    width: 120px;
}

.receipt-box .value {
    display: inline-block;
    float: right;
    text-align: right;
}

.receipt-box .divider {
    border-top: 1px dashed #bbb;
    margin: 15px 0;
}

.ellipsis {
    display: inline-block;
    max-width: 400px; /* 필요에 따라 조절 가능 */
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    vertical-align: middle;
}

.button-container {
    text-align: center;
}

.confirm-button {
    padding: 10px 30px;
    background-color: #C31D3B;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 16px;
    font-family: 'NanumSquareNeo';
    cursor: pointer;
	margin-bottom:50px;
	margin-top:-40px;
    transition: background-color 0.3s ease;
}

.product-item {
    margin-bottom: 15px;
}

.product-info-title {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.product-options {
    font-size: 12px;
    color: #888;
    margin-left: 10px;
    margin-top: -5px;
}

.stage {
    display: flex;
    justify-content: flex-end;  /*  오른쪽 정렬 */
    align-items: center;
    gap: 5px;
    margin-bottom: 0px;
    margin-top: -50px;
    color: #744731;
    margin-right: 10px;  /*  오른쪽으로 더 붙이고 싶을 때 */
}


.stage p {
    font-size: 16px;
}

.stage img {
    width: 16px;
    height: 16px;
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



    <div class="receipt-box">
	<div style="border-bottom: 1px dotted #999; margin-bottom:20px;">
    <h2>주문 영수증</h2>
<div class="stage">
			<p >장바구니</p>
			<img src="images/arrow.png" />
			<p>결제하기</p>
			<img src="images/arrow.png" />
			<p style="font-family:'NanumSquareNeoBold', sans-serif; color:#C31D3B;">주문완료</p>
		</div>
		</div>
    <div class="section">
        <div><span class="label">주문번호</span><span class="value"><%= ordNo %></span></div>
        <div><span class="label">주문일자</span><span class="value"><%= orderInfo.get("ordDate") %></span></div>
    </div>

    <div class="divider"></div>

    <div class="section">
    <div><span class="label">수령인</span><span class="value"><%= orderInfo.get("ordReceiver") %></span></div>
    <div><span class="label">주소</span><span class="value"><%= orderInfo.get("ordRcvaddress") %></span></div>
    <div><span class="label">전화번호</span><span class="value"><%= orderInfo.get("ordRcvphone") %></span></div>
    <div><span class="label">배송 요청사항</span><span class="value"><%= orderInfo.get("shippingRequest") != null ? orderInfo.get("shippingRequest") : "-" %></span></div>
    <div><span class="label">결제 수단</span><span class="value"><%= orderInfo.get("ordBank") %></span></div>
    <div><span class="label">주문자명</span><span class="value"><%= orderInfo.get("ordBankname") %></span></div>
</div>


    <div class="divider"></div>

    <div class="section">
    <strong>상품 목록</strong>
    <% for (Map<String, String> item : orderItems) {
        String prdName = item.get("prdName");
        String[] keys;

        if ("도안 케이크".equals(prdName)) {
            keys = new String[] { "prdTaste", "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage", "prdDesign" };
        } else if ("디자인 케이크".equals(prdName)) {
            keys = new String[] { "prdTaste", "prdCakesize", "prdFruit", "prdTopcream", "prdBottomcream", "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage", "prdLettering" };
        } else {
            keys = new String[] { "prdCandle", "prdCooling", "prdDeliverydate", "prdMessage" };
        }
    %>
        <div class="product-item">
            <div class="product-info-title">
                <span class="label ellipsis"><%= prdName %></span>
                <span class="value"><%= item.get("ordQty") %>개</span>
            </div>
            <div class="product-options">
                <%
                    boolean first = true;
                    for (String key : keys) {
                        String val = item.get(key);
                        if (val != null && !val.trim().isEmpty()) {
                            if (!first) out.print(" / ");
                            first = false;
                            if ("prdDeliverydate".equals(key)) {
                                out.print(val + " (발송예정일)");
                            } else if ("prdDesign".equals(key)) {
                                out.print("도안 이미지 첨부 완료");
                            } else {
                                out.print(val);
                            }
                        }
                    }
                %>
            </div>
        </div>
    <% } %>
</div>


    <div class="divider"></div>

    <div class="section">
        <div><span class="label">결제 금액</span><span class="value"><%= currencyFormat.format(Integer.parseInt(orderInfo.get("ordPay"))) %>원</span></div>
        <div><span class="label">주문자명</span><span class="value"><%= orderInfo.get("ordBankname") %></span></div>
    </div>
</div>

<div class="button-container">
    <form action="DeliveryHistory.jsp" method="get">
        <button type="submit" class="confirm-button">확인</button>
    </form>
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