<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
request.setCharacterEncoding("EUC-KR");

String id = (String) session.getAttribute("sid");
String memName = (String) session.getAttribute("memName");
String memNickname = (String) session.getAttribute("memNickname");

// [1] 쿼리스트링에서 파라미터 받기
String ordNo = request.getParameter("ordNo");
String ctNosParam = request.getParameter("ctNos");
String ordPayParam = request.getParameter("ordPay");
String totalQuantityParam = request.getParameter("totalQuantity");

String ordRecipient = request.getParameter("ordrecipient");
String ordRcvaddress1 = request.getParameter("ordRcvaddress1");
String ordRcvaddress2 = request.getParameter("ordRcvaddress2");
String ordRcvphone = request.getParameter("ordRcvphone");
String shippingRequest = request.getParameter("shippingRequest");
String ordBank = request.getParameter("ordBank");
String ordBankname = request.getParameter("ordBankname");

String ordRcvaddress = ordRcvaddress1 + " " + ordRcvaddress2;

if (ordNo == null || ctNosParam == null) {
    out.println("<script>alert('주문 정보가 유효하지 않습니다.'); history.back();</script>");
    return;
}

String[] ctNos = ctNosParam.split(",");
int ordPay = (ordPayParam != null && !ordPayParam.isEmpty()) ? Integer.parseInt(ordPayParam) : 0;
int totalQuantity = (totalQuantityParam != null && !totalQuantityParam.isEmpty()) ? Integer.parseInt(totalQuantityParam) : 1;

// [2] DB 처리
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("org.gjt.mm.mysql.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR", "multi", "abcd");

    // [2-1] 장바구니 상품 조회
    StringBuilder sql = new StringBuilder("SELECT c.*, p.prdName, p.prdPrice FROM cart c JOIN cake p ON c.prdNo = p.prdNo WHERE c.ctNo IN (");
    for (int i = 0; i < ctNos.length; i++) {
        sql.append("?");
        if (i < ctNos.length - 1) sql.append(", ");
    }
    sql.append(")");

    pstmt = conn.prepareStatement(sql.toString());
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
    rs.close();
    pstmt.close();

    // [2-2] orderinfo 저장
    pstmt = conn.prepareStatement(
        "INSERT INTO orderinfo (ordNo, prdNo, memName, memNickname, ordDate, prdDeliverydate, ordReceiver, ordRcvaddress, ordRcvphone, ordPay, ordBank, ordBankname, ordRecipient, shippingRequest, ordQty) " +
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
        pstmt.setInt(9, ordPay);
        pstmt.setString(10, ordBank);
        pstmt.setString(11, ordBankname);
        pstmt.setString(12, ordRecipient);
        pstmt.setString(13, shippingRequest);
        pstmt.setInt(14, Integer.parseInt(item.get("ctQty")));
        pstmt.executeUpdate();
    }
    pstmt.close();

    // [2-3] productDetail 저장
    pstmt = conn.prepareStatement(
        "INSERT INTO productDetail (ordNo, prdNo, prdCakesize, prdSizeprice, prdTaste, prdFruit, prdFruitprice, prdTopcream, prdBottomcream, prdCandle, prdCooling, prdDeliverydate, prdLettering, prdDesign, prdMessage, prdCandleprice, prdCoolingprice) " +
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

    // [2-4] cart 삭제
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

    // [3] PayResult.jsp로 이동
    response.sendRedirect("PayResult.jsp?ordNo=" + ordNo);

} catch (Exception e) {
    e.printStackTrace();
    out.println("<p style='color:red;'>오류 발생: " + e.getMessage() + "</p>");
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
    try { if (conn != null) conn.close(); } catch (Exception ignored) {}
}
%>
