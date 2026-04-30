<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="java.util.UUID" %>

<%
request.setCharacterEncoding("EUC-KR");

String dbUrl = "jdbc:mysql://localhost:3306/cake";
String dbId = "multi";
String dbPw = "abcd";

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

String uploadPath = application.getRealPath("/onlycake/uploads");
File uploadDir = new File(uploadPath);
if (!uploadDir.exists()) uploadDir.mkdirs();

int reviewIdx = 0;
int prdNo = 0;
String reviewPwd = "";
String reviewText = "";
int rating = 0;
String photoPath = null;
String existingPhotoPath = null;

try {
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);
    if (!isMultipart) {
        throw new Exception("폼 enctype이 multipart/form-data가 아님");
    }

    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setHeaderEncoding("EUC-KR");

    List<FileItem> items = upload.parseRequest(request);
    for (FileItem item : items) {
        if (item.isFormField()) {
            String fieldName = item.getFieldName();
            String value = item.getString("EUC-KR");

            switch (fieldName) {
                case "reviewIdx": reviewIdx = Integer.parseInt(value); break;
                case "prdNo": prdNo = Integer.parseInt(value); break;
                case "reviewPwd": reviewPwd = value; break;
                case "reviewContent": reviewText = value; break;
                case "rating": rating = Integer.parseInt(value); break;
            }
        } else if ("photoUpload".equals(item.getFieldName()) && item.getSize() > 0) {
            String fileName = UUID.randomUUID().toString() + "_" + new File(item.getName()).getName();
            File file = new File(uploadPath, fileName);
            item.write(file);
            photoPath = fileName;
        }
    }

    // DB 연결
    Class.forName("org.gjt.mm.mysql.Driver");
    conn = DriverManager.getConnection(dbUrl, dbId, dbPw);

    // 기존 이미지 가져오기 (이미지 없을 경우 유지하기 위함)
    String selectSql = "SELECT photoPath FROM review WHERE reviewIdx = ? AND reviewPwd = ?";
    pstmt = conn.prepareStatement(selectSql);
    pstmt.setInt(1, reviewIdx);
    pstmt.setString(2, reviewPwd);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        existingPhotoPath = rs.getString("photoPath");
    }
    rs.close();
    pstmt.close();

    if (photoPath == null || photoPath.trim().isEmpty()) {
        photoPath = existingPhotoPath; // 새로 업로드한 이미지 없으면 기존 이미지 유지
    }

    // DB 업데이트
    String updateSql = "UPDATE review SET reviewText=?, rating=?, photoPath=? WHERE reviewIdx=? AND reviewPwd=?";
    pstmt = conn.prepareStatement(updateSql);
    pstmt.setString(1, reviewText);
    pstmt.setInt(2, rating);
    pstmt.setString(3, photoPath);
    pstmt.setInt(4, reviewIdx);
    pstmt.setString(5, reviewPwd);
    
    int updated = pstmt.executeUpdate();

    if (updated > 0) {
%>
    <script>
        alert("리뷰가 성공적으로 수정되었습니다.");
        location.href = "ReviewDetail.jsp?reviewIdx=<%= reviewIdx %>";
    </script>
<%
    } else {
%>
    <script>
        alert("리뷰 수정에 실패했습니다. 비밀번호를 다시 확인해주세요.");
        history.back();
    </script>
<%
    }

} catch (Exception e) {
    out.println("<p>에러 발생: " + e.getMessage() + "</p>");
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
%>
