<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.io.*" %>
<html>
<head>
<%
    // 로그인 체크
    String id = (String) session.getAttribute("sid");
    String memNickname = (String) session.getAttribute("memNickname");
    if (id == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // URL에서 questionIdx와 비밀번호 가져오기
    String questionIdxParam = request.getParameter("questionIdx");
    String questionPwdInput = request.getParameter("questionPwd");
    int questionIdx = -1;

    if (questionIdxParam != null && !questionIdxParam.trim().isEmpty()) {
        try {
            questionIdx = Integer.parseInt(questionIdxParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    if (questionIdx == -1 || questionPwdInput == null || questionPwdInput.trim().isEmpty()) {
%>
    <script>
        alert("잘못된 접근입니다.");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
        return;
    }

    // 데이터베이스 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String questionText = null;
    String questionCategory = null;
    String questionImage = null;
    String questionTitle = null;
    String questionPwdDB = null;
    String questionAt = null;

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 기존 문의 내역 조회
        String sql = "SELECT questionTitle, questionText, questionCategory, questionImage, questionPwd, questionAt FROM question WHERE questionIdx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, questionIdx);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            questionTitle = rs.getString("questionTitle");
            questionText = rs.getString("questionText");
            questionCategory = rs.getString("questionCategory");
            questionImage = rs.getString("questionImage");
            questionPwdDB = rs.getString("questionPwd");
            questionAt = rs.getString("questionAt");
        } else {
%>
    <script>
        alert("문의 내역이 존재하지 않습니다.");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
            return;
        }

        // 비밀번호 검증
        if (!questionPwdDB.equals(questionPwdInput)) {
%>
    <script>
        alert("비밀번호가 일치하지 않습니다.");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
            return;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>

    <meta charset="EUC-KR">
    <title>문의 수정하기</title>
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
.title {
    font-size: 30px;
    text-align: center;
    color: #C31D3B;
	margin-top:50px;
}
.person-information {
    display: flex;
    align-items: center;
    justify-content: space-between; /* 요소를 양쪽 끝으로 배치 */
    width: 900px;
    margin: 0 auto;
}

.person-information img {
    width: 60px;
    height: 60px;
}

.person-information p {
    font-size: 20px;
    color: #744731;
    margin: 0;
    flex-grow: 1; /* 닉네임이 중앙에 위치하도록 유동적으로 배치 */
    margin-left: 20px;
}

.person-information span {
    font-size: 20px;
    color: #744731;
    margin: 0;
    text-align: right; /* 오른쪽 정렬 */
    min-width: 150px; /* 최소 너비 지정 (조정 가능) */
}

.form-content  {
    width: 900px; /* 원하는 크기로 조정 */
    height: 50px; /* 높이 조정 */
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
    width: 900px; /* 원하는 크기로 조정 */
    height: 50px; /* 높이 조정 */
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
	width: 900px; /* 원하는 크기로 조정 */
    height: 450px; /* 높이 조정 */
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
    width: 900px; /* 원하는 크기로 조정 */
    height: 50px; /* 높이 조정 */
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
    font-size: 20px;
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


.inquiry{
	display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
	flex-direction: column;
}

.form-content label{
	font-size:20px;
	margin-left:30px;
	color: #744731;
}

.form-content input[type="text"] {
    height: 50px;
	width:800px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
	font-size: 20px;
	position: relative;
    left: 0px; /* Move left by 100px */
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-family:'NanumSquareNeo', sans-serif;
}

.form-content input[type="text"]::placeholder{
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-size: 20px;
	font-family:'NanumSquareNeo', sans-serif;
}

.form-content3 label{
	font-size:20px;
	margin-left:30px;
	color: #744731;
}

.form-content3 select {
	font-size: 20px;
	margin-left:30px;
	height:50px;
	width:640px;
	font-family:'NanumSquareNeo', sans-serif;
	color: #744731;
}

.form-content2 textarea {
    height:400px;
	width:850px;
    border: none; /* 테두리 없애기 */
    background: none; /* 배경색 없애기 */
	font-size: 20px;
	resize: none;
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-family:'NanumSquareNeo', sans-serif;
}

.form-content2 textarea::value{
	color: #744731; /* placeholder 색상도 동일하게 */
	opacity: 0.7; /* 조금 연하게 */
	font-size: 20px;
	font-family:'NanumSquareNeo', sans-serif;
	position: absolute;
    top: 30px;
    left: 10px;
    transform: translateY(-50%);
}

.inquiry-image {
    max-width: 100%; /* 이미지가 컨테이너보다 커지지 않도록 */
    height: auto;
    margin-top: 15px; /* 텍스트와 간격 조정 */
    border-radius: 10px; /* 이미지 모서리 둥글게 */
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
    justify-content: center; /* 가운데 정렬 */
    align-items: center; /* 수직 정렬 */
    margin-top: 50px; /* 버튼과 콘텐츠 사이 간격 조정 */
    margin-bottom: 300px; /* 푸터와의 간격 조정 */
}

.button {
    display: block;
    width: 300px;
    height: 50px;
    font-size:18px;
    background-color: #C31D3B;
    color: white;
    border: none;
    border-radius: 64px;
    cursor: pointer;
    font-family: 'NanumSquareNeoBold', sans-serif;
}

.button:hover {
    background-color: #A11B2F;
}

        .image-upload-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            max-width: 900px;
            margin-top: 20px;
        }
        .existing-image img {
            max-width: 500px;
            height: auto;
            border-radius: 10px;
        }

		.image-font {
			font-family: 'NanumSquareNeo', sans-serif;
			color: #744731;
			display: flex;
			align-items: center;  /* 중앙 정렬 */
			gap: 10px; 
			text-align:center;
				}
		.image-font label {
			font-size:20px;
			margin-left:20px;
		}
		.image-font input[type="file"] {
    font-family: 'NanumSquareNeoBold', sans-serif;
    color: #744731;
    font-size: 18px; /* 글씨 크기 증가 */
    width: 300px; /* 너비 조정 */
    padding: 10px; /* 내부 여백 추가 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 버튼 모양 둥글게 */
    cursor: pointer; /* 마우스 오버 시 포인터 변경 */
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
    
    <div class="content">
        <div class="content2">
            <h2 class="title">문의 수정하기</h2>
			<div class="person-information">
				<img src="images/user_profile.png" alt="profile">
				<p><%= memNickname %></p>
<%
    String formattedDate = "";
    if (questionAt != null) {
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date date = originalFormat.parse(questionAt);
        formattedDate = targetFormat.format(date);
    }
%>
<span><%= formattedDate %></span>
			</div>
			<form action="UpdateInquiry_Ok.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" name="questionIdx" value="<%= questionIdx %>">
        <input type="hidden" name="questionPwd" value="<%= questionPwdInput %>">
                <div class="inquiry">
				<div class="form-content">
                    <label>제목&nbsp;&nbsp;&nbsp;|</label>
					<hr>
                    <input type="text" name="questionTitle" value="<%= questionTitle %>" required>
					</div>
				<div class="form-content3">
    <label class="bun">분류&nbsp;&nbsp;&nbsp;</label>
    <select id="category" name="questionCategory">
        <option value="도안문의" <%= "도안문의".equals(questionCategory) ? "selected" : "" %>>도안문의</option>
        <option value="배송/결제" <%= "배송/결제".equals(questionCategory) ? "selected" : "" %>>배송/결제</option>
        <option value="교환/환불" <%= "교환/환불".equals(questionCategory) ? "selected" : "" %>>교환/환불</option>
        <option value="기타문의" <%= "기타문의".equals(questionCategory) ? "selected" : "" %>>기타문의</option>
    </select>
</div>

				<div class="form-content2">
        <textarea name="questionText" rows="5" cols="50" required><%= questionText %></textarea>
				</div>
					<div class="image-upload-container">
    <div class="existing-image">
        <% if (questionImage != null && !questionImage.isEmpty()) { %>
            <img id="existingImage" src="<%= request.getContextPath() %>/<%= questionImage %>" alt="기존 이미지">
        <% } %>
    </div>
	<div class="image-font">
    <label>새 이미지 업로드:</label>
    <input type="file" name="questionImage" id="imageUpload">
    <input type="hidden" name="existingImage" value="<%= questionImage %>">
</div>


			</div>
        </div>
    </div>
	<div class="button-container">
    <input type="submit" value="수정하기" class="button">
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
        document.getElementById("imageUpload").addEventListener("change", function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById("existingImage").src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        let today = new Date();
        let formattedDate = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
        document.getElementById("currentDate").textContent = formattedDate;
    });
</script>
<script>
    document.getElementById("photoUpload").addEventListener("change", function(event) {
        const file = event.target.files[0];
        const fileInfo = document.getElementById("fileInfo");
        const previewImage = document.getElementById("previewImage");

        if (file) {
            fileInfo.textContent = ${file.name};

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