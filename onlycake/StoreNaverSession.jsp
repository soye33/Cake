<%@ page contentType="text/html;charset=EUC-KR" %>
<%
    request.setCharacterEncoding("EUC-KR");

    // 배송 정보
    String ordRecipient = request.getParameter("ordrecipient");
    String ordRcvaddress1 = request.getParameter("ordRcvaddress1");
    String ordRcvaddress2 = request.getParameter("ordRcvaddress2");
    String ordRcvphone = request.getParameter("ordRcvphone");
    String shippingRequest = request.getParameter("shippingRequest");

    // 결제 정보
    String ordBank = request.getParameter("ordBank");
    String ordBankname = request.getParameter("ordBankname");

    // 장바구니 항목들 (다중 hidden input 으로 전달됨)
    String[] ctNos = request.getParameterValues("ctNo");

    // 결제 금액 및 수량
    String ordPayStr = request.getParameter("ordPay");
    String totalQuantityStr = request.getParameter("totalQuantity");

    // 세션에 저장
    session.setAttribute("ordrecipient", ordRecipient);
    session.setAttribute("ordRcvaddress1", ordRcvaddress1);
    session.setAttribute("ordRcvaddress2", ordRcvaddress2);
    session.setAttribute("ordRcvphone", ordRcvphone);
    session.setAttribute("shippingRequest", shippingRequest);

    session.setAttribute("ordBank", ordBank);
    session.setAttribute("ordBankname", ordBankname);

    if (ctNos != null && ctNos.length > 0) {
        session.setAttribute("selectedCtNos", ctNos);
    }

    try {
        int ordPay = (ordPayStr != null && !ordPayStr.isEmpty()) ? Integer.parseInt(ordPayStr) : 0;
        session.setAttribute("ordPay", ordPay);
    } catch (NumberFormatException e) {
        session.setAttribute("ordPay", 0);
    }

    try {
        int totalQuantity = (totalQuantityStr != null && !totalQuantityStr.isEmpty()) ? Integer.parseInt(totalQuantityStr) : 1;
        session.setAttribute("totalQuantity", totalQuantity);
    } catch (NumberFormatException e) {
        session.setAttribute("totalQuantity", 1);
    }

    // 응답 코드
    response.setStatus(200); // 성공
%>
