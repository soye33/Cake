<%@ page contentType="text/html;charset=euc-kr" %> <%@ page import="java.sql.*" %>
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
                height: 120px;
                background-color: #fff6ed;
                border-bottom: solid 2px #744731;
                display: flex;
                justify-content: center; /* 수직 중앙 정렬 */
                align-items: center; /* 수평 중앙 정렬 */
            }

            #header img {
                width: 120px;
                height: 120px;
            }

            #manager {
                width: 1440px;
                height: auto;
                background-color: #fff6ed;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
                padding-top: 50px;
                padding-bottom: 50px;
            }

            #manager b {
                font-size: 50px;
                color: #744731;
            }

            #manager p {
                font-size: 20px;
                color: #744731;
            }

            #nav {
                width: 1440px;
                height: 100px;
                background-color: #fff6ed;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            #nav button {
                width: 300px;
                height: 50px;
                background-color: #fff6ed;
                border: solid 2px #744731;
                border-radius: 10px;
                margin: 0 20px; /* 좌우에 15px의 간격 추가 (각 버튼 사이에 총 40px) */
                color: #744731;
                font-size: 25px;
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
                flex-direction: column;
                justify-content: center;
                align-items: center;
                box-sizing: border-box;
            }

            .content-1 {
                width: 1440px;
                height: 150px;
                display: flex;
                justify-content: center;
                align-items: center;
                color: #744731;
                font-size: 40px;
            }

            .content-1 img {
                width: 150px;
                height: 150px;
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
                width: 1000px;
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
                width: 130px;
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
                text-decoration: underline; /* 마우스 오버 시 밑줄 추가 */
                color: #c31d3b;
            }

            .upload-container {
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 450px;
            }

            .content-2 .uploadspace {
                width: 300px;
                height: 300px;
                border: solid 1px #744731;
                box-sizing: border-box;
                margin: 20px 0;
            }

            .file-upload {
                position: relative;
                overflow: hidden;
                margin: 20px 0;
            }

            .file-upload input[type="file"] {
                font-size: 20px;
                position: absolute;
                top: 0;
                right: 0;
                opacity: 0; /* 숨겨진 파일 입력 */
                cursor: pointer;
            }

            .upload-button {
                width: 300px;
                height: auto;
                background-color: #744731;
                color: #fff;
                border: none;
                border-radius: 10px;
                padding: 10px 20px;
                font-size: 20px;
                cursor: pointer;
            }

            .upload-button:hover {
                background-color: #c31d3b;
            }

            .submit-button {
                width: 500px;
                height: 60px;
                background-color: #744731;
                color: #fff;
                border: none;
                border-radius: 10px;
                padding: 10px 20px;
                font-size: 30px;
                cursor: pointer;
                margin-top: 50px;
                margin-bottom: 50px;
            }

            .submit-button:hover {
                background-color: #c31d3b;
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
                font-size: 20px;
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
        </style>
    </head>
    <body>
    <div id="header">
        <a href="ManagerLoginOK.jsp"><img src="images/logo_brown.png" alt="로고" /></a>
    </div>

    <div id="manager">
        <a href="ManagerLoginOK.jsp"><b>관리자 페이지 - 상품관리</b></a><br />
        <p>상품을 추가, 수정, 삭제할 수 있는 페이지입니다.</p><br />
        <p>관리자님. / <a href="Logout.jsp">로그아웃</a></p>
    </div>

    <div id="nav">
        <a href="ManagerMember.jsp"><button>회원관리</button></a>
        <a href="ManagerProduct.jsp"><button>상품관리</button></a>
        <a href="ManagerDelivery.jsp"><button>배송관리</button></a>
    </div>

    <div id="content">
        <div class="content-1"><b>상품추가</b></div>
        <div class="content-2">
            <form action="ProductAdd_Result.jsp" method="post">
                <div class="upload-container">
                    <div
                        id="uploadspace"
                        class="uploadspace"
                        style="border: 1px solid #744731; width: 300px; height: 300px; display: flex; justify-content: center; align-items: center;">
                        <!-- 미리보기 이미지가 여기에 표시됩니다 -->
                    </div>
                    <div class="file-upload">
                        <button type="button" class="upload-button">상품 사진 업로드</button>
                        <input
                            type="file"
                            id="upload"
                            name="file"
                            accept=".png, .jpg, .jpeg"
                            required
                            onchange="previewImage(event)" />
                    </div>
                </div>
                <br /><br />
                <table>
                    <tr>
                        <td class="table-td">카테고리</td>
                        <td>
                            <select id="category" name="category">
                                <option value="디자인케이크">디자인케이크</option>
                                <option value="도안케이크">도안케이크</option>
                                <option value="생일케이크">생일케이크</option>
                                <option value="결혼식케이크">결혼식케이크</option>
                                <option value="기념일케이크">기념일케이크</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="table-td">상품명</td>
                        <td><input type="text" name="productName" class="input" required /></td>
                    </tr>
                    <tr>
                        <td class="table-td">상품 상세설명</td>
                        <td>
                            <input
                                type="text"
                                name="productDescription"
                                class="input"
                                required
                                style="height: 150px" />
                        </td>
                    </tr>
                    <tr>
                        <td class="table-td">가격</td>
                        <td><input type="text" name="productPrice" class="input" required /></td>
                    </tr>
                </table>
                <div style="display: flex; justify-content: center; width: 100%">
                    <button type="submit" class="submit-button">상품 등록</button>
                </div>
            </form>
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


    <script>
        function previewImage(event) {
            const uploadspace = document.getElementById("uploadspace");
            const file = event.target.files[0]; // 선택된 파일
            const reader = new FileReader();

            reader.onload = function (e) {
                // 기존 내용을 지우고 새 이미지를 추가
                uploadspace.innerHTML = `<img src="${e.target.result}" alt="상품 사진" style="width: 298px; height: auto;"/>`;
            };

            if (file) {
                reader.readAsDataURL(file); // 파일을 Data URL로 읽어오기
            }
        }
    </script>
</body>
</html>