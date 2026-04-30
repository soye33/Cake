<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<%
    String DB_URL = "jdbc:mysql://localhost:3306/cake"; 
    String DB_ID = "multi"; 
    String DB_PASSWORD = "abcd"; 

    String prdNo = request.getParameter("prdNo"); // prdNo 파라미터 받기
    String memId = (String) session.getAttribute("memId"); // 세션에서 memId 가져오기

    if (memId == null) {
        out.print("fail"); // memId가 NULL이면 실패
        return;
    }

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        // wish 테이블에서 삭제하는 쿼리
        String deleteSQL = "DELETE FROM wish WHERE prdNo = ? AND memId = ?";
        pstmt = con.prepareStatement(deleteSQL);
        pstmt.setInt(1, Integer.parseInt(prdNo));
        pstmt.setString(2, memId);
        
        int result = pstmt.executeUpdate();
        
        // 결과에 따라 메시지 출력
        if (result > 0) {
            out.print("삭제 성공"); // 성공 시
        } else {
            out.print("삭제 실패"); // 실패 시
        }
        
    } catch (SQLException e) {
        out.print("SQL 오류: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.print("드라이버 클래스 오류: " + e.getMessage());
    } catch (Exception e) {
        out.print("오류: " + e.getMessage());
    } finally {
        // 리소스 정리
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { /* Ignore */ }
        }
        if (con != null) {
            try { con.close(); } catch (SQLException e) { /* Ignore */ }
        }
    }
%>
