<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>

<%
    request.setCharacterEncoding("EUC-KR");

    String id = (String) session.getAttribute("sid");
    String memName = (String) session.getAttribute("memName");
    String memNickname = (String) session.getAttribute("memNickname");

    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='Login.jsp';</script>");
        return;
    }

    String ordRecipient = request.getParameter("ordrecipient");
    String ordRcvaddress1 = request.getParameter("ordRcvaddress1");
    String ordRcvaddress2 = request.getParameter("ordRcvaddress2");
    String ordRcvaddress = ordRcvaddress1 + " " + ordRcvaddress2;
    String shippingRequest = request.getParameter("shippingRequest");
    String ordBank = request.getParameter("ordBank");
    String ordBankname = request.getParameter("ordBankname");
    String ordRcvphone = request.getParameter("ordRcvphone");
    String[] ctNos = request.getParameterValues("ctNo");

    String totalPayParam = request.getParameter("ordPay");
    int totalPay = (totalPayParam != null && !totalPayParam.isEmpty()) ? Integer.parseInt(totalPayParam) : 0;

    String totalQuantityParam = request.getParameter("totalQuantity");
    int totalQuantity = (totalQuantityParam != null && !totalQuantityParam.isEmpty()) ? Integer.parseInt(totalQuantityParam) : 0;

    if (ctNos == null || ctNos.length == 0) {
        out.println("<script>alert('결제할 상품이 없습니다.'); history.back();</script>");
        return;
    }

    // 여기 수정됨: Date 클래스 명확하게 지정
    String today = new SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String uuidPart = UUID.randomUUID().toString().substring(0, 8);
    String ordNo = "ORD" + today + "-" + uuidPart;

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 장바구니에서 선택된 항목들 조회
        StringBuilder sqlBuilder = new StringBuilder(
            "SELECT c.*, p.prdName, p.prdPrice, p.ctgType FROM cart c " +
            "JOIN cake p ON c.prdNo = p.prdNo WHERE c.ctNo IN ("
        );
        for (int i = 0; i < ctNos.length; i++) {
            sqlBuilder.append("?");
            if (i < ctNos.length - 1) sqlBuilder.append(", ");
        }
        sqlBuilder.append(")");

        pstmt = conn.prepareStatement(sqlBuilder.toString());
        for (int i = 0; i < ctNos.length; i++) {
            pstmt.setString(i + 1, ctNos[i]);
        }

        rs = pstmt.executeQuery();
        List<Map<String, String>> products = new ArrayList<>();
        while (rs.next()) {
            Map<String, String> item = new HashMap<>();
            ResultSetMetaData meta = rs.getMetaData();
            for (int i = 1; i <= meta.getColumnCount(); i++) {
                item.put(meta.getColumnLabel(i), rs.getString(i));
            }
            products.add(item);
        }

        pstmt.close();
        pstmt = conn.prepareStatement(
            "INSERT INTO orderinfo (ordNo, prdNo, memName, memNickname, ordDate, prdDeliverydate, ordReceiver, " +
            "ordRcvaddress, ordRcvphone, ordPay, ordBank, ordBankname, ordRecipient, shippingRequest, ordQty) " +
            "VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );

        for (Map<String, String> item : products) {
            pstmt.setString(1, ordNo);
            pstmt.setInt(2, Integer.parseInt(item.get("prdNo")));
            pstmt.setString(3, memName);
            pstmt.setString(4, memNickname);
            pstmt.setString(5, item.get("prdDeliverydate"));
            pstmt.setString(6, ordRecipient);
            pstmt.setString(7, ordRcvaddress);
            pstmt.setString(8, ordRcvphone);
            pstmt.setInt(9, totalPay);
            pstmt.setString(10, ordBank);
            pstmt.setString(11, ordBankname);
            pstmt.setString(12, ordRecipient);
            pstmt.setString(13, shippingRequest);
            pstmt.setInt(14, Integer.parseInt(item.getOrDefault("ctQty", "1")));
            pstmt.executeUpdate();
        }

        pstmt.close();
        pstmt = conn.prepareStatement(
            "INSERT INTO productDetail (ordNo, prdNo, prdCakesize, prdSizeprice, prdTaste, prdFruit, prdFruitprice, " +
            "prdTopcream, prdBottomcream, prdCandle, prdCooling, prdDeliverydate, prdLettering, prdDesign, " +
            "prdMessage, prdCandleprice, prdCoolingprice) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );

        for (Map<String, String> item : products) {
            pstmt.setString(1, ordNo);
            pstmt.setInt(2, Integer.parseInt(item.get("prdNo")));
            pstmt.setString(3, item.get("prdCakesize"));
            pstmt.setInt(4, Integer.parseInt(item.getOrDefault("prdSizeprice", "0")));
            pstmt.setString(5, item.get("prdTaste"));
            pstmt.setString(6, item.get("prdFruit"));
            pstmt.setInt(7, Integer.parseInt(item.getOrDefault("prdFruitprice", "0")));
            pstmt.setString(8, item.get("prdTopcream"));
            pstmt.setString(9, item.get("prdBottomcream"));
            pstmt.setString(10, item.get("prdCandle"));
            pstmt.setString(11, item.get("prdCooling"));
            pstmt.setString(12, item.get("prdDeliverydate"));
            pstmt.setString(13, item.get("prdLettering"));
            pstmt.setString(14, item.get("prdDesign"));
            pstmt.setString(15, item.get("prdMessage"));
            pstmt.setInt(16, Integer.parseInt(item.getOrDefault("prdCandleprice", "0")));
            pstmt.setInt(17, Integer.parseInt(item.getOrDefault("prdCoolingprice", "0")));
            pstmt.executeUpdate();
        }

        pstmt.close();
        StringBuilder delSql = new StringBuilder("DELETE FROM cart WHERE ctNo IN (");
        for (int i = 0; i < ctNos.length; i++) {
            delSql.append("?");
            if (i < ctNos.length - 1) delSql.append(", ");
        }
        delSql.append(")");
        pstmt = conn.prepareStatement(delSql.toString());
        for (int i = 0; i < ctNos.length; i++) {
            pstmt.setString(i + 1, ctNos[i]);
        }
        pstmt.executeUpdate();

        out.println("<script>alert('결제가 완료되었습니다.'); location.href='PayResult.jsp?ordNo=" + ordNo + "';</script>");
		
		
		
		pstmt = conn.prepareStatement( //상품 구매 수량만큼 해당 제품 prdCount 증가시키는 코드
			"UPDATE cake SET prdCount = prdCount + ? WHERE prdNo = ?"
		);
		for (Map<String, String> item : products) {
			int qty = Integer.parseInt(item.getOrDefault("ctQty", "1"));
			int prdNo = Integer.parseInt(item.get("prdNo"));
			pstmt.setInt(1, qty); // 구매 수량만큼 증가
			pstmt.setInt(2, prdNo);
			pstmt.executeUpdate();
		}
		pstmt.close();



    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>에러 발생: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
