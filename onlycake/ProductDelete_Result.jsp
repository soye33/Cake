<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 수정 결과</title>
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
    height: 100vh;
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
	border-top: solid 2px #744731;
	margin-top: 40px;
}

#h1Section p {
    width: 100%;
    text-align: center;
    margin: 0;
    padding: 0;
	font-size: 45px;
	margin-bottom: 50px;
	margin-top: 50px;
	color: #744731;
	font-family: 'NanumSquareNeoBold', sans-serif;
}

#formSection {
    width: 1100px;
    margin: 0;
    padding: 0;
}

        h1 {
            color: #C31D3B; /* 제목 색상 */
            text-align: center;
			font-size: 35px;
        }

        table {
            width: 1100px;
            color: #744731;
            font-size: 20px;
        }

        tr {
            text-align: center;
            border: solid 2px #744731; /* 테두리 설정 */
            color: #744731;
            font-size: 25px;
        }

        td {
            text-align: center;
            border: solid 2px #744731; /* 테두리 설정 */
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
			padding: 20px;
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
		
		textarea {
			width: 100%; 
			padding: 10px;
			margin: 5px 0;
			border: 2px solid #744731;
			border-radius: 10px;
			background-color: #FFF6ED;
			font-family: 'NanumSquareNeo', sans-serif;
			font-size: 20px;
			box-sizing: border-box;
			resize: vertical; /* 세로 크기 조정 가능 */
		}
		
        .btn-container button {
			margin-top: 100px;
			width: 600px;
            height: 70px;
            background-color: #744731;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 25px;
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
		
		p{
			font-family: 'NanumSquareNeo', sans-serif;
			font-size:20px;
		}

    </style>
</head>
<body>
    <center>
        <h1>상품 삭제 결과</h1>

        <%
            request.setCharacterEncoding("euc-kr");

            String prdNoStr = request.getParameter("prdNo");
            if (prdNoStr == null || prdNoStr.trim().isEmpty()) {
                out.println("<p>상품 번호가 잘못되었습니다.</p>");
                return;
            }

            int prdNo = Integer.parseInt(prdNoStr); // 상품 번호 변환

            String DB_URL = "jdbc:mysql://localhost:3306/cake";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";
            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.gjt.mm.mysql.Driver");
                con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                // 1. orderinfo에서 해당 상품의 주문 내역 삭제
                String deleteOrderinfoSql = "DELETE FROM orderinfo WHERE prdNo = ?";
                pstmt = con.prepareStatement(deleteOrderinfoSql);
                pstmt.setInt(1, prdNo);
                pstmt.executeUpdate();
                pstmt.close();

                // 2. productdetail에서 해당 상품의 상세 정보 삭제 (필요한 경우)
                String deleteProductDetailSql = "DELETE FROM productdetail WHERE prdNo = ?";
                pstmt = con.prepareStatement(deleteProductDetailSql);
                pstmt.setInt(1, prdNo);
                pstmt.executeUpdate();
                pstmt.close();

                // 3. 최종적으로 cake 테이블에서 상품 삭제
                String deleteCakeSql = "DELETE FROM cake WHERE prdNo = ?";
                pstmt = con.prepareStatement(deleteCakeSql);
                pstmt.setInt(1, prdNo);
                int result = pstmt.executeUpdate(); // DELETE 쿼리 실행

                if (result > 0) {
                    out.println("<p>상품이 성공적으로 삭제되었습니다.</p>");
                } else {
                    out.println("<p>상품 삭제에 실패했습니다. 다시 시도해 주세요.</p>");
                }

            } catch (Exception e) {
                out.println("<p>에러: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    out.println("<p>DB 연결 종료 에러: " + e.getMessage() + "</p>");
                }
            }
        %>

        <div class="btn-container">
            <a href="ProductList.jsp"><button>전체 상품 목록으로 돌아가기</button></a>
        </div>
    </center>
</body>
</html>