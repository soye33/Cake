<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.io.*, java.util.List" %>
<%-- 
    java.io.*   : 파일 입출력 기능
    java.util.List : 여러 개의 데이터를 순차적으로 저장하고 관리하는 인터페이스
--%>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>

<%
    // 로그인 체크
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // DB 연결 변수 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // DB 정보
    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 변수 초기화
    int questionIdx = -1;
    String questionPwd = null;
    String questionTitle = "";
    String questionText = "";
    String questionCategory = "";
    String questionImage = null; // 기존 이미지 경로 저장
    boolean hasNewImage = false; // 새로운 이미지 업로드 여부

    try {
        // DB 연결
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
    } catch (Exception e) {
%>
    <script>
        alert("DB 연결 오류: <%= e.getMessage()
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r") %>");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
        return;
    }

    // 파일 업로드 처리
    try {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(1024 * 1024 * 50); // 최대 50MB

        List<FileItem> formItems = upload.parseRequest(request);

        if (formItems != null && !formItems.isEmpty()) { // 변경된 조건
            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    // 일반 데이터 처리
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("EUC-KR");

                    if (fieldName.equals("questionIdx")) {
                        questionIdx = Integer.parseInt(fieldValue);
                    } else if (fieldName.equals("questionPwd")) {
                        questionPwd = fieldValue;
                    } else if (fieldName.equals("questionTitle")) {
                        questionTitle = fieldValue;
                    } else if (fieldName.equals("questionText")) {
                        questionText = fieldValue;
                    } else if (fieldName.equals("questionCategory")) {
                        questionCategory = fieldValue;
                    }
                } else {
                    // 파일 처리
                    if (!item.getName().isEmpty()) {
                        String uploadPath = application.getRealPath("/") + "uploads";
                        File uploadDir = new File(uploadPath);
                        if (!uploadDir.exists()) uploadDir.mkdirs(); // 디렉토리 생성

                        String fileName = new File(item.getName()).getName();
                        questionImage = "uploads/" + fileName;

                        String filePath = uploadPath + File.separator + fileName;
                        File storeFile = new File(filePath);
                        item.write(storeFile);
                        hasNewImage = true;
                    }
                }
            }
        }
    } catch (Exception e) {
%>
    <script>
        alert("파일 업로드 오류: <%= e.getMessage()
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r") %>");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
        return;
    }

    // 필수 입력값 검증
    if (questionIdx == -1 || questionPwd == null || questionPwd.trim().isEmpty()) {
%>
    <script>
        alert("잘못된 접근입니다. (필수 값 누락)");
        location.href = "CustomerService_Inquiry.jsp";
    </script>
<%
        return;
    }

    try {
        // 기존 데이터 조회 (비밀번호 검증)
        String sql = "SELECT questionPwd, questionImage FROM question WHERE questionIdx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, questionIdx);
        rs = pstmt.executeQuery();

        String storedPwd = null;
        String existingImage = null;

        if (rs.next()) {
            storedPwd = rs.getString("questionPwd");
            existingImage = rs.getString("questionImage"); // 기존 이미지 경로 저장
        } else {
%>
        <script>
            alert("문의 내역이 존재하지 않습니다.");
            location.href = "CustomerService_Inquiry.jsp";
        </script>
<%
            return;
        }

        // 비밀번호 확인
        if (!storedPwd.equals(questionPwd)) {
%>
        <script>
            alert("비밀번호가 일치하지 않습니다.");
            location.href = "CustomerService_Inquiry.jsp";
        </script>
<%
            return;
        }

        // 기존 이미지 삭제 (새로운 이미지 업로드된 경우)
        if (hasNewImage && existingImage != null && !existingImage.isEmpty()) {
            File oldFile = new File(application.getRealPath("/") + existingImage);
            if (oldFile.exists()) oldFile.delete(); // 기존 이미지 삭제
        }

        // 데이터베이스 업데이트
        sql = "UPDATE question SET questionTitle = ?, questionText = ?, questionCategory = ?, questionImage = ? WHERE questionIdx = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, questionTitle);
        pstmt.setString(2, questionText);
        pstmt.setString(3, questionCategory);
        pstmt.setString(4, (questionImage != null) ? questionImage : existingImage); // 새 이미지 없으면 기존 이미지 유지
        pstmt.setInt(5, questionIdx);

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
        <script>
            alert("문의가 성공적으로 수정되었습니다.");
            location.href = "InsertInquiry_Result.jsp?questionIdx=<%= questionIdx %>";
        </script>
<%
        } else {
%>
        <script>
            alert("문의 수정에 실패했습니다.");
            history.back();
        </script>
<%
        }
    } catch (Exception e) {
%>
    <script>
        alert("오류 발생: <%= e.getMessage()
            .replace("\\", "\\\\")
            .replace("\"", "\\\"")
            .replace("\n", "\\n")
            .replace("\r", "\\r") %>");
    </script>
<%
        e.printStackTrace();
    } finally {
        // 리소스 정리
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
