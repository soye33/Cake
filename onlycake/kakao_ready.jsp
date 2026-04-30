<%@ page contentType="application/json;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*, java.util.*, org.json.simple.*, org.json.simple.parser.*" %>

<%
request.setCharacterEncoding("UTF-8");
JSONObject result = new JSONObject();

StringBuilder sb = new StringBuilder();
BufferedReader reader = request.getReader();
String line;
while ((line = reader.readLine()) != null) {
    sb.append(line);
}
reader.close();
System.out.println("받은 JSON 데이터: " + sb.toString());

try {
    JSONParser parser = new JSONParser();
    JSONObject json = (JSONObject) parser.parse(sb.toString());

    String userId = (String) session.getAttribute("sid");
    if (userId == null) {
        result.put("error", "로그인이 필요합니다.");
        out.print(result.toJSONString());
        return;
    }

    String itemName = "Order Cake"; // 또는 "도안케이크" 대신 영어로

    String partner_order_id = "ORD" + System.currentTimeMillis();
    String finalAmount = (String) json.get("ordPay");

    URL url = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Authorization", "SECRET_KEY DEVE1B72C6E2780DA722379B99505A951766E505");
    conn.setRequestProperty("Content-Type", "application/json");
    conn.setDoOutput(true);

    JSONObject payRequest = new JSONObject();
    payRequest.put("cid", "TC0ONETIME");
    payRequest.put("partner_order_id", partner_order_id);
    payRequest.put("partner_user_id", userId);
    payRequest.put("item_name", itemName);
    payRequest.put("quantity", 1);
    payRequest.put("total_amount", Integer.parseInt(finalAmount));
    payRequest.put("tax_free_amount", 0);
    payRequest.put("approval_url", "http://localhost:8080/onlycake/KakaopayOK.jsp");
    payRequest.put("cancel_url", "http://localhost:8080/onlycake/shopping_order&payment.jsp");
    payRequest.put("fail_url", "http://localhost:8080/onlycake/shopping_order&payment.jsp");

    OutputStream os = conn.getOutputStream();
    os.write(payRequest.toString().getBytes("UTF-8"));
    os.flush();
    os.close();

    BufferedReader resReader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
    StringBuilder resSb = new StringBuilder();
    while ((line = resReader.readLine()) != null) {
        resSb.append(line);
    }
    resReader.close();

    JSONObject kakaoRes = (JSONObject) parser.parse(resSb.toString());

    session.setAttribute("tid", kakaoRes.get("tid"));
    session.setAttribute("order_id", partner_order_id);
    session.setAttribute("kakaoPayData", json); // 배송 및 상품 정보 저장

    result.put("redirect", kakaoRes.get("next_redirect_pc_url"));
    out.print(result.toJSONString());

} catch (Exception e) {
    e.printStackTrace();
    result.put("error", e.getMessage());
    out.print(result.toJSONString());
}
%>
