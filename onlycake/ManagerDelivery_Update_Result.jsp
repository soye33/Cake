<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("euc-kr");
    String ordNo = request.getParameter("ordNo");
    String status = request.getParameter("status");

    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cake", "multi", "abcd");

        String sql = "UPDATE orderinfo SET deliveryStatus = ? WHERE ordNo = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, status);
        pstmt.setString(2, ordNo);

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
<script>
    alert("배송 상태가 성공적으로 수정되었습니다!");
    location.href = "ManagerDelivery.jsp";
</script>
<%
        } else {
%>
<script>
    alert("배송 상태 수정에 실패했습니다. 주문번호를 확인해주세요.");
    history.back();
</script>
<%
        }
    } catch (Exception e) {
%>
<script>
    alert("에러 발생: <%= e.getMessage() %>");
    history.back();
</script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (con != null) try { con.close(); } catch (SQLException ignored) {}
    }
%>
