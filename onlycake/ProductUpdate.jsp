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

	margin-bottom: 20px;
}

#formSection {
    width: 1100px;
    margin: 0;
    padding: 0;
}

        h1 {
            color: #744731; /* 제목 색상 */
            text-align: center;
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
            font-size: 20px;
        }

        td {
            text-align: center;
            border: none; /* 테두리 설정 */
            width: 700px;
            height: 50px;
            color: #744731;
            font-size: 20px;
        }

        .tdInput {
            text-align: left;
            border: none; /* 테두리 설정 */
            width: 300px;
            height: 30px;
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
            font-size: 17px;
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

<%
    request.setCharacterEncoding("euc-kr");

    String prdNo = request.getParameter("prdNo");
    if (prdNo == null || prdNo.trim().isEmpty()) {
        out.println("상품 번호가 잘못되었습니다.");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String jsql = "SELECT * FROM cake WHERE prdNo = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, prdNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String fileName = rs.getString("prdImage"); // 상품 이미지 파일명 가져오기
            String imagePath = "images/" + fileName; // 예: images/anniversarycake(1).jpg
            String category = rs.getString("ctgType");
            String productName = rs.getString("prdName");
            String productDescription = rs.getString("prdDetail");
            int productPrice = rs.getInt("prdPrice");
			

%>

<div id="formWrapper">
    <div id="h1Section"><h1>상품 수정</h1></div>
    <div id="formSection">
        <form action="ProductUpdate_Result.jsp" method="post">
			<input type="hidden" name="prdNo" value="<%= prdNo %>">
            <table>
                <tr>
                </tr>    
                <tr>
                    <td class="tdInput">상품사진</td>
                    <td><img src="<%= imagePath %>" alt="<%= productName %>" width="100" height="100"/></td>
                </tr>
                <tr>
                    <td class="tdInput">카테고리</td>
                    <td><input type="text" name="category" value="<%= category %>" required></td>
                </tr>
                <tr>
                    <td class="tdInput">상품명</td>
                    <td><input type="text" name="productName" value="<%= productName %>" required></td>
                </tr>
                <tr>
					<td class="tdInput">상품 상세 설명</td>
					<td><textarea name="productDescription" required style="resize: vertical; min-height: 100px;"><%= productDescription %></textarea></td>
				</tr>
                <tr>
                    <td class="tdInput">가격</td>
                    <td><input type="text" name="productPrice" value="<%= productPrice %>" required></td>
                </tr>
            </table>
			
            <div class="submit-button-wrapper">
				<button type="submit" class="submit-button">수정하기</button>
				<input type="button" class="submit-button" value="취소" onclick="location.href='ProductList.jsp'">
			</div>
        </form>
    </div>
</div>

<%
        } else {
            out.println("해당 상품을 찾을 수 없습니다.");
        }

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

</body>
</html>
