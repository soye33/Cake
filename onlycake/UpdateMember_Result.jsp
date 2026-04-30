<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
    <head>
        <title>회원 정보 수정 완료</title>
        <script type="text/javascript">
            function showSuccessMessage() {
                alert("회원정보가 성공적으로 수정되었습니다!");
                window.location.href = "Mypage.jsp";
            }
        </script>
    </head>
    <body>
        <%
            request.setCharacterEncoding("euc-kr");

            String memName = request.getParameter("name");
            String memNickname = request.getParameter("nickname");
            String memBirth = request.getParameter("birthdate");
            String memEmail = request.getParameter("email");
            String memPwd = request.getParameter("password");
            String memSex = request.getParameter("sex");
            String memPhone = request.getParameter("phone");
            String memId = (String) session.getAttribute("sid");  // Retrieve memId from session

            Connection con = null;
            PreparedStatement pstmt = null;
            boolean updateSuccess = false;

            try {
                String DB_URL = "jdbc:mysql://localhost:3306/cake";
                String DB_ID = "multi";
                String DB_PASSWORD = "abcd";

                Class.forName("org.gjt.mm.mysql.Driver");
                con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

                String jsql = "update member set memPwd=?, memName=?, ";
                jsql = jsql + "memNickname=?, memBirth=?, memEmail=?, ";
                jsql = jsql + "memSex=?, memPhone=? where memId=?";
                pstmt = con.prepareStatement(jsql);
                pstmt.setString(1, memPwd);
                pstmt.setString(2, memName);
                pstmt.setString(3, memNickname);
                pstmt.setString(4, memBirth);
                pstmt.setString(5, memEmail);
                pstmt.setString(6, memSex);
                pstmt.setString(7, memPhone);
                pstmt.setString(8, memId);  // Use the retrieved memId here

                int result = pstmt.executeUpdate();
                if (result > 0) {
                    updateSuccess = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div>오류 발생: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            if (updateSuccess) {
                out.println("<script type='text/javascript'>");
                out.println("showSuccessMessage();");
                out.println("</script>");
            } else {
                out.println("<div>회원정보 수정에 실패했습니다. 조건을 확인하세요.</div>");
                out.println("조건: memId=" + memId + ", memPhone=" + memPhone + "<br>");  // Use the memId here as well
            }
        %>
    </body>
</html>
