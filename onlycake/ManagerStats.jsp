<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.util.*, org.json.simple.JSONArray, org.json.simple.JSONObject" %>

<%
    // DB 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_USER = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    JSONArray salesData = new JSONArray();

    // 기본 연도 설정 (기본값: 2025)
    String selectedYear = request.getParameter("year");
    if (selectedYear == null || selectedYear.trim().isEmpty()) {
        selectedYear = "2025";
    }

    try {
        // 구형 드라이버 로드
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // DB 연결 확인
        System.out.println("[확인] DB 연결 성공 (" + selectedYear + "년)");

        // 월별 매출 데이터 가져오기
        String sql = "SELECT DATE_FORMAT(ordDate, '%m') AS month, SUM(ordPay) AS total_sales FROM orderinfo WHERE DATE_FORMAT(ordDate, '%Y') = ? GROUP BY month ORDER BY month";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, selectedYear);
        rs = pstmt.executeQuery();

        // 1월~12월 데이터를 0으로 초기화
        int[] monthlySales = new int[12];
        
        // 데이터 채우기
        while (rs.next()) {
            int monthIndex = Integer.parseInt(rs.getString("month")) - 1;
            monthlySales[monthIndex] = rs.getInt("total_sales");
            System.out.println("[확인] " + selectedYear + "년 " + (monthIndex + 1) + "월 매출: " + rs.getInt("total_sales"));
        }

        // JSON 형식으로 변환
        for (int i = 0; i < 12; i++) {
            JSONObject sales = new JSONObject();
            sales.put("month", (i + 1) + "월");
            sales.put("total_sales", monthlySales[i]);
            salesData.add(sales);
        }

        // 최종 JSON 데이터 로그
        System.out.println("[확인] 최종 매출 데이터 (" + selectedYear + "년): " + salesData.toJSONString());

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
%>



<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>관리자 페이지 - 매출</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
								
	.container {
        width: 80%;
        margin: 30px auto;
        background-color: #fff6ed;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
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
        padding: 10px 8px;
        text-align: center;
        border: 1px solid #D9BBA9;
        background-color: #ffffff;
    }

    th {
        background-color: #D9BBA9;
        color: #ffffff;
        border: 1px solid #D9BBA9;
    }
	
.content-1 {
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    margin-bottom: 20px;
}

.content-1 h1 {
    flex-grow: 1;
    text-align: center;
    margin: 0;
    color: #8C5C5C;
}
.year-select {
    position: absolute;
    right: 30px;
    margin: 0;
}

.year-select label {
    font-size: 18px;
    margin-right: 10px;
}

.year-select select {
    font-size: 18px;
    padding: 5px 15px;
    border-radius: 5px;
    border: 1px solid #D9BBA9;
    background-color: #ffffff;
}

	
.chart-container {
    width: 80%;
    margin: 40px auto;
    position: relative;
    background-color: #fff6ed;
    padding: 40px;
    border-radius: 15px;
	box-shadow: 0 4px 20px rgba(0,0,0,0.2);
}
		
		canvas {
			background-color: #fff6ed;
			padding: 20px;
			border-radius: 15px;
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
		<a href="ManagerStats.jsp"><button style="background-color:#744731; color:#fff6ed;">매출</button></a>
		<a href="ManagerCount.jsp"><button>판매량</button></a>
		<a href="ManagerReview.jsp"><button>후기</button></a>
	</div>


<%
            // 선택된 년도 표시
            if (selectedYear == null || selectedYear.isEmpty()) selectedYear = "2025";
%>
<div id="content">
    <div class="content-2">
        <div class="chart-container">
            <div class="content-1">
                <h1><%= selectedYear %>년 매출 통계</h1>

                <div class="year-select">
                    <form method="GET" action="ManagerStats.jsp">
                        <label for="year">조회할 연도:</label>
                        <select name="year" id="year" onchange="this.form.submit()">
                            <option value="2023" <%= selectedYear.equals("2023") ? "selected" : "" %>>2023</option>
                            <option value="2024" <%= selectedYear.equals("2024") ? "selected" : "" %>>2024</option>
                            <option value="2025" <%= selectedYear.equals("2025") ? "selected" : "" %>>2025</option>
                            <option value="2026" <%= selectedYear.equals("2026") ? "selected" : "" %>>2026</option>
                            <option value="2027" <%= selectedYear.equals("2027") ? "selected" : "" %>>2027</option>
                        </select>
                    </form>
                </div>
            </div>

            <!-- 데이터가 없는 경우 메시지 -->
            <div id="no-data-message" style="display: none; text-align: center; color: #8C5C5C; font-size: 20px; padding: 50px 0;">
                판매 실적이 없습니다.
            </div>

            <canvas id="monthlySalesChart"></canvas>
        </div>
    </div>  <!-- <div class="content-2"> 닫는 태그-->
</div>  <!-- <div id="content"> 닫는 태그-->

<script>
    // JSP에서 매출 데이터 받기
    const salesData = <%= salesData.toJSONString() %>;

    // 라벨과 데이터 분리
    const labels = [];
    const data = [];
    salesData.forEach(item => {
        labels.push(item.month);
        data.push(item.total_sales);
    });

    console.log("라벨:", labels);  // 디버깅용
    console.log("데이터:", data);   // 디버깅용

    // 데이터가 없는 경우 처리
    if (data.every(value => value === 0)) {
        document.getElementById("monthlySalesChart").style.display = "none";
        document.getElementById("no-data-message").style.display = "block";
    } else {
        // 차트 생성
        const ctx = document.getElementById("monthlySalesChart").getContext("2d");
        new Chart(ctx, {
            type: "bar",
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: "#744731",
                    borderColor: "#744731",
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false },
                    title: {
                        display: true,
                    },
                    tooltip: {
                        callbacks: {
                            label: function(tooltipItem) {
                                return tooltipItem.raw.toLocaleString() + " 원";
                            }
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 50000,
                            callback: function(value) {
                                return value.toLocaleString() + " 원";
                            }
                        }
                    }
                }
            }
        });
    }
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
