<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>관리자-상품 수정</title>
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
    width: 100vw;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 0;
    background-color: #FFF6ED;
    font-family: 'NanumSquareNeo', sans-serif;
}

#formWrapper {
    display: flex;
    flex-direction: column;
    align-items: center;
}

#h1Section {
    width: 100%;
    text-align: center;
    margin: 0;
    padding: 0;
	font-size: 25px;
	margin-bottom: 20px;
}

#h1Section h1 {
    color: #C31D3B;
	font-size: 25px;
}

#formSection {
    width: 1100px;
    margin: 0;
    padding: 0;
}

        h1 {
            color: #744731; /* 제목 색상 */
            text-align: center;
			font-size: 25px;
        }

        table {
            width: 1100px;
            color: #744731;
            font-size: 20px;
        }

        tr {
            text-align: center;
            border: none; /* 테두리 설정 */
            color: #744731;
            font-size: 25px;
        }

        td {
            text-align: center;
            border: 2px solid #744731;
			border-radius: 10px;
            width: 700px;
            height: 50px;
            color: #744731;
            font-size: 25px;
        }

        .tdInput {
            text-align: left;
            border: none; /* 테두리 설정 */
            width: 300px;
            height: 50px;
            color: #744731;
            font-size: 25px;
        }

        td img {
            max-width: 100%; /* 셀의 너비를 초과하지 않도록 설정 */
            height: auto; /* 비율 유지 */
        }

        input[type="text"], input[type="number"], textarea {
            width: 100%; 
            padding: 10px;
            margin: 5px 0;
            border: 2px solid #744731;
            border-radius: 10px;
            background-color: #FFF6ED; 
            font-family: 'NanumSquareNeo', sans-serif; 
            font-size: 20px;
        }
		

        .submit-button {
            width: 400px;
            height: 50px;
            background-color: #744731;
            color: #fff;
            border: none;
            border-radius: 10px;
            padding: 10px 20px;
            font-size: 27px;
            cursor: pointer;
            margin-top: 30px; /* 상단 여백 조정 */
            margin-bottom: 20px; /* 하단 여백 조정 */
            font-family: 'NanumSquareNeoBold', sans-serif; 
        }

        .submit-button:hover {
            background-color: #c31d3b; 
        }
		
		.submit-button-wrapper {
			display: flex;
			justify-content: center;
			gap: 20px;
			margin-top: 30px;
			margin-bottom: 20px;
		}
		
		textarea {
			width: 100%; 
			padding: 10px;
			margin: 5px 0;
			border: 2px solid #744731;
			border-radius: 10px;
			background-color: #FFF6ED;
			font-family: 'NanumSquareNeo', sans-serif;
			font-size: 17px;
			box-sizing: border-box;
			resize: vertical; /* 세로 크기 조정 가능 */
		}

    </style>
</head>

<body>
    <center>
        <h1>상품 삭제 확인</h1>

        <%
            request.setCharacterEncoding("euc-kr");

            String prdNoStr = request.getParameter("prdNo");
            if (prdNoStr == null || prdNoStr.trim().isEmpty()) {
                out.println("상품 번호가 잘못되었습니다.");
                return;
            }

            int prdNo = Integer.parseInt(prdNoStr); // 상품 번호 변환

            String DB_URL = "jdbc:mysql://localhost:3306/cake";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            String imagePath = "";
            String category = "";
            String productName = "";
            String productDescription = "";
            int productPrice = 0;

            try {
                Class.forName("org.gjt.mm.mysql.Driver");
                con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // 상품 정보 조회
                String jsql = "SELECT * FROM cake WHERE prdNo = ?";
                pstmt = con.prepareStatement(jsql);
                pstmt.setInt(1, prdNo);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String fileName = rs.getString("prdImage"); // 상품 이미지 파일명
                    imagePath = "images/" + fileName; // 이미지 경로
                    category = rs.getString("ctgType"); // 카테고리
                    productName = rs.getString("prdName"); // 상품명
                    productDescription = rs.getString("prdDetail"); // 상품 상세 설명
                    productPrice = rs.getInt("prdPrice"); // 상품 가격
                } else {
                    out.println("해당 상품을 찾을 수 없습니다.");
                    return;
                }

            } catch (Exception e) {
                out.println("에러: " + e);
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.println("DB 연결 종료 에러: " + e);
                }
            }
        %>

        <div id="formWrapper">
            <div id="h1Section"><h1>정말 삭제하시겠습니까?</h1></div>
            <div id="formSection">
                <form action="ProductDelete_Result.jsp" method="post">
                    <table>
                        <tr>
                            <td class="tdInput">상품번호</td>
                            <td><%= prdNo %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">상품사진</td>
                            <td><img src="<%= imagePath %>" alt="<%= productName %>" width="100" height="100"/></td>
                        </tr>
                        <tr>
                            <td class="tdInput">카테고리</td>
                            <td><%= category %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">상품명</td>
                            <td><%= productName %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">상품 상세 설명</td>
                            <td><%= productDescription %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">가격</td>
                            <td><%= productPrice %> 원</td>
                        </tr>
                    </table>
                    <input type="hidden" name="prdNo" value="<%= prdNo %>">
                    <div class="submit-button-wrapper">
                        <button type="submit" class="submit-button">삭제</button>
                        <input type="button" class="submit-button" value="취소" onclick="location.href='ProductList.jsp'">
                    </div>
                </form>
            </div>
        </div>
    </center>
</body>
</html>
