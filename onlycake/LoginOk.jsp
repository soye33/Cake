<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
    <style type="text/css">
        a:link { text-decoration: none; color: black; }
        a:visited { text-decoration: none; color: black; }
        a:hover { text-decoration: underline; color: blue; }
    </style>
    <script type="text/javascript">
        function showLoginError(message) {
            alert(message);
            window.location.href = "Login.jsp";  
        }
    </script>
</head>
<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<%
    String DB_URL = "jdbc:mysql://localhost:3306/cake"; 
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    // Check if the user is a regular member
    String memberSQL = "SELECT * FROM member WHERE memId = ?";
    PreparedStatement memberPstmt = con.prepareStatement(memberSQL);
    memberPstmt.setString(1, id);
    ResultSet memberRs = memberPstmt.executeQuery();

    if (memberRs.next()) {
        // If user exists in member table
        if (pass.equals(memberRs.getString("memPwd"))) {
            String nickname = memberRs.getString("memNickname");
            String memId = memberRs.getString("memId"); // memId를 가져옴
            session.setAttribute("sid", id);  
            session.setAttribute("memId", memId); // memId 세션에 저장
            session.setAttribute("memNickname", nickname); 
            response.sendRedirect("Index.jsp"); 
        } else {
%>
            <script type="text/javascript">
                showLoginError("비밀번호가 잘못 되었습니다. 다시 확인해 주세요!"); 
            </script>
<%
        }
    } else {
        // If user does not exist in member table, check manager table
        String managerSQL = "SELECT * FROM manager WHERE managerId = ?";
        PreparedStatement managerPstmt = con.prepareStatement(managerSQL);
        managerPstmt.setString(1, id);
        ResultSet managerRs = managerPstmt.executeQuery();

        if (managerRs.next()) {
            // If user exists in manager table
            if (pass.equals(managerRs.getString("managerPwd"))) {
                session.setAttribute("sid", id);  
                response.sendRedirect("ManagerMember.jsp"); 
            } else {
%>
                <script type="text/javascript">
                    showLoginError("비밀번호가 잘못 되었습니다. 다시 확인해 주세요!"); 
                </script>
<%
            }
        } else {
%>
            <script type="text/javascript">
                showLoginError("아이디가 존재하지 않습니다. 다시 확인해 주세요!"); 
            </script>
<%
        }
    }
%>
</body>
</html>
