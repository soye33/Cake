<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%
    // POST 요청으로 받은 데이터 가져오기
    String questionIdxParam = request.getParameter("questionIdx");
    String questionPwd = request.getParameter("questionPwd");

    // 값이 정상적으로 전달되었는지 확인
    if (questionIdxParam == null || questionPwd == null || questionIdxParam.trim().isEmpty() || questionPwd.trim().isEmpty()) {
%>
    <script>
        alert("잘못된 요청입니다.");
        location.href = "CustomerService_Inquiry.jsp"; // 문의 목록으로 이동
    </script>
<%
        return;
    }

    int questionIdx = -1;
    try {
        questionIdx = Integer.parseInt(questionIdxParam);
    } catch (NumberFormatException e) {
        e.printStackTrace();
%>
    <script>
        alert("잘못된 문의 번호입니다.");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결 정보
        String DB_URL = "jdbc:mysql://localhost:3306/cake"; // DB 주소
        String DB_ID = "multi"; // DB 아이디
        String DB_PASSWORD = "abcd"; // DB 비밀번호

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 저장된 문의의 비밀번호 가져오기
        String checkPwdSql = "SELECT questionPwd FROM question WHERE questionIdx = ?";
        pstmt = conn.prepareStatement(checkPwdSql);
        pstmt.setInt(1, questionIdx);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String storedPwd = rs.getString("questionPwd");

            // 입력된 비밀번호와 DB에 저장된 비밀번호 비교
            if (!storedPwd.equals(questionPwd)) {
%>
    <script>
        alert("비밀번호가 올바르지 않습니다.");
        history.back(); // 이전 페이지로 돌아가기
    </script>
<%
                return;
            }
        } else {
%>
    <script>
        alert("삭제할 문의가 존재하지 않습니다.");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
            return;
        }

        // 문의 삭제 실행
        String deleteSql = "DELETE FROM question WHERE questionIdx = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, questionIdx);
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
%>
    <script>
        alert("문의가 삭제되었습니다.");
        location.href = "CustomerService_Inquiry.jsp"; // 문의 목록으로 이동
    </script>
<%
        } else {
%>
    <script>
        alert("문의 삭제에 실패했습니다.");
        history.back();
    </script>
<%
        }

    } catch (SQLException e) {
        e.printStackTrace();
%>
    <script>
        alert("데이터베이스 오류가 발생했습니다.");
        history.back();
    </script>
<%
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
