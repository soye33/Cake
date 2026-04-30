<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="euc-kr" />
    <title>관리자 - 배송관리</title>
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
            background-color: #FFF6ED;
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
            width:1300px;
            height: auto;
            border-collapse: collapse; /* 테이블 경계 합치기 */
            border-spacing: 0; /* 셀 간의 여백 없애기 */
			margin-bottom: 100px;
        }

        tr {
            text-align: center;
            border: solid 1px #744731; /* 테두리 설정 */
            color: #744731;
            font-size: 20px;
        }

        td {
    text-align: center;
    border: solid 1px #744731;
    height: 80px; /* 모든 셀의 높이를 80px로 통일 */
    color: #744731;
    font-size: 20px;
}


		.ordNo {width:700px;}
		.ordDate {width:600px;}
		.phone {width:200px;}
		.name {width:1600px;}
		.address {width:2000px;}
		.delivery {width:700px;}
			

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
			
			.product-img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    display: block;        /* 여백 제거 핵심 */
    margin: 0 auto;        /* 가운데 정렬 */
}

.img {
    text-align: center;
    vertical-align: middle;
    padding: 0;
    margin: 0;
}


    </style>
</head>
<body>
<div id="header">
    <a href="ManagerDelivery.jsp"><img src="images/logo_brown.png" alt="로고" /></a>
</div>

<div id="manager">
    <a href="ManagerDelivery.jsp"><b>관리자 페이지 - 배송관리</b></a><br>
    <p>주문 배송 상태를 관리할 수 있는 페이지입니다.</p>
    <p>관리자님. / <a href="Logout.jsp">로그아웃</a></p>
</div>

<div id="nav">
    <a href="ManagerMember.jsp"><button>회원관리</button></a>
    <a href="ManagerProduct.jsp"><button>상품관리</button></a>
    <a href="ManagerDelivery.jsp"><button style="background-color:#744731; color:#fff6ed;">배송관리</button></a>
	<a href="ManagerStats.jsp"><button>통계/후기</button></a>
</div>

<div id="content">
    <div class="content-1">
        <img src="images/manager_delivery_brown.png" />
        <b>상품목록</b>
    </div>

    <%
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cake", "multi", "abcd");

        String sql = "SELECT o.ordNo, o.ordSeq, o.ordDate, o.deliveryStatus, m.memPhone, c.prdName, c.prdImage, o.ordRcvaddress, m.memName, pd.prdDesign " +
             "FROM orderinfo o " +
             "JOIN member m ON o.memNickname = m.memNickname " +
             "JOIN cake c ON o.prdNo = c.prdNo " +
             "LEFT JOIN productdetail pd ON o.ordNo = pd.ordNo AND o.ordSeq = pd.ordSeq AND o.prdNo = pd.prdNo " +

             "ORDER BY o.ordDate DESC";



        pstmt = con.prepareStatement(sql);
        rs = pstmt.executeQuery();
%>

<table>
    <tr>
        <th>주문번호</th>
        <th>배송일</th>
        <th>전화번호</th>
        <th>상품사진</th>
        <th>상품명</th>
        <th>주소</th>
        <th>배송상태</th>
    </tr>
    <%
        while (rs.next()) {
            String ordNo = rs.getString("ordNo");
            String ordDate = rs.getString("ordDate");
            String phone = rs.getString("memPhone");
            String img = rs.getString("prdImage");
            String prdName = rs.getString("prdName");
            String status = rs.getString("deliveryStatus");
            String ordRcvaddress = rs.getString("ordRcvaddress");
    %>
    <tr>
        <td class="ordNo"><%= ordNo %></td>
        <td class="ordDate"><%= ordDate.substring(0, 10) %></td>

        <td class="phone"><%= phone %></td>
		<%
    String prdImage = rs.getString("prdImage");
    String prdDesign = rs.getString("prdDesign");
    String imageSrc = "images/" + prdImage;

    if ("도안 케이크".equals(prdName)) {
        if (prdDesign != null && !prdDesign.trim().isEmpty()) {
            imageSrc = "/onlycake/uploads/" + prdDesign;
        } else {
            imageSrc = "images/designCakeImage.jpg";
        }
    } else if ("디자인 케이크".equals(prdName)) {
        imageSrc = "images/designCakeImage.jpg";
    }
%>

        <td class="img"><img src="<%= imageSrc %>" class="product-img" /></td>

        <td class="name"><%= prdName %></td>
        <td class="address"><%= ordRcvaddress %></td>
        <td class="delivery">
    <div style="display: flex; flex-direction: column; align-items: center; line-height: 1.5;">
        <span style="color: #744731;"><%= status %></span>
        <a href="ManagerDelivery_Update.jsp?ordNo=<%= ordNo %>" style="color: blue; font-size: 16px;">수정</a>
    </div>
</td>


    </tr>
    <% } %>
</table>

<%
    } catch (Exception e) {
        out.println("<p style='color:red;'>에러: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>


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
