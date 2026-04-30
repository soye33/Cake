<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html>
<head>
<%
    String id = (String) session.getAttribute("sid");
    String memNickname = (String) session.getAttribute("memNickname");

    if (id == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // URL에서 questionIdx 가져오기
    String questionIdxParam = request.getParameter("questionIdx");
    int questionIdx = -1; // 기본값 설정

    if (questionIdxParam != null && !questionIdxParam.trim().isEmpty()) {
        try {
            questionIdx = Integer.parseInt(questionIdxParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    // questionIdx가 유효하지 않으면 경고 메시지 후 문의 목록으로 이동
    if (questionIdx == -1) {
%>
    <script>
        alert("잘못된 접근입니다.");
        location.href = "CustomerService_Inquiry.jsp"; // 문의 목록으로 이동
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String questionText = null;
    String questionCategory = null;
    String questionImage = null;
    String questionTitle = null;
    String questionAt = null;
	String writerNickname = null;


	int questionCount = 0;
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

		// 조회수 증가
// 1. 조회수 증가
String updateCountSQL = "UPDATE question SET questionCount = questionCount + 1 WHERE questionIdx = ?";
pstmt = conn.prepareStatement(updateCountSQL);
pstmt.setInt(1, questionIdx);
pstmt.executeUpdate();
pstmt.close();

// 2. 조회수 증가 후 최신 값 SELECT
String sql = "SELECT questionText, questionCategory, questionImage, questionTitle, questionAt, questionCount, memNickname FROM question WHERE questionIdx = ?";
pstmt = conn.prepareStatement(sql);
pstmt.setInt(1, questionIdx);
rs = pstmt.executeQuery();

 
if (rs.next()) {
	writerNickname = rs.getString("memNickname");
    questionText = rs.getString("questionText");
    questionCategory = rs.getString("questionCategory");
    questionImage = rs.getString("questionImage");
    questionTitle = rs.getString("questionTitle");
    questionAt = rs.getString("questionAt");
    questionCount = rs.getInt("questionCount"); 
}

 else {
%>
        <script>
            alert("문의 내역이 존재하지 않습니다.");
            location.href = "CustomerService_Inquiry.jsp"; // 문의 목록으로 이동
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
    <title>문의 작성 조회</title>
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
    justify-content: flex-start;
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

.inquiry{
	display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
	flex-direction: column;
}

.form-content label {
    font-size: 20px;
    color: #744731;
    white-space: nowrap; /* 줄 바꿈 방지 */
    margin-right: 10px; /* 제목과 간격 조정 */
	margin-left:30px;
}
.form-content p {
    font-size: 20px;
    color: #744731;
    width: 100%; /* 가로 길이를 부모 크기에 맞춤 */
    text-align: left; /* 텍스트를 왼쪽 정렬 */
    margin-left: 20px; /* 혹시라도 적용된 margin 초기화 */
}

.form-content3 label{
	font-size:20px;
	color: #744731;
	margin-left:30px;
}

.form-content3 p {
	font-size:20px;
	color: #744731;
	margin-left:40px;
}

.text-image-container {
    display: flex;
    flex-direction: column; /* 세로 정렬 */
    align-items: center; /* 중앙 정렬 */
    width: 100%;
    text-align: left; /* 텍스트 왼쪽 정렬 */
}


.form-content2 {
    width: 900px; /* 원하는 크기로 조정 */
    height: auto; /* 높이 자동 조절 */
    border: 2px solid #744731; /* 테두리 추가 */
    border-radius: 10px; /* 네모 칸 모양 */
    padding: 10px; /* 안쪽 여백 */
    display: flex;
    align-items: center; /* 세로 중앙 정렬 */
    justify-content: center; /* 가로 중앙 정렬 */
    flex-direction: column;
	margin-top:10px;
}

.form-content2 p {
    font-size: 20px;
    color: #744731;
    word-wrap: break-word; /* 긴 단어 줄바꿈 */
    overflow-wrap: break-word; /* 긴 단어 줄바꿈 */
    white-space: normal; /* 줄바꿈 허용 */
    margin-left:-47px;
    width: 100%;
    max-width: 800px; /* 텍스트 영역 최대 너비 지정 */
}

.inquiry-image {
    max-width: 100%; /* 이미지가 컨테이너보다 커지지 않도록 */
    height: auto;
    margin-top: 15px; /* 텍스트와 간격 조정 */
    border-radius: 10px; /* 이미지 모서리 둥글게 */
}

.view {
    display: flex;
    align-items: center;
    justify-content: right; /* 요소를 양쪽 끝으로 배치 */
    width: 900px;
    margin: 0 auto;
}

.view p {
	font-size:15px;
	color: #744731;
    text-align: right; /* 오른쪽 정렬 */
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
    height: 20px; /* 버튼 높이 고정 */
    padding: 15px 0; /* 버튼 높이를 균일하게 */
    font-size: 18px;
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
            <h2 class="title">작성된 문의</h2>
			<div class="person-information">
				<img src="images/user_profile.png" alt="profile">
				<p><%= writerNickname %></p>
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
                <div class="inquiry">
				<div class="form-content">
                    <label>제목&nbsp;&nbsp;&nbsp;|</label>
					<hr>
                    <p><%=questionTitle%></p>
					</div>
				<div class="form-content3">
					<label class="bun">분류&nbsp;&nbsp;&nbsp;</label>
                    <p><%=questionCategory%></p>
				</div>
				<div class="form-content2">
    <div class="text-image-container">
        <p><%=questionText%></p>
        <% if (questionImage != null && !questionImage.isEmpty()) { %>
    <img src="<%= request.getContextPath() %>/<%= questionImage %>" alt="첨부 이미지" class="inquiry-image">
<% } else { %>
    
<% } %>

    </div>
	

</div>
<div class="view">
	<p> 조회수: <%= questionCount %></p>
</div>
<script>
    // 비밀번호 입력 창을 띄우고 삭제 요청을 보냄
    // 비밀번호 입력 창을 띄우고 삭제 요청을 보냄
function confirmDelete(questionIdx) {
    let password = prompt("문의 삭제를 위해 비밀번호를 입력하세요:");
    if (password !== null && password.trim() !== "") {
        // 비밀번호 입력되었을 때 폼 제출
        document.getElementById("deleteForm").questionPwd.value = password;
        document.getElementById("deleteForm").questionIdx.value = questionIdx;
        document.getElementById("deleteForm").submit();
    } else {
        alert("비밀번호를 입력해야 합니다.");
    }
}


    // 비밀번호 입력 창을 띄우고 수정 페이지로 이동
    function confirmEdit(questionIdx) {
        let password = prompt("문의 수정을 위해 비밀번호를 입력하세요:");
        if (password != null && password.trim() !== "") {
            let url = "UpdateInquiry.jsp?questionIdx=" + questionIdx + "&questionPwd=" + encodeURIComponent(password);
            location.href = url;
        } else {
            alert("비밀번호를 입력해야 합니다.");
        }
    }
</script>

<div class="button-container">
    <!-- 삭제 버튼 -->
    <a href="javascript:void(0);" onclick="confirmDelete(<%= questionIdx %>)" class="delete-button">문의 삭제하기</a>

    <!-- 수정 버튼 -->
    <a href="javascript:void(0);" onclick="confirmEdit(<%= questionIdx %>)" class="edit-button">문의 수정하기</a>

    <!-- 전체 목록으로 이동 -->
    <a href="CustomerService_Inquiry.jsp" class="view-all-button">문의 모아보기</a>
</div>

<!-- 삭제 요청을 처리하는 숨겨진 폼 -->
<form id="deleteForm" method="post" action="DeleteInquiry.jsp" style="display: none;">
    <input type="hidden" name="questionIdx">
    <input type="hidden" name="questionPwd">
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