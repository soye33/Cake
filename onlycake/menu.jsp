<%@ page contentType="text/html;charset=euc-kr" %> <%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!doctype html>
<html lang="ko">
    <head>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>기념일 케이크</title>
	
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
                            alert("위시리스트 추가 실패: " + xhr.responseText);
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
		text-decoration:none;
	}
	/* 헤더 스타일 */
/* 헤더 & 네비게이션 컨테이너 */
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
}

header img {
    width: 120px;
    height: 120px;
}

/* 로그인, 마이페이지, 장바구니 */
#header2 {
    position: absolute;
    top: 80px; /* 로고 아래에 위치 */
    right: 20px; /* 오른쪽 끝으로 배치 */
    display: flex;
    align-items: center;
    justify-content: center;
	margin-bottom: 100px;
}

#header2 p a {
    text-decoration: none;
    color: #744731;
    margin-right: 10px;
	font-size:20px;
}

#header2 img {
    width: 50px;
    height: 50px;
    margin-left: 10px;
}

/* 네비게이션 */
nav {
    display: flex;
    justify-content: center; /* 메뉴 왼쪽으로 정렬 */
    align-items: center;
    margin-top: 30px;
    margin-left: -80px; /* 메뉴를 왼쪽으로 조금 이동 */
    margin-bottom: 100px;
    width: 100%; /* 메뉴가 전체 너비를 차지하도록 설정 */
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
    font-size: 25px;
    font-weight: bold;
    padding: 10px 15px; /* 패딩 추가 */
}

nav ul li a:hover {
    color: #744731; /* hover 시 텍스트 색상 변경 */
    line-height: 40px; /* 텍스트 수직 중앙 정렬 */
}

/* 서브메뉴 스타일 */
/* 서브메뉴 기본적으로 숨김 */
.sub {
     display: none;
     position: absolute;
     top: 200px;
     left: 50%;
     transform: translateX(-50%);
     background-color: #C31D3B;
     z-index: 1000;
     padding: 10px;
     width: 1440px;
     height: 200px;
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
}

.sub ul li {
    margin: 5px 0;
}

.sub1 {
    margin-left: 85px;
}
.sub1 li:last-child {
	margin-left:-15px;
}

.sub2 {
    margin-left: 365px; 
	margin-top: -110px; 
}

.sub3 {
    margin-left: 645px; 
	margin-top: -55px; 
}

.sub3 li:nth-child(2), .sub3 li:last-child {
    margin-left: -15px; 
}

.sub4 {
    margin-left: 860px; 
	margin-top: -160px; 
}

.sub4 li:nth-child(2){
    margin-left: 75px; 
}

.sub4 li:last-child{
    margin-left: 20px; 
}

.sub5 {
    margin-left: 1110px; 
	margin-top: -160px;

}
.sub ul li a {
    display: block;
    text-decoration: none;
    color: #FFF6ED;
    font-size: 25px;
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
hr {
    border: none;
    border-top: 2px solid #C31D3B; /* 색상 변경 및 두께 설정 */
    margin-top: -80px; /* 위치 위로 조정 */
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
                font-size: 50px;
                color: #C31D3B;
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
            
             #content_3 {
				width: 1440px;
				height: auto;
				display: flex;
				flex-wrap: wrap; /* 여러 줄로 배치 */
				justify-content: center; 
				align-items: flex-start; /* 시작점에서 정렬 */
				text-align: center; 
				margin-bottom: 200px;
				position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
			}
			
			#button_container {
				width: 80px; 
				height: 80px;
				background-color: #C31D3B; 
				display: flex; 
				justify-content: center; 
				align-items: center; 
				position: absolute; 
				right: 100px; 
				top: 10px; 
			}
        
			#button_container img {
				width: 60px;
				height: 60px;
			}

			#sortMenu {
				display: none;
				position: absolute; 
				right: 0px; 
				top: 110px; 
			}
		
			#sortMenu select{
				width: 180px;
				height:50px;
				font-size: 20px;
				color: #C31D3B;
				border: 1px solid #C31D3B;
			}

			.heart-icon {
				position: absolute; /* 절대 위치 설정 */
				top: 0px; /* 위쪽 여백 조정 */
				right: 30px; /* 오른쪽 여백 조정 */
				width: 55px; /* 필요에 따라 크기 조정 */
				height: auto; 
			}
            
            .cake_image img{
                width: 200px;
                height: 200px;
                max-width: 200px;
                max-height: 200px;
                border: none;
            }
			
			
			#cake_container {
    width: 1100px; 
    display: flex; 
    flex-wrap: wrap; /* 여러 줄로 배치 */
    justify-content: center; 
}

#cake_info {
    width: calc(25% - 20px); /* 4개를 한 줄에 배치하고 여백을 고려 */
    margin: 10px; 
    box-sizing: border-box; 
    position: relative; /* 자식 요소의 절대 위치를 위해 설정 */
}


			.cake_name {
				font-size: 25px;
				color: #744731;
				text-align: center;
				margin-top: 15px;
				margin-bottom: 15px;
				white-space: nowrap; /* 한 줄로 표시 */
				overflow: hidden; /* 넘치는 내용 숨기기 */
				text-overflow: ellipsis; /* 생략(...) 표시 */
				width: 100%; /* 부모 요소에 맞게 너비 설정 */
				
			}
			
			.cake_price{
				font-size: 20px;
				color: #744731;
				text-align: center;
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
                width: 130px;
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
        </style>
    </head>
    <body>	
	<meta charset="EUC-KR">
    <div class="header-nav-container">
    <header>
        <a href="Index.jsp"><img src="images/logo.png" /></a>
        <div id="header2">
    <% if (id != null) { %>
        <p><a href="Mypage.jsp"><%= memNickname %>님</a></p>
        <p><a href="Logout.jsp" class="logout-link">로그아웃</a></p>
        <a href="Mypage.jsp"><img src="images/mypage_red.png" alt="mypage"></a>
        <a href="Cart.jsp"><img src="images/cart.png" alt="cart"></a>
    <% } else { %>
        <p><a href="Login.jsp">로그인 / 회원가입</a></p>
		<a href="Mypage.jsp"><img src="images/mypage_red.png" alt="mypage"></a>
        <a href="Cart.jsp"><img src="images/cart.png" alt="cart"></a>
    <% } %>
</div>
        </div>
    </header>
    <nav class="menu_area">
    <ul class="menu">
        <li><a href="CakeDrawing.jsp">커스텀 케이크</a></li>
        <li><a href="CakeBest.jsp">인기 케이크</a></li>
        <li><a href="CakeBirth.jsp">행복한 케이크</a></li>
        <li><a href="CustomerService_Inquiry.jsp">고객센터</a></li>
        <li><a href="Review.jsp">후기</a></li>
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
            <li><a href="CustomerService_Refund.jsp">환불 및 교환 정책</a></li>
            <li><a href="CustomerService_Inquiry.jsp">문의</a></li>
            <li><a href="CustomerService_FAQ.jsp">자주 묻는 질문</a></li>
		</div>
		<div class="sub5">
            <li><a href="Review.jsp">고객 후기</a></li>
		</div>
        </ul>
    </div>
</nav>
</div>
<hr> 

	

    <div id="content_1">
        <a href="LoginOK.jsp"><b>행복한 케이크</b></a><br>
        <p>행복한 순간을 위한 달콤한 선택</p>
    </div>

    <div id="sub_nav">
        <a href="CakeBirth.jsp"><button>생일케이크</button></a>
        <a href="CakeWedding.jsp"><button>결혼식케이크</button></a>
        <a href="CakeAnni.jsp"><button style="background-color: #C31D3B; color: #fff;">기념일케이크</button></a>
    </div>

    <div id="content_2">
        <img src="images/theme_anni_red.png"/>
    </div>
	

    <div id="content_3"> 
		<div id="button_container" onclick="toggleSortMenu()">
			<img src="images/array_white.png" alt="정렬 기능 버튼">
		</div>

		<div id="sortMenu" style="display: none;">
			<select onchange="sortItems(this.value)">
				<option value="normal" selected>기본 정렬</option>
				<option value="high">가격 높은 순</option>
				<option value="low">가격 낮은 순</option>
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
                String jsql = "SELECT * FROM cake WHERE ctgType = '기념일케이크'"; 
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
						<a href="상세페이지">
                            <div class="cake_image">
                                <img src="images/<%=prdImage%>" alt="기념일 케이크<%= count + 1 %>">
                            </div>
						 
                            <div class="cake_name">
                                <%=prdName%>
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
            <img src="images/logo_letter_white.png" />
            <p>고객센터</p>
            <b>02-339-9947</b>
            <p>평일 AM 10:00 ~ PM 20:00 주말, 공휴일 휴무</p>
        </div>
        <div class="footer-2">
            <p><a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">이메일무단수집거부</a></p>
            <p>
                오롯이 케이크 / 레터링 CAKE | 통신판매업신고번호 : 2025-서울마포-0061 | 사업자등록번호 : 120 - 99 -
                48278 주식회사 오롯이케이크
            </p>
            <p>주소 : 서울시 마포구 연남동 334-25번지 2층 | 대표자: 이장 | 전화번호 : 02 -339 - 9947</p>
            <p>Copyright onlycake.All Rights Reserved.</p>
        </div>
    </div>
</body>
</html>

