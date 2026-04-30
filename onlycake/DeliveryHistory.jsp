<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Map, java.util.HashMap, java.util.List, java.util.ArrayList, java.util.LinkedHashMap, java.text.SimpleDateFormat" %>


<html>
<head>
<title>마이페이지 - 주문/배송 내역</title>
<%
    String id = (String) session.getAttribute("sid");
	String memNickname = (String) session.getAttribute("memNickname");

    if (id == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String memId = id;
	
    String memName = null;
    String memEmail = null;
    String memPwd = null;  
    String memPhone = null;     
    String memBirth = null;  
    String memSex = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

       String sql = "SELECT memName, memNickname, memBirth, memEmail, memPwd, memSex, memPhone FROM member WHERE memId = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, memId);
        rs = pstmt.executeQuery();

      
    if (rs.next()) {
            memName = rs.getString("memName");
            memNickname = rs.getString("memNickname");
            memBirth = rs.getString("memBirth");
            memEmail = rs.getString("memEmail");
            memPwd = rs.getString("memPwd");
            memSex = rs.getString("memSex");
            memPhone = rs.getString("memPhone");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

<%
    Connection conn2 = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs2 = null;
    List<Map<String, String>> orderList = new ArrayList<>();

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/cake", "multi", "abcd");

        String sql2 = "SELECT o.ordDate, o.ordNo, o.ordSeq, o.ordPay, o.deliveryStatus, " +
              "c.prdName, c.prdImage, pd.prdDesign " +
              "FROM orderinfo o " +
              "JOIN cake c ON o.prdNo = c.prdNo " +
              "LEFT JOIN productDetail pd ON o.ordNo = pd.ordNo AND o.ordSeq = pd.ordSeq " +
              "WHERE o.memNickname = ? " +
              "ORDER BY o.ordDate DESC";

pstmt2 = conn2.prepareStatement(sql2);
pstmt2.setString(1, memNickname); // 닉네임으로 조회


        rs2 = pstmt2.executeQuery();


while (rs2.next()) {
	
    Map<String, String> item = new HashMap<>();
    item.put("ordDate", rs2.getString("ordDate"));
    item.put("ordNo", rs2.getString("ordNo"));
    item.put("ordSeq", rs2.getString("ordSeq")); 
    item.put("ordPay", rs2.getString("ordPay"));
    item.put("deliveryStatus", rs2.getString("deliveryStatus"));
    item.put("prdName", rs2.getString("prdName"));
    item.put("prdImage", rs2.getString("prdImage"));
    item.put("prdDesign", rs2.getString("prdDesign"));

    orderList.add(item);
}

} catch (Exception e) {
    e.printStackTrace();
    out.println("<p style='color:red;'>에러 발생: " + e.getMessage() + "</p>");
} finally {
    try { if (rs2 != null) rs2.close(); } catch (SQLException ignored) {}
    try { if (pstmt2 != null) pstmt2.close(); } catch (SQLException ignored) {}
    try { if (conn2 != null) conn2.close(); } catch (SQLException ignored) {}
}

%>
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

/* 주문 내역 전체 컨테이너 */
.order-group {
    border: 1px solid #d6a98c;
    margin-bottom: 30px;
    padding: 10px 20px;
    border-radius: 8px;
    background-color: #fffaf6;
}
.order-group {
    position: relative;
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center; /* 여기로 수직 정렬 */
    margin-bottom: 10px;
    position: relative;
}

.order-date {
    font-size: 16px;
    font-weight: bold;
    color: #744731;
    margin: 0; /* 기본 p 태그 마진 제거 */
    line-height: 1; /* 줄 높이도 정리 */
}

.order-link {
    font-size: 22px;
    font-weight: bold;
    color: #744731;
    text-decoration: none;
    padding: 0 10px;
    display: flex;
    align-items: center;
    justify-content: center;
}


/* 개별 주문 아이템 박스 */
.order-item {
    display: flex;
    align-items: center;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 6px;
}

/* 상품 이미지 */
.product-image {
    width: 80px;
    height: 80px;
    border-radius: 8px;
    object-fit: cover;
    margin-right: 15px;
}

/* 상품 이름과 가격 영역 */
.order-info {
    flex-grow: 1;
}

.product-name {
    font-size: 18px;
    color: #744731;
}

.product-price {
    color: #C31D3B;
    margin-top: 5px;
}

/* 배송 상태 뱃지 */
.order-status {
    padding: 5px 12px;
    border-radius: 20px;
    font-weight: bold;
    font-size: 13px;
    color: #fff;
}

.status-ready {
    background-color: #137D0A;
}

.status-shipping {
    background-color: #1B7EFF;
}

.status-done {
    background-color: #646464;
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
            <a href="Mypage.jsp" id="small_menu" >정보 수정 및 탈퇴</a>
            <a href="DeliveryHistory.jsp" id="small_menu" style="color: #C31D3B;">주문/배송 내역</a>
            <a href="Cart.jsp" id="small_menu">장바구니</a>
            <a href="Wishlist.jsp" id="small_menu">위시리스트</a>
            <a href="Mypage_PossibleReview.jsp" id="small_menu">작성 가능한 후기</a>
            <a href="Mypage_WrittenReview.jsp" id="small_menu">작성한 후기</a>
        </aside>
    </div>
    
    <hr class="vertical-line">
		
		<div class="main">
		<div class="mainheader">
            <h2>주문/배송 내역</h2>
        </div>

		<%
Map<String, List<Map<String, String>>> groupedOrders = new LinkedHashMap<>();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

for (Map<String, String> item : orderList) {
    String date = sdf.format(new java.text.SimpleDateFormat("yyyy-MM-dd").parse(item.get("ordDate")));
String ordNo = item.get("ordNo");
String groupKey = date + "_" + ordNo;


groupedOrders.putIfAbsent(groupKey, new ArrayList<>());
groupedOrders.get(groupKey).add(item);

}
%>

<% for (Map.Entry<String, List<Map<String, String>>> entry : groupedOrders.entrySet()) {
    String key = entry.getKey();
    String displayDate = key.split("_")[0]; // 화면에는 날짜만 보여줌
%>
<div class="order-group">
    <div class="order-header">
    <p class="order-date"><%= displayDate %></p>
    <%
        String ordNo = entry.getValue().get(0).get("ordNo"); 
    %>
    <a href="PayResult.jsp?ordNo=<%= ordNo %>" class="order-link">&gt;</a>
</div>


    <% for (Map<String, String> item : entry.getValue()) {
        String status = item.get("deliveryStatus");
        String badgeClass = "status-default";
if ("배송중".equals(status)) badgeClass = "status-shipping";
else if ("배송준비중".equals(status)) badgeClass = "status-ready";
else if ("배송완료".equals(status)) badgeClass = "status-done";


    %>
    <div class="order-item">
        <%
String prdName = item.get("prdName");
String prdDesign = item.get("prdDesign");
String prdImage = item.get("prdImage");
String imageSrc = "images/designCakeImage.jpg"; // 기본값

if ("도안 케이크".equals(prdName)) {
    if (prdDesign != null && !prdDesign.trim().isEmpty() && !"null".equalsIgnoreCase(prdDesign.trim())) {
       String encodedDesign = java.net.URLEncoder.encode(prdDesign.trim(), "UTF-8").replace("+", "%20");
imageSrc = "/onlycake/uploads/" + encodedDesign;

    } else {
        imageSrc = "images/designCakeImage.jpg"; // 도안 미업로드 시
    }
} else {
    if (prdImage != null && !prdImage.trim().isEmpty()) {
        imageSrc = "images/" + prdImage.trim();
    }
}
%>


<img src="<%= imageSrc %>" class="product-image">


        <div class="order-info">
            <div class="product-name"><%= item.get("prdName") %></div>
        </div>
        <div class="order-status <%= badgeClass %>">
            <%= status %>
        </div>
    </div>
    <% } %>
</div>
<% } %>

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
