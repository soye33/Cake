<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>관리자-회원 정보 수정</title>
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
	margin-bottom: 30px;
}

#h1Section h1 {
    color: #C31D3B;
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
            font-size: 25px;
        }

        td {
            text-align: center;
            border: 2px solid #744731;
			border-radius: 10px;
            width: 700px;
            height: 50px;
            color: #744731;
            font-size: 20px;
        }

        .tdInput {
            text-align: left;
            border: none; /* 테두리 설정 */
            width: 300px;
            height: 50px;
            color: #744731;
            font-size: 20px;
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
            padding: 10px 10px;
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
			font-size: 20px;
			box-sizing: border-box;
			resize: vertical; /* 세로 크기 조정 가능 */
		}

    </style>
</head>

<body>
    <center>
        <h1>회원 삭제 확인</h1>

        <%
            request.setCharacterEncoding("euc-kr");

            // 변수 선언
            String memId = request.getParameter("memId");
            String memName = null;
            String memNickname = null;
            String memBirth = null;
            String memEmail = null;
            String memPwd = null;
            String memSex = null;
            String memPhone = null;

            if (memId == null || memId.trim().isEmpty()) {
                out.println("회원아이디가 잘못되었습니다.");
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

                // 회원 정보 조회
                String jsql = "SELECT * FROM member WHERE memId = ?";
                pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, memId); // memId는 String 타입이므로 setString 사용
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    memId = rs.getString("memId");
                    memName = rs.getString("memName"); 
                    memNickname = rs.getString("memNickname"); 
                    memBirth = rs.getString("memBirth"); 
                    memEmail = rs.getString("memEmail"); 
                    memPwd = rs.getString("memPwd"); 
                    memSex = rs.getString("memSex"); 
                    memPhone = rs.getString("memPhone"); 
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
            <div id="h1Section"><h1>정말 삭제하시겠습니까?</h1></div>
            <div id="formSection">
                <form action="ManagerMember_Delete_Result.jsp" method="post">
                    <table>
                        <tr>
                            <td class="tdInput">아이디</td>
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
                            <td><%= memEmail %> 원</td>
                        </tr>
                        <tr>
                            <td class="tdInput">비밀번호</td>
                            <td><%= memPwd %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">성별</td>
                            <td><%= memSex %></td>
                        </tr>
                        <tr>
                            <td class="tdInput">휴대폰번호</td>
                            <td><%= memPhone %></td>
                        </tr>
                    </table>
                    <!-- memId를 hidden input으로 추가 -->
                    <input type="hidden" name="memId" value="<%= memId %>">
                    <div class="submit-button-wrapper">
                        <button type="submit" class="submit-button">삭제</button>
                        <input type="button" class="submit-button" value="취소" onclick="location.href='ManagerMember.jsp'">
                    </div>
                </form>
            </div>
        </div>
    </center>
</body>
</html>
