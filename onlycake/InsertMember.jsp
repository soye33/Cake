<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1"> <%--width=device-width → 기기 화면 크기에 맞게 조정
initial-scale=1 → 초기 배율을 100%로 설정--%>

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
    top: 20px;
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
	margin-top:-2px;
}

/* 네비게이션 */
nav {
    display: flex;
    justify-content: center; /* 메뉴 왼쪽으로 정렬 */
    align-items: center;
    margin-left: -10px; /* 메뉴를 왼쪽으로 조금 이동 */
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


#content {
    text-align: center;
	background-color: #FFF6ED;
  background-size: cover; /* 배경을 전체 크기로 맞춤 */
  background-repeat: no-repeat;
  background-position: center;
  min-height: 100vh; /* 화면 전체 높이만큼 배경 적용 */
  padding: 20px;
}

#content h2{
		margin-top:20px;
		font-size:35px;
		color:#C31D3B;
}
#content img {
		margin-top:-5px;
		width:100px;
		height:100px;
		margin-bottom: 20px;
}
.form-container{
            width: 700px;
            margin: 0 auto 10px;
        }
        .form-group {
            display: flex;
            align-items: center;
            padding: 5px 0;
        }
        .form-group:last-child {
            border-bottom: none;
        }
        .form-group label {
            width: 200px;
            font-size: 22px;
            display: flex;
            align-items: center;
			color:#744731;
        }
		.form-group #nickname, .form-group #id {
			width: 486px;
		}
	
	 .form-group input[type="text"] {
            width: 600px;
            padding: 6px; 
            font-size: 18px;
            border: 1px solid #744731;
            border-radius: 5px;
			color: #744731; /* placeholder 색상도 동일하게 */
			opacity: 0.7; /* 조금 연하게 */
        }
		.form-group input[type="password"] {
            width: 600px;
            padding: 6px; 
            font-size: 18px;
            border: 1px solid #744731;
            border-radius: 5px;
			color: #744731; /* placeholder 색상도 동일하게 */
			opacity: 0.7; /* 조금 연하게 */
        }
		.check-id-btn, .check-nickname-btn {
        margin-left: 10px;
        width:100px;
		height:35px;
        font-size: 15px;
        color: white;
        background-color: #744731;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
		font-family:'NanumSquareNeoBold', sans-serif;
        }
	 .form-group input[type="date"] {
            width: 600px;
            padding: 6px; 
            font-size: 18px;
            border: 1px solid #744731;
            border-radius: 5px;
			color: #744731; /* placeholder 색상도 동일하게 */
			opacity: 0.7; /* 조금 연하게 */
        }
	 .phone-group {
		display: flex;
		align-items: center;
	}

	.phone-group select,.phone-group input[type="tel"] {
		width: 120px;
		padding: 6px;
		font-size: 18px;
		border: 1px solid #744731;
        border-radius: 5px;
		color: #744731; /* placeholder 색상도 동일하게 */
		opacity: 0.7; /* 조금 연하게 */
	}
	.phone-group input[type="tel"]::placeholder, .form-group input[type="date"]::placeholder, .form-group input[type="password"]::placeholder, .form-group input[type="text"]::placeholder{
		color: #744731; /* placeholder 색상도 동일하게 */
		opacity: 0.7; /* 조금 연하게 */
		font-size: 18px;
		font-family:'NanumSquareNeo', sans-serif;
	}
	.phone-group p {
		margin: 0 5px;
		font-size: 18px;
		color: #744731;
	}
	.phone-group{
		margin-left:-25px;
	}
	.sex-group {
    display: flex; /* 수평 정렬을 위해 flexbox 사용 */

}
.sex-group label {
    display: flex;
    align-items: center;
    font-size: 18px;
    color: #744731;
	margin-right:62px;
}

.sex-group input[type="radio"] {
    margin: 10px 20px 10px;
    width: 20px;
    height: 20px;
}

        .submit-btn {
    display: flex;
    align-items: center;       /* 수직 가운데 정렬 */
    justify-content: center;   /* 수평 가운데 정렬 */
    padding: 0;                /* 기존 패딩 제거 */
    font-size: 22px;
    color: white;
    background-color: #C31D3B;
    border: none;
    border-radius: 64px;
    cursor: pointer;
    margin: 40px auto;
    width: 150px;
    height: 40px;
    text-align: center;
    font-family: 'NanumSquareNeoBold', sans-serif;
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
    
        <p><a href="Login.jsp">로그인 / 회원가입</a></p>
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
<div id="content">
	<h2>회원가입</h2>
	<img src="images/user_profile.png" />
		<div id="infomation">
		<form name="newMem" method="post" action="InsertMember_Result.jsp">
    <div class="form-container">

        <div class="form-group">
    <label for="name">
         이름 </label>
    <input type="text" id="name" name="name" placeholder="이름을 입력해주세요"> 
   </div>

        <div class="form-group">
            <label for="password">닉네임</label>
            <input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력해주세요">
			<button type="button" class="check-nickname-btn" onclick="CheckNickname()">중복체크</button>
        </div>
        <div class="form-group">
            <label for="email">이메일</label>
            <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요">
        </div>
        <div class="form-group">
            <label for="birthdate">생년월일</label>
            <input type="date" id="birthdate" name="birthdate" placeholder="YYYYMMDD">
        </div>
		<div class="form-group">
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" placeholder="아이디를 입력해주세요">
			<button type="button" class="check-id-btn" onclick="CheckId()">중복체크</button>

        </div>
		<div class="form-group">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력해주세요">
        </div>
        <div class="form-group">
    <label for="sex">성별</label>
    <div class="sex-group">
    <label for="female_">
        여성
        <input type="radio" id="female_" name="sex" value="여성">
    </label>
    <label for="male_">
        남성
        <input type="radio" id="male_" name="sex" value="남성">
    </label>
</div>

</div>
        <div class="form-group">
            <label for="phone">전화번호</label>
            <div class="phone-group">
                <select id="phone-prefix" name="phone-prefix" required>
                    <option value="010">010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="018">018</option>
                    <option value="019">019</option>
                </select>
                <p> - </p>
                <input type="tel" id="phone1" name="phone1" placeholder="번호 입력" required>
                <p> - </p>
                <input type="tel" id="phone2" name="phone2" placeholder="번호 입력" required>
            </div>
        </div>
    </div>
    <button class="submit-btn">회원가입</button>
</form>

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
function CheckId()		// ID를 입력받은 후에 팝업창을 띄워주면서 
{  										//   checkId.jsp (중복검사 수행)를 호출해 주는 자바스크립트 함수
	var id = newMem.id.value;		//  form의 이름이 newMem인 것에 주목할 것!

    if (id  == "")				//   11~16행:  ID를 입력없이 ID 중복체크 버튼을 클릭할 경우의 처리
    {
		alert("ID를 입력해 주세요!"); 
		newMem.id.focus(); 
		return; 
    }

	window.open("CheckId.jsp?id="+id,"win", "width=255, height=145, scrollbars=no, resizable=no");
}                                        // 용례)  =>  window.open("URL", "창이름", "창의 특성");

</script>
<script>
function CheckNickname() {  										
    var nickname = document.newMem.nickname.value; // form의 이름이 newMem인 것에 주목

    if (nickname === "") {
        alert("닉네임을 입력해 주세요!"); 
        document.newMem.nickname.focus(); 
        return; 
    }

    var encodedNickname = encodeURIComponent(nickname); // 한글을 URL 인코딩
    window.open("CheckNickname.jsp?nickname=" + encodedNickname, "win", "width=255, height=145, scrollbars=no, resizable=no");
}

</script>
</body>
</html>
