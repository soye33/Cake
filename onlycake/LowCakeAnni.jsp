<%@ page contentType="text/html;charset=euc-kr" %> <%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!doctype html>
<html lang="ko">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>기념일 케이크 - 가격 낮은 순</title>
	
<%
     //   로그인 상태를 유지하기 위하여, sid에 저장되었던 접속한 ID값을 
     //   session 객체로부터 가져와서 변수 id에 저장시킴 (loginOK.jsp의 43행부분 확인요망!)
	String id = (String)session.getAttribute("sid");  
	// String id = session.getAttribute("sid").toString(); 와  동일함
    String memNickname = (String) session.getAttribute("memNickname");
                                           
%>
	
	
    <script type="text/javascript">
        function toggleWishlist(prdNo, imgElement) {
            // 현재 이미지가 heart.png인 경우
            if (imgElement.src.includes("heart.png")) {
                // 위시리스트에 추가 요청
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "AddWishlist.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        if (xhr.responseText.includes("위시리스트 추가 성공")) {
                            imgElement.src = "images/heart_red.png"; // 하트 이미지를 변경
                        } else {
                            alert("로그인 후 이용 가능한 기능입니다.");
                        }
                    }
                };
                xhr.send("prdNo=" + prdNo); // prdNo를 서버로 전송
            } 
            // 현재 이미지가 heart_red.png인 경우
            else if (imgElement.src.includes("heart_red.png")) {
                // 위시리스트에서 삭제 요청
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "RemoveWishlist.jsp", true);
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        if (xhr.responseText.includes("삭제 성공")) {
                            imgElement.src = "images/heart.png"; // 하트 이미지를 변경
                        } else {
                            alert("위시리스트 삭제 실패: " + xhr.responseText);
                        }
                    }
                };
                xhr.send("prdNo=" + prdNo); // prdNo를 서버로 전송
            }
        }
		


		function toggleSortMenu() {
            const sortMenu = document.getElementById('sortMenu');
            sortMenu.style.display = sortMenu.style.display === 'none' ? 'block' : 'none';
        }

		
		function sortItems(value) {
    console.log("선택된 정렬 기준:", value);
    if (value === "high") {
        window.location.href = "HighCakeAnni.jsp";
    } else if (value === "low") {
        // 여기에 가격 낮은 순으로 이동할 페이지를 추가
        window.location.href = "LowCakeAnni.jsp"; 
    }
	else if (value === "normal") {
        window.location.href = "CakeAnni.jsp"; 
    }
	
}

    </script>
        <style>
            @font-face {
                font-family: "NanumSquareNeoLight";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-aLt.ttf)
                        format("truetype");
            }

            @font-face {
                font-family: "NanumSquareNeo";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-bRg.ttf)
                        format("truetype");
            }

            @font-face {
                font-family: "NanumSquareNeoBold";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-cBd.ttf)
                        format("truetype");
            }

            @font-face {
                font-family: "NanumSquareNeoExtraBold";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-dEb.ttf)
                        format("truetype");
            }

            @font-face {
                font-family: "NanumSquareNeoHeavy";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeoTTF-eHv.ttf)
                        format("truetype");
            }

            @font-face {
                font-family: "NanumSquareNeoVariable";
                src: url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.eot);
                src:
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.eot?#iefix)
                        format("embedded-opentype"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.woff)
                        format("woff"),
                    url(https://hangeul.pstatic.net/hangeul_static/webfont/NanumSquareNeo/NanumSquareNeo-Variable.ttf)
                        format("truetype");
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
			
            
            #content_1 {
                width: 1440px;
                height: auto; 
                background-color: #fff6ed;
                display: flex;
                flex-direction: column; 
                justify-content: center; 
                align-items: center;
                text-align: center;
            }
			
			#content_1 img{
				width:1440px;
				height:auto;
				justify-content: center; 
                align-items: center;
			}

            #content_1 b {
                font-size: 30px;
                color: #C31D3B;
				font-family: 'NanumSquareNeoExtraBold', sans-serif;
            }

            #content_1 p {
                font-size: 16px;
                color: #C31D3B;
				margin-top:15px;
            }
			
			#history_container{
				width: 1440px;
				height: 35px;
				display: flex;
				justify-content: center; 
				text-align: center; 
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			.history {
				width: 920px;
				height: 35px; 
				display: flex;
				justify-content: center; 
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			.history p {
				font-size: 15px;
				color: #C31D3B;
				font-family: 'NanumSquareNeoExtraBold', sans-serif;
				position: absolute; 
				bottom: 0; /* 아래에서 위치 설정 */
				right: 0; /* 오른쪽에서 위치 설정 */
				margin: 0; /* 기본 마진 제거 */
				margin-bottom:5px;
			}
		

            
             #content_3 {
				background-image:url('images/anniversaryBackground.png');
				background-repeat: repeat-y;       
				background-size: 1500px auto;
				
				width: 1440px;
				height: auto;
				display: flex;
				flex-wrap: wrap; /* 여러 줄로 배치 */
				justify-content: center; 
				align-items: flex-start; /* 시작점에서 정렬 */
				text-align: center; 
				padding-bottom: 200px;
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			#button_container {
				width: 60px; 
				height: 60px;
				background-color: #C31D3B; 
				display: flex; 
				justify-content: center; 
				align-items: center; 
				position: absolute; 
				right: 180px; 
				top: 10px; 
			}
        
			#button_container img {
				width: 40px;
				height: 40px;
			}

			#sortMenu {
				display: none;
				position: absolute; 
				right: 70px; 
				top: 80px; 
			}
		
			#sortMenu select{
				width: 170px;
				height:40px;
				font-size: 18px;
				color: #C31D3B;
				border: 1px solid #C31D3B;
				font-family: 'NanumSquareNeo', sans-serif;
			}

			.heart-icon {
				position: absolute; 
				top: -3px; 
				right: 15px; 
				width: 45px; 
				height: auto; 
			}
            
            .cake_image img{
                width: 190px;
                height: 190px;
                max-width: 190px;
                max-height: 190px;
                border: none;
            }
			
			
			#cake_container {
				width: 1100px; 
				display: flex; 
				flex-wrap: wrap; /* 여러 줄로 배치 */
				justify-content: center; 
			}

			#cake_info {
				width: calc(25% - 50px); /* 4개를 한 줄에 배치하고 여백을 고려 */
				margin: 10px; 
				box-sizing: border-box; 
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}


			.cake_name_container{
				width: 225px; 
				display: flex; 
				align-items: center; 
				justify-content: center; 
				height: 40px;
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			.cake_name {
				font-size: 18px;
				color: #744731;
				text-align: center;
				margin-top: 10px;
				margin-bottom: 10px;
				white-space: nowrap; /* 한 줄로 표시 */
				overflow: hidden; /* 넘치는 내용 숨기기 */
				text-overflow: ellipsis; /* 생략(...) 표시 */
				width: 190px; /* 부모 요소에 맞게 너비 설정 */
				font-family: 'NanumSquareNeoBold', sans-serif;
				
			}
			
			.cake_price{
				font-size: 17px;
				color: #744731;
				text-align: center;
				margin-bottom:10px;
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


	

    <div id="content_1">
		<img src="images/titlebar_happy.jpg">
        <!--<a href="LoginOK.jsp"><b>기념일 케이크</b></a>
        <p>행복한 순간을 위한 달콤한 선택</p>-->
    </div>
	
	<div id="history_container">
		<div class="history">
			<p>행복한 케이크 > 기념일 케이크</p>
		</div>
	</div>
	

    <div id="content_3"> 
		<div id="button_container" onclick="toggleSortMenu()">
			<img src="images/array_white.png" alt="정렬 기능 버튼">
		</div>

		<div id="sortMenu" style="display: none;">
			<select onchange="sortItems(this.value)">
				<option value="normal">기본 정렬</option>
				<option value="high">가격 높은 순</option>
				<option value="low" selected>가격 낮은 순</option>
			</select>
		</div>
		
			<div id="cake_container">
		
	
         <%
            int count = 0; // count 변수를 초기화
			NumberFormat formatter = NumberFormat.getInstance(Locale.KOREA); // 한국 형식으로 포맷터 생성
			
            try {
                String DB_URL = "jdbc:mysql://localhost:3306/cake"; 
                String DB_ID = "multi"; 
                String DB_PASSWORD = "abcd"; 

                Class.forName("org.gjt.mm.mysql.Driver"); 
                Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
                String jsql = "SELECT * FROM cake WHERE ctgType = '기념일케이크' ORDER BY prdPrice ASC;"; 
                PreparedStatement pstmt = con.prepareStatement(jsql);
                ResultSet rs = pstmt.executeQuery();

                String memId = (String) session.getAttribute("memId"); // 세션에서 memId 가져오기

                while (rs.next() && count < 20) { 
                    int prdNo = rs.getInt("prdNo");
                    String prdName = rs.getString("prdName");
                    String prdImage = rs.getString("prdImage");
                    int prdPrice = rs.getInt("prdPrice");
					// 가격을 포맷팅
					String formattedPrice = formatter.format(prdPrice);

                    // 현재 제품의 위시리스트 상태 조회
                    boolean isInWishlist = false;
                    if (memId != null) {
                        String wishlistSQL = "SELECT * FROM wish WHERE prdNo = ? AND memId = ?";
                        PreparedStatement wishlistPstmt = con.prepareStatement(wishlistSQL);
                        wishlistPstmt.setInt(1, prdNo);
                        wishlistPstmt.setString(2, memId);
                        ResultSet wishlistRs = wishlistPstmt.executeQuery();
                        isInWishlist = wishlistRs.next(); // 결과가 있는지 확인
                        wishlistRs.close();
                        wishlistPstmt.close();
                    }
        %>
                     
                        <div id="cake_info">
						<a href="detail.jsp?prdNo=<%= prdNo %>">
                            <div class="cake_image">
                                <img src="images/<%=prdImage%>" alt="기념일 케이크<%= count + 1 %>">
                            </div>
						<div class="cake_name_container">
                            <div class="cake_name">
                                <%=prdName%>
                            </div>
						</div>	
                            <div class="cake_price">
                                <%=formattedPrice%>원
                            </div>
						</a>
							<img src="images/<%= isInWishlist ? "heart_red.png" : "heart.png" %>" class="heart-icon" alt="하트 아이콘" 
                             onclick="toggleWishlist(<%=prdNo%>, this)"> <!-- 클릭 시 함수 호출 -->
                        </div>
                    

        <%
                    count++; 
                }

                rs.close();
                pstmt.close();
                con.close();
            } catch (SQLException e) {
                out.println("SQL 오류: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("드라이버 클래스 오류: " + e.getMessage());
            } catch (Exception e) {
                out.println("오류: " + e.getMessage()); 
            }
        %>        
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

