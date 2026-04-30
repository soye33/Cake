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
    height: 30px;
    display: flex;
    flex-direction: column; /* 수직 방향으로 정렬 */
    justify-content: center;
    align-items: center;
	padding-bottom: 10px;
	padding-top: 10px;
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
            width: 1100px;
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
		
		.table-td{
			text-align: center;
            border: solid 1px #744731; /* 테두리 설정 */
            width: 300px;
            height: 30px;
            color: #744731;
            font-size: 23px;
		}
		
        td {
            text-align: center;
            border: solid 1px #744731; /* 테두리 설정 */
            width: 750px;
            height: 30px;
            color: #744731;
            font-size: 16px;
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

            .photo{
			align-items: center;
			justify-content: center;
			display: flex;
			flex-direction: row;
            width: 700px;
            height: 50px;
            font-size: 20px;
            margin-top: 30px;
            border: 2px solid #C31D3B;
            color: #C31D3B;
            border-radius: 10px;
            cursor: pointer;
			background-color: #FFF6ED;
			margin: 0 auto;
		}
		
		.form-content4{
			display: flex;
			flex-direction: column;
			align-items: center;
			margin-top: 30px;
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
				font-family: 'NanumSquareNeoBold', sans-serif;
            }

            .upload-button:hover {
                background-color: #c31d3b;
            }

            .submit-button {
                width: 500px;
                height: 50px;
                background-color: #744731;
                color: #fff;
                border: none;
                border-radius: 10px;
                padding: 10px 20px;
                font-size: 26px;
                cursor: pointer;
                margin-top: 50px;
                margin-bottom: 50px;
				font-family: 'NanumSquareNeoBold', sans-serif;
            }

            .submit-button:hover {
                background-color: #c31d3b;
            }

            .input {
                width: 100%;
                padding: 10px;
                border: none;
                background-color: transparent;
                font-size: 17px;
                color: #744731;
                height: 30px;
				font-family: 'NanumSquareNeo', sans-serif;
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
        <a href="ManagerProduct.jsp"><img src="images/logo_brown.png" alt="로고" /></a>
    </div>

    <div id="manager">
        <a href="ManagerProduct.jsp"><b>관리자 페이지 - 상품관리</b></a><br />
        <p>상품을 추가, 수정, 삭제할 수 있는 페이지입니다.</p>
        <p>관리자님. / <a href="Logout.jsp">로그아웃</a></p>
    </div>

    <div id="nav">
        <a href="ManagerMember.jsp"><button>회원관리</button></a>
        <a href="ManagerProduct.jsp"><button style="background-color:#744731; color:#fff6ed;">상품관리</button></a>
        <a href="ManagerDelivery.jsp"><button>배송관리</button></a>
		<a href="ManagerStats.jsp"><button>통계/후기</button></a>
    </div>

    <div id="content">
        <div class="content-1"><b>상품추가</b></div>
        <div class="content-2">
            <form action="ProductInsert_Result.jsp" method="post">
               
			   <div class="form-content4">
					<label for="photoUpload" class="photo" style="font-family: 'NanumSquareNeoBold', sans-serif; cursor: pointer;">
						사진 첨부하기
					</label>
					<input type="file" id="photoUpload" accept="image/*" style="display: none;" name="photoUpload">
					<div id="fileInfo" style="margin-top: 10px; font-family: 'NanumSquareNeoBold', sans-serif;"></div>
					<img id="previewImage" src="" alt="미리보기" style="display: none; width: 150px; margin-top: 10px;">
				</div>
			   
                <table>
                    <tr>
						<td class="table-td">상품번호</td>
						<td><input type="text" name="prdNo" class="input" required /></td>
					</tr>
					<tr>
                        <td class="table-td">카테고리</td>
                        <td>
                            <select id="category" name="category">
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
                                style="height: 100px" />
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
            <img src="images/logo_letter_white.png" />
            <p>고객센터</p>
            <b>02-339-9947</b>
            <p>평일 AM 10:00 ~ PM 20:00 주말, 공휴일 휴무</p>
        </div>
        <div class="footer-2">
            <p><a href="#">이용약관</a> | <a href="#">개인정보처리방침</a> | <a href="#">이메일무단수집거부</a></p>
            <p>
                오롯이 케이크 / 레터링 CAKE | 통신판매업신고번호 : 2025-서울마포-0061 | 사업자등록번호 : 120 - 99 - 48278 주식회사 오롯이케이크
            </p>
            <p>주소 : 서울시 마포구 연남동 334-25번지 2층 | 대표자: 이장 | 전화번호 : 02 - 339 - 9947</p>
            <p>Copyright onlycake.All Rights Reserved.</p>
        </div>
    </div>

    <script>
    document.getElementById("photoUpload").addEventListener("change", function(event) {
        const file = event.target.files[0];
        const fileInfo = document.getElementById("fileInfo");
        const previewImage = document.getElementById("previewImage");

        if (file) {
            fileInfo.textContent = `${file.name}`;

            const reader = new FileReader();
            reader.onload = function(e) {
                previewImage.src = e.target.result;
                previewImage.style.display = "block";
            };
            reader.readAsDataURL(file);
        } else {
            fileInfo.textContent = "";
            previewImage.style.display = "none";
        }
    });
</script>
</body>
</html>