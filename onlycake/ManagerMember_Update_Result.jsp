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
			margin-top: 30px;
			width: 600px;
            height: 50px;
            background-color: #744731;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 20px;
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
    <h1>회원 정보 수정 결과</h1>

    <%
        request.setCharacterEncoding("euc-kr");

        String memId = request.getParameter("memId");
        if (memId == null || memId.trim().isEmpty()) {
            out.println("회원 ID가 잘못되었습니다.");
            return;
        }

        String DB_URL = "jdbc:mysql://localhost:3306/cake";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String memName = request.getParameter("memName");
        String memNickname = request.getParameter("memNickname");
        String memBirth = request.getParameter("memBirth");
        String memEmail = request.getParameter("memEmail");
        String memPwd = request.getParameter("memPwd");
        String memSex = request.getParameter("memSex");
		String memPhone = request.getParameter("phone-prefix") +
                   request.getParameter("phone1") + 
                   request.getParameter("phone2");

        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            // 회원 정보 업데이트 쿼리
            String updateSQL = "UPDATE member SET memName=?, memNickname=?, memBirth=?, memEmail=?, memPwd=?, memSex=?, memPhone=? WHERE memId=?";
            pstmt = con.prepareStatement(updateSQL);
            pstmt.setString(1, memName);
            pstmt.setString(2, memNickname);
            pstmt.setString(3, memBirth);
            pstmt.setString(4, memEmail);
            pstmt.setString(5, memPwd);
            pstmt.setString(6, memSex);
            pstmt.setString(7, memPhone);
            pstmt.setString(8, memId);

            int result = pstmt.executeUpdate(); // UPDATE 쿼리 실행

            if (result > 0) {
                out.println("<p>회원 정보가 성공적으로 수정되었습니다.</p>");
            } else {
                out.println("<p>회원 정보 수정에 실패했습니다. 다시 시도해 주세요.</p>");
            }

            // 수정된 회원 정보를 가져오는 쿼리
            String jsql = "SELECT * FROM member WHERE memId = ?";
            pstmt = con.prepareStatement(jsql);
            pstmt.setString(1, memId); // memId를 설정
            rs = pstmt.executeQuery(); // SELECT 쿼리 실행

            if (rs.next()) {
                // 추가적인 정보가 필요할 경우 여기서 가져올 수 있습니다.
            } else {
                out.println("해당 회원을 찾을 수 없습니다.");
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
        <div id="h1Section"><p>수정된 회원 정보<p></div>
        <div id="formSection">
            <form action="#" method="post">
                <table>
                    <tr>
                        <td class="tdInput">회원 ID</td>
                        <td><%= memId %></td>
                    </tr>    
                    <tr>
                        <td class="tdInput">이름</td>
                        <td><%= memName %></td>
                    </tr>
                    <tr>
                        <td class="tdInput">닉네임</td>
                        <td><%= memNickname %></td>
                    </tr>
                    <tr>
                        <td class="tdInput">생일</td>
                        <td><%= memBirth %></td>
                    </tr>
                    <tr>
                        <td class="tdInput">이메일</td>
                        <td><%= memEmail %></td>
                    </tr>
                    <tr>
                        <td class="tdInput">성별</td>
                        <td><%= memSex %></td>
                    </tr>
                    <tr>
                        <td class="tdInput">전화번호</td>
                        <td><%= memPhone %></td>
                    </tr>
                </table>
            </form>    
            <div class="btn-container">
                <a href="ManagerMember.jsp"><button>회원 목록으로 돌아가기</button></a>
            </div>
        </div>
    </div>
    </center>
</body>
</html>