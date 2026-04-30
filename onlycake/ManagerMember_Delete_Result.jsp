<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>관리자-회원 삭제 확인</title>
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
	border-top: solid 2px #744731;
	margin-top: 20px;
}

#h1Section p {
    width: 100%;
    text-align: center;
    margin: 0;
    padding: 0;
	font-size: 25px;
	margin-bottom: 30px;
	margin-top: 30px;
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
			font-size: 25px;
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
            height: 30px;
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
			padding: 10px;
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
			width: 400px;
            height: 50px;
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
        <h1>회원 삭제 결과</h1>

        <%
            request.setCharacterEncoding("euc-kr");

            // memId 가져오기
            String memId = request.getParameter("memId");
            if (memId == null || memId.trim().isEmpty()) {
                out.println("<p>회원 아이디가 잘못되었습니다.</p>");
                return;
            }

            // Debug: memId 출력
            out.println("<p>memId: " + memId + "</p>"); // memId 출력

            String DB_URL = "jdbc:mysql://localhost:3306/cake";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";
            Connection con = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("org.gjt.mm.mysql.Driver");
                con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String deleteSql = "DELETE FROM member WHERE memId = ?";
                pstmt = con.prepareStatement(deleteSql);
                pstmt.setString(1, memId); // memId는 String 타입이므로 setString 사용
                int result = pstmt.executeUpdate(); // DELETE 쿼리 실행

                if (result > 0) {
                    out.println("<p>회원정보가 성공적으로 삭제되었습니다.</p>");
                } else {
                    out.println("<p>회원정보 삭제에 실패했습니다. 다시 시도해 주세요.</p>");
                }

            } catch (Exception e) {
                out.println("<p>에러: " + e.getMessage() + "</p>"); // 에러 메시지 출력
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
            <a href="ManagerMember.jsp"><button>전체 회원 목록으로 돌아가기</button></a>
        </div>
    </center>
</body>
</html>