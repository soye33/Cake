<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("EUC-KR");
    String id = (String) session.getAttribute("sid");

    // 로그인 확인
    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='Login.jsp';</script>");
        return;
    }

    String ctNo = request.getParameter("ctNo"); // 장바구니 항목 번호
    String changeQtyStr = request.getParameter("changeQty"); // 수량 변경 값 (-1 또는 1)

    if (ctNo == null || changeQtyStr == null || ctNo.trim().isEmpty() || changeQtyStr.trim().isEmpty()) {
        out.println("<script>alert('잘못된 요청입니다.'); location.href='Cart.jsp';</script>");
        return;
    }

    int changeQty = Integer.parseInt(changeQtyStr);

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 현재 수량 조회
        String selectSql = "SELECT ctQty FROM cart WHERE ctNo = ? AND memId = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setString(1, ctNo);
        pstmt.setString(2, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int currentQty = rs.getInt("ctQty");
            int newQty = currentQty + changeQty;

            if (newQty < 1) { // 최소 수량 제한 (1개 이하일 경우 삭제 처리)
                String deleteSql = "DELETE FROM cart WHERE ctNo = ? AND memId = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setString(1, ctNo);
                pstmt.setString(2, id);
                pstmt.executeUpdate();
                out.println("<script>alert('상품이 장바구니에서 삭제되었습니다.'); location.href='Cart.jsp';</script>");
            } else {
                String updateSql = "UPDATE cart SET ctQty = ? WHERE ctNo = ? AND memId = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setInt(1, newQty);
                pstmt.setString(2, ctNo);
                pstmt.setString(3, id);
                pstmt.executeUpdate();
                out.println("<script>location.href='Cart.jsp';</script>");
            }
        } else {
            out.println("<script>alert('수량을 변경할 수 없습니다.'); location.href='Cart.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다. 다시 시도해주세요.'); location.href='Cart.jsp';</script>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
