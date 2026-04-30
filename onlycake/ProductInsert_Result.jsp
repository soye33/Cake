<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<html>
<head>
<title>관리자-상품 추가 결과</title>
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
		body{
			font-family: 'NanumSquareNeo', sans-serif;
		}
</style>
</head>
<body>

<% 
    request.setCharacterEncoding("euc-kr");  

    String file = request.getParameter("file"); //상품 이미지 파일
	String prdNo = request.getParameter("prdNo"); //상품 카테고리
    String category = request.getParameter("category"); //상품 카테고리
    String productName = request.getParameter("productName"); //상품이름
    String productDescription = request.getParameter("productDescription"); //상품 상세설명
    int productPrice = Integer.parseInt(request.getParameter("productPrice")); //상품가격
	
    if (productDescription == null || productDescription.trim().isEmpty()) {
        productDescription = null; 
    }

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake"; 
        String DB_ID = "multi"; 
        String DB_PASSWORD = "abcd"; 
        
        Class.forName("org.gjt.mm.mysql.Driver");  
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
               

     
        String jsql = "INSERT INTO cake (prdImage, prdNo, ctgType, prdName, prdDetail, prdPrice) ";
        jsql += "VALUES (?, ?, ?, ?, ?, ?)"; 
        
       
        PreparedStatement pstmt = con.prepareStatement(jsql); 

        
        pstmt.setString(1, file);
		pstmt.setString(2, prdNo);
        pstmt.setString(3, category); 
        pstmt.setString(4, productName);
        pstmt.setString(5, productDescription);
        pstmt.setInt(6, productPrice);
        pstmt.executeUpdate(); 
%>
<center>
<font color="#744731" size='20'><b>[등록된 상품 정보]</b></font><p>
<table cellpadding="10" style="font-size:18pt; font-family:맑은 고딕; border: solid 2px #744731; background-color: #FFF6ED;">
    <tr><td width="200">상품 이미지</td><td width="800"><%= file %></td></tr>
	<tr><td width="200">상품번호</td><td width="800"><%= prdNo %></td></tr>
    <tr><td width="200">상품 카테고리</td><td width="800"><%= category %></td></tr>
    <tr><td width="200">상품명</td><td width="800"><%= productName %></td></tr>
    <tr><td width="200">상품설명</td><td width="800"><%= productDescription != null ? productDescription : "없음" %></td></tr>
    <tr><td width="200">상품가격</td><td width="800"><%= productPrice %> 원</td></tr>
</table><p>
<% 
    } catch(Exception e) { 
        out.println(e);
    }
%>
<p>
<a href="ProductList.jsp" style="font-size:10pt;font-family:맑은 고딕">전체 등록상품 조회</a><br><br>
</center>
</body>
</html>
