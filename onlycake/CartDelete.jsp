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

    String ctNo = request.getParameter("ctNo"); // 삭제할 장바구니 번호 가져오기

    if (ctNo == null || ctNo.trim().isEmpty()) {
        out.println("<script>alert('잘못된 요청입니다.'); location.href='Cart.jsp';</script>");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "DELETE FROM cart WHERE ctNo = ? AND memId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, ctNo);
        pstmt.setString(2, id);

        int result = pstmt.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('장바구니에서 삭제되었습니다.'); location.href='Cart.jsp';</script>");
        } else {
            out.println("<script>alert('삭제할 항목이 없습니다.'); location.href='Cart.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다. 다시 시도해주세요.'); location.href='Cart.jsp';</script>");
    } finally {
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
