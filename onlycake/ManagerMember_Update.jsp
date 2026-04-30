<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>관리자페이지-회원 정보 수정</title>
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
            border: none; /* 테두리 설정 */
            width: 600px;
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
			font-size: 20px;
			box-sizing: border-box;
			resize: vertical; /* 세로 크기 조정 가능 */
		}
		
		input[type="date"] {
            width: 760px;
			height:30px;
            padding: 10px; 
            font-size: 20px;
            border: 1px solid #744731;
            border-radius: 5px;
			color: #744731; /* placeholder 색상도 동일하게 */
			opacity: 0.7; /* 조금 연하게 */
        }
	 .phone-group {
		display: flex;
		align-items: center;
	}

	.phone-group select,.phone-group input[type="tel"] {
		width: 170px;
		padding: 10px;
		font-size: 20px;
		border: 1px solid #744731;
        border-radius: 5px;
		color: #744731; /* placeholder 색상도 동일하게 */
		opacity: 0.7; /* 조금 연하게 */
	}

    </style>
</head>
<body>

<%
    request.setCharacterEncoding("euc-kr");

    String memId = request.getParameter("memId");
    if (memId == null || memId.trim().isEmpty()) {
        out.println("회원 정보가 잘못되었습니다.");
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

        String jsql = "SELECT * FROM member WHERE memId = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, memId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String memName = rs.getString("memName");
            String memNickname = rs.getString("memNickname");
            String memBirth = rs.getString("memBirth");
            String memEmail = rs.getString("memEmail");
            String memPwd = rs.getString("memPwd");
            String memSex = rs.getString("memSex");
            String memPhone = rs.getString("memPhone");
%>

<div id="formWrapper">
    <div id="h1Section"><h1>회원 정보 수정</h1></div>
    <div id="formSection">
        <form action="ManagerMember_Update_Result.jsp" method="post">
            <input type="hidden" name="memId" value="<%= memId %>">
            <table>
                <tr>
                    <td class="tdInput">이름</td>
                    <td><input type="text" name="memName" value="<%= memName %>" required></td>
                </tr>
                <tr>
                    <td class="tdInput">닉네임</td>
                    <td><input type="text" name="memNickname" value="<%= memNickname %>" required></td>
                </tr>
                <tr>
                    <td class="tdInput">생일</td>
                    <td><input type="date" name="memBirth" value="<%= memBirth %>" required></td>
                </tr>
                <tr>
                    <td class="tdInput">이메일</td>
                    <td><input type="text" name="memEmail" value="<%= memEmail %>" required></td>
                </tr>
                <tr>
                    <td class="tdInput">비밀번호</td>
                    <td><input type="text" name="memPwd" value="<%= memPwd %>" required></td>
                </tr>
                <tr>
					<td class="tdInput">성별</td>
					<td><div class="sex-group">
						<label for="female_">
							여성
							<input type="radio" id="female_" name="memSex" value="여성" checked>
						</label>
						<label for="male_">
							남성
							<input type="radio" id="male_" name="memSex" value="남성">
						</label>
						</div>
					</td>
                    <!-- <td class="tdInput">성별</td>
                    <td><input type="text" name="memSex" value="<%= memSex %>" required></td> -->
                </tr>
                <tr>
                    <td class="tdInput">전화번호</td>
						<td><div class="form-group">
							
								<div class="phone-group">
									<select id="phone-prefix" name="phone-prefix" required>
										<option value="010">010</option>
										<option value="011">011</option>
										<option value="016">016</option>
										<option value="017">017</option>
										<option value="018">018</option>
										<option value="019">019</option>
									</select>
								<p> - </p>
									<input type="tel" id="phone1" name="phone1" placeholder="번호 입력" required>
								<p> - </p>
									<input type="tel" id="phone2" name="phone2" placeholder="번호 입력" required>
								</div>
						</div></td>
                    <!-- <td><input type="text" name="memPhone" value="<%= memPhone %>" required></td> -->
                </tr>
            </table>
            <div class="submit-button-wrapper">
                <button type="submit" class="submit-button">수정하기</button>
                <input type="button" class="submit-button" value="취소" onclick="location.href='ManagerMember.jsp'">
            </div>
        </form>
    </div>
</div>

<%
        } else {
            out.println("해당 회원 정보를 찾을 수 없습니다.");
        }

    } catch (Exception e) {
        // 오류 메시지를 출력
        out.println("오류가 발생했습니다: " + e.getMessage());
        e.printStackTrace(); // 콘솔에 스택 트레이스를 출력
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