<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<!doctype html>
<html lang="ko">
<head>
    <meta charset="euc-kr" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>관리자-상품 추가</title>
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

.content-1 {
    width: 1440px;
    height: 100px;
    display: flex;
    flex-direction: column; /* 수직 방향으로 정렬 */
    justify-content: center;
    align-items: center;
	padding-bottom: 30px;
	padding-top: 10px;
}

.content-1 img {
    width: 70px;
    height: 70px;
}

.content-1 b {
    margin-top: 10px; /* 이미지와 텍스트 사이의 간격 조절 */
    text-align: center; /* 텍스트 중앙 정렬 */
	color: #744731;
    font-size: 28px;
	font-family: 'NanumSquareNeoExtraBold', sans-serif;		
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

        table {
            width: 1100px;
            height: auto;
            border-collapse: collapse; /* 테이블 경계 합치기 */
            border-spacing: 0; /* 셀 간의 여백 없애기 */
        }

        tr {
            text-align: center;
            border: solid 1px #744731; /* 테두리 설정 */
            color: #744731;
            font-size: 20px;
        }

        td {
            text-align: center;
            border: solid 1px #744731; /* 테두리 설정 */
            width: 750px;
            height: 50px;
            color: #744731;
            font-size: 20px;
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


        .table-td {
            width: 300px;
            height: 50px;
        }

        .input {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: transparent;
            font-size: 17px;
            color: #744731;
            height: 50px;
        }

        #category {
            width: 500px;
            height: 50px;
            border: solid 1px #744731;
            background-color: transparent;
            font-size: 20px;
            color: #744731;
        }

        .btn-container {
            display: flex; 
            justify-content: space-between; /* 버튼 사이의 간격을 균등하게 배치 */
            width: 100%; 
            max-width: 800px; 
            margin-top: 70px; 
            margin-bottom: 50px; 
        }

        .btn-container button {
            flex: 1; /* 버튼이 균등하게 공간을 차지하도록 설정 */
            height: 60px;
            background-color: #744731;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 25px;
            margin: 0 30px; /* 좌우 간격 추가 */
            cursor: pointer; 
			font-family: 'NanumSquareNeoBold', sans-serif;
        }

        .btn-container button a {
            color: white; 
            text-decoration: none; 
            display: flex; /* Flexbox 사용 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
            height: 100%; /* 버튼의 전체 높이를 차지하도록 설정 */
			font-family: 'NanumSquareNeoBold', sans-serif;
        }

        .btn-container button:hover {
            background-color: #c31d3b;
        }
    </style>
</head>
<body>
    <div id="header">
        <a href="ManagerProduct.jsp"><img src="images/logo_brown.png" alt="로고" /></a>
    </div>

    <div id="manager">
        <a href="ManagerProduct.jsp"><b>관리자 페이지 - 상품관리</b></a><br />
        <p>상품을 추가, 수정, 삭제할 수 있는 페이지입니다.</p>
        <br />
        <p>관리자님. / <a href="Logout.jsp">로그아웃</a></p>
    </div>

    <div id="nav">
        <a href="ManagerMember.jsp"><button>회원관리</button></a>
        <a href="ManagerProduct.jsp"><button style="background-color:#744731; color:#fff6ed;">상품관리</button></a>
        <a href="ManagerDelivery.jsp"><button>배송관리</button></a>
		<a href="ManagerStats.jsp"><button>통계/후기</button></a>
    </div>

    <div id="content">
        <div class="content-1"><b>상품목록</b></div>
        <div class="content-2">
            <%
                request.setCharacterEncoding("euc-kr");

                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    String DB_URL = "jdbc:mysql://localhost:3306/cake";  
                    String DB_ID = "multi";  
                    String DB_PASSWORD = "abcd"; 

                    Class.forName("org.gjt.mm.mysql.Driver"); 
                    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

                    String jsql = "SELECT * FROM cake";   
                    pstmt = con.prepareStatement(jsql);
                    rs = pstmt.executeQuery();
            %>
            <table>
                <tr>
					<th>상품번호</th>
                    <th>상품사진</th>
                    <th>카테고리</th>
                    <th>상품명</th>
                    <th>상품 상세 설명</th>
                    <th>가격</th>
                    <th>수정</th>
                    <th>삭제</th>
                </tr>
                <%
    while(rs.next()) {
        int prdNo = rs.getInt("prdNo"); // 상품 번호
        String fileName = rs.getString("prdImage"); // 이미지 파일 이름
        String category = rs.getString("ctgType"); // 카테고리
        String productName = rs.getString("prdName"); // 상품명
        String productDescription = rs.getString("prdDetail"); // 상품 상세 설명
        int productPrice = rs.getInt("prdPrice"); // 상품 가격

        String imagePath = "images/" + fileName;

        // 천 단위 콤마 넣기
        NumberFormat nf = NumberFormat.getInstance(Locale.KOREA);
        String formattedPrice = nf.format(productPrice);
%>
                <tr>
					<td><%= prdNo %></td>
					<td><img src="<%= imagePath %>" alt="<%= productName %>" width="100" height="100"/></td>
					<td><%= category %></td>
					<td><%= productName %></td>
					<td><%= productDescription %></td>
					<td><%= formattedPrice %> 원</td>
					<td><a href="ProductUpdate.jsp?prdNo=<%= prdNo %>">수정</a></td>
					<td><a href="ProductDelete.jsp?prdNo=<%= prdNo %>" style="color: red;">삭제</a></td>
				</tr>

                <%
                    } 
                %>
            </table>
            <div class="btn-container">
                <button><a href="ProductInsert.jsp">신규 상품 추가 등록</a></button>
                <button><a href="ManagerLoginOK.jsp">관리자모드 메인페이지</a></button>
            </div>
            <%
                } catch (Exception e) {
                    out.println(e);
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        out.println(e);
                    }
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