<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>

<%
    // POST 요청으로 받은 데이터 가져오기
    String reviewIdxParam = request.getParameter("reviewIdx");
    String reviewPwd = request.getParameter("reviewPwd");

    if (reviewIdxParam == null || reviewPwd == null || reviewIdxParam.trim().isEmpty() || reviewPwd.trim().isEmpty()) {
%>
    <script>
        alert("잘못된 요청입니다.");
        location.href = "Review.jsp"; // 후기 목록으로 이동
    </script>
<%
        return;
    }

    int reviewIdx = -1;
    try {
        reviewIdx = Integer.parseInt(reviewIdxParam);
    } catch (NumberFormatException e) {
%>
    <script>
        alert("잘못된 후기 번호입니다.");
        location.href = "Review.jsp";
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/cake";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 비밀번호 확인
        String checkPwdSql = "SELECT reviewPwd FROM review WHERE reviewIdx = ?";
        pstmt = conn.prepareStatement(checkPwdSql);
        pstmt.setInt(1, reviewIdx);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String storedPwd = rs.getString("reviewPwd");

            if (!storedPwd.equals(reviewPwd)) {
%>
    <script>
        alert("비밀번호가 올바르지 않습니다.");
        history.back();
    </script>
<%
                return;
            }
        } else {
%>
    <script>
        alert("삭제할 후기가 존재하지 않습니다.");
        location.href = "Review.jsp";
    </script>
<%
            return;
        }

        rs.close();
        pstmt.close();

        // 삭제
        String deleteSql = "DELETE FROM review WHERE reviewIdx = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, reviewIdx);
        int rows = pstmt.executeUpdate();

        if (rows > 0) {
%>
    <script>
        alert("후기가 삭제되었습니다.");
        location.href = "Review.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("후기 삭제에 실패했습니다.");
        history.back();
    </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("데이터베이스 오류가 발생했습니다.");
        history.back();
    </script>
<%
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
        try { if (conn != null) conn.close(); } catch (Exception ignored) {}
    }
%>
