<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*, java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page import="org.json.simple.*, org.json.simple.parser.*" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");

String pgToken = request.getParameter("pg_token");
String tid = (String) session.getAttribute("tid");
String orderId = (String) session.getAttribute("order_id");
String userId = (String) session.getAttribute("sid");
JSONObject kakaoPayData = (JSONObject) session.getAttribute("kakaoPayData");

Connection connDB = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

if (tid == null || orderId == null || userId == null || pgToken == null || kakaoPayData == null) {
%>
<html><head><meta charset="UTF-8"></head>
<body>
<script>
    alert('결제 정보가 없습니다.');
    location.href = 'shopping_order&payment.jsp';
</script>
</body></html>
<%
    return;
}

try {
    // 카카오페이 승인 요청
    URL url = new URL("https://open-api.kakaopay.com/online/v1/payment/approve");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Authorization", "SECRET_KEY DEVE1B72C6E2780DA722379B99505A951766E505");
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);

    JSONObject approveData = new JSONObject();
    approveData.put("cid", "TC0ONETIME");
    approveData.put("tid", tid);
    approveData.put("partner_order_id", orderId);
    approveData.put("partner_user_id", userId);
    approveData.put("pg_token", pgToken);

    OutputStream os = conn.getOutputStream();
    os.write(approveData.toString().getBytes("UTF-8"));
    os.flush();
    os.close();

    BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = reader.readLine()) != null) {
        sb.append(line);
    }
    reader.close();

    // 결제 성공 시 DB 저장
    String ordNo = orderId;
    String memName = (String) session.getAttribute("memName");
    String memNickname = (String) session.getAttribute("memNickname");
    String ordRecipient = (String) kakaoPayData.get("ordrecipient");
    String ordRcvaddress = kakaoPayData.get("ordRcvaddress1") + " " + kakaoPayData.get("ordRcvaddress2");
    String ordRcvphone = (String) kakaoPayData.get("ordRcvphone");
    String shippingRequest = (String) kakaoPayData.get("shippingRequest");
    int totalPay = Integer.parseInt((String) kakaoPayData.get("ordPay"));
    String ordBank = "카카오페이";
    String ordBankname = (String) kakaoPayData.get("ordBankname");
    JSONArray ctNosArray = (JSONArray) kakaoPayData.get("ctNos");
    List<String> ctNos = new ArrayList<>();
    for (Object obj : ctNosArray) {
        ctNos.add((String) obj);
    }

    if (ctNos.isEmpty()) {
%>
<html><head><meta charset="UTF-8"></head>
<body>
<script>
    alert('결제할 상품이 없습니다.');
    history.back();
</script>
</body></html>
<%
        return;
    }

    // DB 연결 및 상품 조회
    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=UTF-8";
    Class.forName("org.gjt.mm.mysql.Driver");
    connDB = DriverManager.getConnection(DB_URL, "multi", "abcd");

    StringBuilder sql = new StringBuilder("SELECT c.*, p.prdName, p.prdPrice, p.ctgType FROM cart c JOIN cake p ON c.prdNo = p.prdNo WHERE c.ctNo IN (");
    for (int i = 0; i < ctNos.size(); i++) {
        sql.append("?");
        if (i < ctNos.size() - 1) sql.append(",");
    }
    sql.append(")");
    pstmt = connDB.prepareStatement(sql.toString());
    for (int i = 0; i < ctNos.size(); i++) {
        pstmt.setString(i + 1, ctNos.get(i));
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

    // orderinfo 저장
    pstmt = connDB.prepareStatement(
        "INSERT INTO orderinfo (ordNo, prdNo, memName, memNickname, ordDate, prdDeliverydate, ordReceiver, ordRcvaddress, ordRcvphone, ordPay, ordBank, ordBankname, ordRecipient, shippingRequest, ordQty) VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
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

    // productDetail 저장
    pstmt = connDB.prepareStatement("INSERT INTO productDetail (ordNo, prdNo, prdCakesize, prdSizeprice, prdTaste, prdFruit, prdFruitprice, prdTopcream, prdBottomcream, prdCandle, prdCooling, prdDeliverydate, prdLettering, prdDesign, prdMessage, prdCandleprice, prdCoolingprice) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
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

    // cart 삭제
    StringBuilder delSql = new StringBuilder("DELETE FROM cart WHERE ctNo IN (");
    for (int i = 0; i < ctNos.size(); i++) {
        delSql.append("?");
        if (i < ctNos.size() - 1) delSql.append(",");
    }
    delSql.append(")");
    pstmt = connDB.prepareStatement(delSql.toString());
    for (int i = 0; i < ctNos.size(); i++) {
        pstmt.setString(i + 1, ctNos.get(i));
    }
    pstmt.executeUpdate();
    pstmt.close();

    // 판매량 증가
    pstmt = connDB.prepareStatement("UPDATE cake SET prdCount = prdCount + ? WHERE prdNo = ?");
    for (Map<String, String> item : products) {
        int qty = Integer.parseInt(item.getOrDefault("ctQty", "1"));
        int prdNo = Integer.parseInt(item.get("prdNo"));
        pstmt.setInt(1, qty);
        pstmt.setInt(2, prdNo);
        pstmt.executeUpdate();
    }
    pstmt.close();

    // 세션 정리
    session.removeAttribute("tid");
    session.removeAttribute("order_id");
    session.removeAttribute("kakaoPayData");

%>
<html>
<head>
    <meta charset="UTF-8">
    <script type="text/javascript">
        alert("결제가 완료되었습니다.");
        window.location.href = "PayResult.jsp?ordNo=<%= ordNo %>";
    </script>
</head>
<body></body>
</html>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<html>
<head><meta charset="UTF-8"></head>
<body>
<script>
    alert("카카오페이 결제 중 오류가 발생했습니다. 다시 시도해주세요.");
    history.back();
</script>
</body>
</html>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignore) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception ignore) {}
    try { if (connDB != null) connDB.close(); } catch (Exception ignore) {}
}
%>
