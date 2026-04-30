<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.text.NumberFormat, java.util.*" %>

<%
    request.setCharacterEncoding("EUC-KR");
    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 선택된 연도와 월 기본값 설정
    String selectedYear = request.getParameter("year");
    String selectedMonth = request.getParameter("month");
    if (selectedYear == null || selectedYear.isEmpty()) selectedYear = "2025";
    if (selectedMonth == null || selectedMonth.isEmpty()) selectedMonth = "5";

    List<Map<String, String>> salesData = new ArrayList<>();

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 판매량 높은 순으로 조회
        String sql = "SELECT c.prdName, c.prdImage, c.prdPrice, SUM(o.ordQty) AS total_sales " +
                     "FROM orderinfo o " +
                     "JOIN cake c ON o.prdNo = c.prdNo " +
                     "WHERE DATE_FORMAT(o.ordDate, '%Y') = ? AND DATE_FORMAT(o.ordDate, '%m') = ? " +
                     "GROUP BY c.prdName, c.prdImage, c.prdPrice " +
                     "ORDER BY total_sales DESC";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, selectedYear);
        pstmt.setString(2, String.format("%02d", Integer.parseInt(selectedMonth)));
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            item.put("prdName", rs.getString("prdName"));
            item.put("prdImage", rs.getString("prdImage"));
            item.put("prdPrice", NumberFormat.getInstance(Locale.KOREA).format(rs.getInt("prdPrice")));
            item.put("totalSales", NumberFormat.getInstance(Locale.KOREA).format(rs.getInt("total_sales")));
            salesData.add(item);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>관리자 페이지 - 판매량</title>

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

		body {
            display: flex;
            flex-direction: column; /* 주축은 수직 방향 */
            align-items: center; /* 주축이 수직 방향이므로, 교차축은 수평 방향. 수평 중앙 정렬 */
            margin: 0; /* 기본 margin 제거 */
            background-color: #f8f8f8;
			font-family: 'NanumSquareNeo', sans-serif;
        }	

			a {
				text-decoration: none; /* 밑줄 제거 */
			}

            #header {
                width: 1440px;
                height: 80px;
                background-color: #fff6ed;
                border-bottom: solid 2px #744731;
                display: flex;
                justify-content: center; /* 수직 중앙 정렬 */
                align-items: center; /* 수평 중앙 정렬 */
            }

            #header img {
                width: 100px;
                height: auto;
            }

            #manager {
                width: 1440px;
                height: auto; /* 높이를 자동으로 조정 */
                background-color: #fff6ed;
                display: flex;
                flex-direction: column; /* 수직 방향으로 정렬 */
                justify-content: center; /* 수직 중앙 정렬 */
                align-items: center; /* 수평 중앙 정렬 */
                text-align: center; /* 텍스트 중앙 정렬 */
                padding-top: 20px;
                padding-bottom: 20px;
            }

            #manager b {
                font-size: 28px;
                color: #744731;
				font-family: 'NanumSquareNeoHeavy', sans-serif;
            }

            #manager p {
                font-size: 18px;
                color: #744731;
				margin-top:10px;
				margin-bottom:10px;
            }

            #nav {
                width: 1440px;
                height: 60px;
                background-color: #fff6ed;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            #nav button {
                width: 250px;
                height: 40px;
                background-color: #fff6ed;
                border: solid 2px #744731;
                border-radius: 10px;
                margin: 0 20px; /* 좌우에 15px의 간격 추가 (각 버튼 사이에 총 40px) */
                color: #744731;
                font-size: 23px;
				font-family: 'NanumSquareNeoBold', sans-serif;
            }

            #nav button:hover {
                background-color: #744731;
                color: #fff6ed;
            }

            #content {
                width: 1440px;
                height: auto;
                background-color: #fff6ed;
                display: flex;
                flex-direction: column; /* 수직 방향으로 정렬 */
                justify-content: center;
                align-items: center;
                box-sizing: border-box;
            }
		
		.content-2 {
            width: 1440px;
            height: auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding-bottom: 100px;
            box-sizing: border-box;
        }

        
			

            #footer {
                width: 1440px;
                height: 250px;
                background-color: #744731;
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
                color: #C31D3B;
            }
		
		#nav2 {
				padding-top: 20px;
                width: 1440px;
                height: 120px;
                background-color: #fff6ed;
                display: flex;
                justify-content: center;
                align-items: center;
            }

        #nav2 button {
             width: 95px;
             height: 95px;
             background-color: #fff6ed;
             border: solid 2px #744731;
             border-radius: 50%;  /* 원 모양 버튼 만들기 */
             margin: 0 20px; /* 좌우에 15px의 간격 추가 (각 버튼 사이에 총 40px) */
             color: #744731;
             font-size: 23px;
			font-family: 'NanumSquareNeoBold', sans-serif;
        }

        #nav2 button:hover {
             background-color: #744731;
             color: #fff6ed;
        }
		
		
.container {
    width: 80%;
    margin: 30px auto;
    background-color: #fff6ed;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.2);
}

h1 {
    text-align: center;
    color: #8C5C5C;
    margin-bottom: 30px;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
    background-color: #fff6ed;
}

th, td {
    padding: 10px 8px; /* 상하 패딩 축소 */
    text-align: center;
    border: 1px solid #D9BBA9;
    background-color: #fff6ed;
}

th {
    background-color: #D9BBA9;
    color: #744731;
    border: 1px solid #D9BBA9;
}

td img {
    width: 70px; /* 이미지 크기 줄임 */
    height: 70px;
    border-radius: 5px;
    margin: 5px 0;
}

.year-select {
    text-align: right;
    margin-bottom: 20px;
}

.year-select label {
    font-size: 18px; /* 라벨 크기 증가 */
    margin-right: 10px;
}

.year-select select {
    font-size: 18px; /* 드롭다운 글자 크기 증가 */
    padding: 5px 15px;
    border-radius: 5px;
    margin-right: 10px;
    border: 1px solid #D9BBA9;
    background-color: #ffffff;
}
        </style>
    </head>
<body>
    <div id="header">
        <a href="ManagerMember.jsp"><img src="images/logo_brown.png" alt="로고" /></a>
    </div>

    <div id="manager">
        <a href="ManagerMember.jsp"><b>관리자 페이지 - 통계/후기</b></a><br>
        <p>통계/후기를 살펴보고 관리할 수 있는 페이지입니다.</p>
        <p>관리자님. / <a href="Logout.jsp">로그아웃</a></p>
    </div>

    <div id="nav">
        <a href="ManagerMember.jsp"><button>회원관리</button></a>
        <a href="ManagerProduct.jsp"><button>상품관리</button></a>
        <a href="ManagerDelivery.jsp"><button>배송관리</button></a>
		<a href="ManagerStats.jsp"><button style="background-color:#744731; color:#fff6ed;">통계/후기</button></a>
    </div>

	<div id="nav2">
		<a href="ManagerStats.jsp"><button>매출</button></a>
		<a href="ManagerCount.jsp"><button style="background-color:#744731; color:#fff6ed;">판매량</button></a>
		<a href="ManagerReview.jsp"><button>후기</button></a>
	</div>

    <div id="content">


    <div class="content-2">
        <div class="container">
            <%
                // 선택된 연도와 월을 숫자로 변환하여 한글로 표시
                String[] months = {"", "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"};
                String displayYear = selectedYear;
                String displayMonth = months[Integer.parseInt(selectedMonth)];
            %>

            <h1><%= displayYear %>년 <%= displayMonth %> 판매량 순</h1>

            <div class="year-select">
                <form method="GET" action="ManagerCount.jsp">
                    <label for="year">연도:</label>
                    <select name="year" id="year" onchange="this.form.submit()">
                        <% for (int y = 2023; y <= 2027; y++) { %>
                            <option value="<%= y %>" <%= y == Integer.parseInt(selectedYear) ? "selected" : "" %>><%= y %></option>
                        <% } %>
                    </select>
                    
                    <label for="month">월:</label>
                    <select name="month" id="month" onchange="this.form.submit()">
                        <% for (int m = 1; m <= 12; m++) { %>
                            <option value="<%= m %>" <%= m == Integer.parseInt(selectedMonth) ? "selected" : "" %>><%= m %></option>
                        <% } %>
                    </select>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>등수</th>
                        <th>상품명</th>
                        <th>상품사진</th>
                        <th>가격</th>
                        <th>판매수량</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int rank = 1;
                        boolean hasData = false;
                        
                        for (Map<String, String> item : salesData) {
                            String productName = item.get("prdName");
                            
                            // "도안 케이크" 또는 "디자인 케이크"는 제외
                            if ("도안 케이크".equals(productName) || "디자인 케이크".equals(productName)) {
                                continue;
                            }

                            hasData = true;
                            String fileName = item.get("prdImage");
                            String imagePath = "images/" + fileName;
                    %>
                        <tr>
                            <td><%= rank++ %></td>
                            <td><%= productName %></td>
                            <td><img src="<%= imagePath %>" alt="<%= productName %>" width="80" height="80"/></td>
                            <td><%= item.get("prdPrice") %> 원</td>
                            <td><%= item.get("totalSales") %> 개</td>
                        </tr>
                    <%
                        }

                        // 데이터가 없는 경우 메시지 출력
                        if (!hasData) {
                    %>
                        <tr>
                            <td colspan="5">판매된 상품이 없습니다.</td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div> <!-- <div class="content-2"> 닫는 태그-->
</div> <!-- <div id="content"> 닫는 태그-->



	
	
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
