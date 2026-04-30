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

    List<Map<String, String>> reviewList = new ArrayList<>();
    String sort = request.getParameter("sort");
    if (sort == null) sort = "latest";

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String orderBy = "r.reviewAt DESC";
        if ("oldest".equals(sort)) orderBy = "r.reviewAt ASC";
        else if ("rating_high".equals(sort)) orderBy = "r.rating DESC";
        else if ("rating_low".equals(sort)) orderBy = "r.rating ASC";

        String sql = "SELECT r.reviewIdx, r.rating, r.reviewText, r.photoPath, r.reviewAt, r.memNickname, " +
                     "c.prdName, c.prdImage " +
                     "FROM review r JOIN cake c ON r.prdNo = c.prdNo " +
                     "ORDER BY " + orderBy;

        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> review = new HashMap<>();
            review.put("reviewIdx", rs.getString("reviewIdx"));
            review.put("rating", rs.getString("rating"));
            review.put("reviewText", rs.getString("reviewText"));
            review.put("photoPath", rs.getString("photoPath"));
            review.put("reviewAt", rs.getString("reviewAt"));
            review.put("memNickname", rs.getString("memNickname"));
            review.put("prdName", rs.getString("prdName"));
            review.put("prdImage", rs.getString("prdImage")); // 이미지 경로
            reviewList.add(review);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="EUC-KR">
    <title>관리자 페이지 - 후기</title>

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
    flex-direction: column;
    align-items: center;
    margin: 0;
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

        /* 가운데 정렬용 추가 */
#content, .container {
    margin: 0 auto;
}

/* 테이블 컨테이너 더 넓은 여백으로 */
.container {
    width: 80%;
    max-width: 1200px;
    margin: 30px auto;  /* auto 중앙정렬 */
    background-color: #fff6ed;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.2);
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

}

.rating-stars {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 4px; /* 별점 이미지 간격 */
}

.rating-stars img {
    width: 25px;
    height: 25px;
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

.review-text {
            text-align: left;
            padding: 10px;
            word-break: break-all;
        }
        .review-photo {
            max-width: 100px;
            max-height: 100px;
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
		<a href="ManagerCount.jsp"><button >판매량</button></a>
		<a href="ManagerReview.jsp"><button style="background-color:#744731; color:#fff6ed;">후기</button></a>
	</div>

    <div id="content">
        <div class="content-2">
            <div class="container">
                <h1>전체 후기 목록</h1>
<div class="year-select" style="text-align: right; margin-bottom: 20px;">
    <form method="get" action="ManagerReview.jsp">
        <label for="sort">정렬 기준:</label>
        <select name="sort" id="sort" onchange="this.form.submit()">
            <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>최신 순</option>
            <option value="oldest" <%= "oldest".equals(sort) ? "selected" : "" %>>오래된 순</option>
            <option value="rating_high" <%= "rating_high".equals(sort) ? "selected" : "" %>>별점 높은 순</option>
            <option value="rating_low" <%= "rating_low".equals(sort) ? "selected" : "" %>>별점 낮은 순</option>
        </select>
    </form>
</div>


                <table>
    <thead>
        <tr>
            <th>번호</th>
            <th>상품명</th>
            <th>상품사진</th>
            <th>작성자</th>
            <th>별점</th>
            <th>후기내용</th>
            <th>후기사진</th>
            <th>작성일</th>
			<th>삭제</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (reviewList.isEmpty()) {
        %>
            <tr>
                <td colspan="8">등록된 후기가 없습니다.</td>
            </tr>
        <% } else {
    for (Map<String, String> r : reviewList) {
        String productName = r.get("prdName");
        String prdDesign = r.get("photoPath");
        String imageSrc = "images/" + r.get("prdImage");

        if ("도안 케이크".equals(productName)) {
            if (prdDesign != null && !prdDesign.trim().isEmpty()) {
                imageSrc = "uploads/" + prdDesign;
            } else {
                imageSrc = "images/designCakeImage.jpg";
            }
        } else if ("디자인 케이크".equals(productName)) {
            imageSrc = "images/designCakeImage.jpg";
        }
%>
            <tr>
                <td style="width:50px;"><%= r.get("reviewIdx") %></td>
                <td style="width:50px;"><%= productName %></td>
                <td><img src="<%= imageSrc %>" width="70" height="70" alt="상품이미지" /></td>
                <td style="width:50px;"><%= r.get("memNickname") %></td>
                <td >
				<div class="rating-stars">
                    <% int rating = Integer.parseInt(r.get("rating")); %>
                    <% for (int i = 0; i < 5; i++) { %>
                        <img src="images/<%= (i < rating) ? "star_yellow.png" : "star_brown.png" %>" style="width:20px; height:20px;" alt="별점" />


                    <% } %>
						</div>
                </td>
                <td class="review-text"><%= r.get("reviewText") %></td>
                <td>
                    <% if (r.get("photoPath") != null && !r.get("photoPath").isEmpty()) { %>
                        <img src="uploads/<%= r.get("photoPath") %>" class="review-photo" alt="후기 이미지" />
                    <% } else { %>
                        없음
                    <% } %>
                </td>
                <td><%= r.get("reviewAt") %></td>
				<!-- ManagerReview.jsp - 테이블 내 삭제 버튼 추가 -->
<td style="width:50px;">
    <form method="post" action="ManagerDeleteReview.jsp" onsubmit="return confirm('해당 후기를 삭제하시겠습니까?');">
        <input type="hidden" name="reviewIdx" value="<%= r.get("reviewIdx") %>" />
        <button type="submit" style="background-color:#C31D3B; color:white; border:none; padding:4px 10px; border-radius:5px;">삭제</button>
    </form>
</td>

            </tr>
        <%
                }
            }
        %>
    </tbody>
</table>
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
</body>
</html>
