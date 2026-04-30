<%@ page contentType="text/html;charset=EUC-KR" %>

<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
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
	margin-top: 40px;
}

#canvas {
    width: 500px; 
    height: 500px; 
    background-color: #FFF6ED; 
    margin: 0; 
    align-self: flex-start; /* canvas를 왼쪽 정렬 */
	margin-top: 10px;
}
#canvas img{
    width: 500px; 
    height: 500px; 
    
    margin: 0; 
}

.content1 {
    display: flex;
    flex-direction: column; /* 세로 방향으로 배치 */
    height: 100%; /* 전체 높이 사용 */
    margin-left: 20px; /* canvas와의 간격 조정 */
}

.cake_detail {
    width: 600px; 
    height: auto; 
    background-color: #FFF6ED; 
    margin: 0; 
}

.form_container {
    width: 600px; 
    height: 500px; 
    background-color: #FFF6ED; 
    margin-top: 8px; /* cake_detail과의 간격 조정 */
	border: 1px solid #C31D3B;
}
.cake_name{
	color:#C31D3B; 
	font-size: 25px; 
	font-family: 'NanumSquareNeoExtraBold', sans-serif;
}
.cake_price{
	color:#744731; 
	font-size: 20px; 
	font-family: 'NanumSquareNeoBold', sans-serif;
}
.cake_detailcontent{
	color:#744731; 
	font-size: 16px;
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

<%
    String prdNoParam = request.getParameter("prdNo"); // 쿼리 파라미터에서 prdNo 가져오기
    int prdNo = Integer.parseInt(prdNoParam); // int로 변환

    // DB 연결 및 제품 정보 조회
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake"; 
        String DB_ID = "multi"; 
        String DB_PASSWORD = "abcd"; 

        Class.forName("org.gjt.mm.mysql.Driver"); 
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
        String sql = "SELECT * FROM cake WHERE prdNo = ?"; 
        PreparedStatement pstmt = con.prepareStatement(sql);
        pstmt.setInt(1, prdNo); // prdNo 설정
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            String prdName = rs.getString("prdName");
            int prdPrice = rs.getInt("prdPrice");
            String prdDetail = rs.getString("prdDetail");
            String prdImage = rs.getString("prdImage");

            NumberFormat formatter = NumberFormat.getInstance(Locale.KOREA);
            String formattedPrice = formatter.format(prdPrice);
%>


<div class="wrapper">  <!--3D 공간과 옵션폼 감싸는 공간-->

    <div id="canvas"><img src="images/<%= prdImage %>" alt="<%= prdName %>"></div>

    <div class="content1">    
        <div class="cake_detail">
            <p class="cake_name"><%= prdName %></p>
            <p class="cake_price">가격: <%= formattedPrice %></p>
            <p class="cake_detailcontent"><%= prdDetail %> 지정하신 발송 날짜로부터 약 1~2일 뒤에 택배 수령 가능합니다. 제작 기간이 있어 당일 날짜 기준 +5일후부터 28일후까지 예약 가능합니다.</p>
            <p style="font-size: 15px; color: #744731;">배송비 : 기본 3,000원</p>
        </div>
    

    <div class="form_container">   <!--옵션폼-->
        <form id="cakeForm" action="CartAdd.jsp" method="post" enctype="multipart/form-data">

            <!-- 제품 번호 prdNo를 hidden으로 전달 -->
            <input type="hidden" name="prdNo" value="<%= prdNo %>">

            <!-- 초 추가구매 -->
            <label for="prdCandle" style="margin-top: 20px;">초 추가구매</label>
            <select id="prdCandle" name="prdCandle" onchange="updateCandlePrice()">
                <option value="초 구매 안함(+0)" data-price="0">초 구매 안함(+0)</option>
                <option value="일반초 5개입 세트(+1,000)" data-price="1000">일반초 5개입 세트(+1,000)</option>
                <option value="하트초(+1,000)" data-price="1000">하트초(+1,000)</option>
                <option value="스마일초(+1,000)" data-price="1000">스마일초(+1,000)</option>
            </select>
            <input type="hidden" name="prdCandleprice" id="prdCandleprice" value="0">

            <!-- 보냉포장 -->
            <label for="prdCooling">보냉포장</label>
            <select id="prdCooling" name="prdCooling" onchange="updateCoolingPrice()">
                <option value="보냉포장 X (5~8월에 선택시 자동 주문취소)" data-price="0">보냉포장 X (5~8월에 선택시 자동 주문취소)</option>
                <option value="보냉포장 O (+2,000)" data-price="2000">보냉포장 O (+2,000)</option>
            </select>
            <input type="hidden" name="prdCoolingprice" id="prdCoolingprice" value="0">

            <!-- 배송 날짜 -->
            <label for="cake_deliverydate">상품 발송 날짜 선택</label>
            <input type="date" id="date" name="prdDeliverydate" required>
            
            <!-- 특별 요청 사항 -->
            <label for="cake_message">특별 요청 사항</label>
            <textarea id="cake_message" name="prdMessage" 
            placeholder="알레르기 또는 요청사항 적어주시면 최대한 맞춰서 제작해드립니다."></textarea>
            
            <div class="button_container">
                <button class="cart_button" type="submit" name="action" value="addCart">장바구니</button> 
                <!--<button class="buy_button" type="submit" name="action" value="buyNow">구매하기</button>-->
            </div>
        </form>
    </div><!--<div class="form_container">의 닫는곳-->
	</div> <!-- <div class="content1">의 닫는곳 -->
</div>   <!--<div class="wrapper">의 닫는곳 -->



	 
<%
        } else {
            out.println("제품을 찾을 수 없습니다.");
        }

        rs.close();
        pstmt.close();
        con.close();
    } catch (Exception e) {
        out.println("오류: " + e.getMessage());
    }
%>
	 
    <script>
	
		function updateCandlePrice() {
    const candleSelect = document.getElementById("prdCandle");
    const selectedOption = candleSelect.options[candleSelect.selectedIndex];
    document.getElementById("prdCandleprice").value = selectedOption.getAttribute("data-price");
}

function updateCoolingPrice() {
    const coolingSelect = document.getElementById("prdCooling");
    const selectedOption = coolingSelect.options[coolingSelect.selectedIndex];
    document.getElementById("prdCoolingprice").value = selectedOption.getAttribute("data-price");
}
	 
	

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
</body>
</html>
