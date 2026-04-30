<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("EUC-KR");
    String reviewIdx = request.getParameter("reviewIdx");

    String DB_URL = "jdbc:mysql://localhost:3306/cake?serverTimezone=Asia/Seoul&characterEncoding=EUC-KR";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "DELETE FROM review WHERE reviewIdx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(reviewIdx));

        int result = pstmt.executeUpdate();

        if (result > 0) {
            response.sendRedirect("ManagerReview.jsp");
        } else {
            out.println("<script>alert('삭제 실패!'); history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생!'); history.back();</script>");
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
