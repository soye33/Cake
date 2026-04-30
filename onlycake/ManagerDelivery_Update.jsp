<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
    String ordNo = request.getParameter("ordNo");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <title>배송 상태 수정</title>
    <style>
	
	
        body {
            font-family: 'NanumSquareNeo', sans-serif;
            background-color: #FFF6ED;
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 100px;
        }

        h2 {
            color: #744731;
        }

        form {
            background-color: #fff6ed;
            padding: 30px;
            border: 2px solid #744731;
            border-radius: 10px;
        }

        label, select {
            font-size: 18px;
            color: #744731;
            margin-right: 10px;
        }

        button {
            margin-top: 20px;
            background-color: #744731;
            color: #fff6ed;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
        }

        button:hover {
            background-color: #5e3926;
        }
    </style>
</head>
<body>
    <h2>배송 상태 수정</h2>
    <form action="ManagerDelivery_Update_Result.jsp" method="post">
        <input type="hidden" name="ordNo" value="<%= ordNo %>">

        <label for="status">배송 상태:</label>
        <select name="status" id="status">
            <option value="배송준비중">배송준비중</option>
            <option value="배송중">배송중</option>
            <option value="배송완료">배송완료</option>
        </select>

        <br>
        <button type="submit">수정하기</button>
    </form>
</body>
</html>
