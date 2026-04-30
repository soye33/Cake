<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("EUC-KR");
boolean isExist = false;

try {
    String DB_URL = "jdbc:mysql://localhost:3306/cake";  // 데이터베이스 연결 정보
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // MySQL JDBC 드라이버 로드
    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String nickname = request.getParameter("nickname");

    if (nickname == null || nickname.trim().isEmpty()) {
        out.println("<script>alert('닉네임 값이 없습니다.'); window.close();</script>");
        return;
    }
    // SQL 실행
    String sql = "SELECT * FROM member WHERE memNickname = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setString(1, nickname);
    ResultSet rs = pstmt.executeQuery();

    isExist = rs.next(); 

    rs.close();
    pstmt.close();
    con.close();

} catch (Exception e) {
    e.printStackTrace(); // 서버 콘솔에 오류 출력
    out.println("<pre>");
    e.printStackTrace(new java.io.PrintWriter(out)); // 브라우저에서 오류 확인 가능
    out.println("</pre>");
}
%>

<html>
<head>
<title>사용자 닉네임 중복 검사</title>
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
        background-color: #FFF6ED;
        font-family: 'NanumSquareNeo', sans-serif;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center; /* 세로 방향 정렬 */
        align-items: center; /* 가로 방향 정렬 */
    }

    h3 {
        font-size: 25px;
        color: #744731;
    }

    b {
        font-size: 30px;
        color: #C31D3B;
        margin-bottom: 30px; /* 버튼과 간격 추가 */
    }

    .button-container {
        margin-top: 20px; /* 자동으로 아래로 이동 */
        padding-top: 20px;
    }

    .close {
        font-size: 20px;
        padding: 10px 20px;
        background-color: #C31D3B;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    .close:hover {
        background-color: #a6172e;
    }

</style>
</head>

<body>
          <h3>닉네임:  <%=request.getParameter("nickname")%></h3>
  <%  
		   if(isExist)  
                 out.println("<b>이미 존재하는 닉네임입니다.</b>");
	       else 
                 out.println("<b>사용 가능한 닉네임입니다.</b>");
  %>
            <div class="button-container">
				<button onclick="window.close()" class="close">닫기</button>
			</div>
</body>
</html>
