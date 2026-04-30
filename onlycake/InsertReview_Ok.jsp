<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*, java.io.*, java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>

<%
    request.setCharacterEncoding("EUC-KR");

    String memNickname = (String) session.getAttribute("memNickname");
    if (memNickname == null || memNickname.isEmpty()) {
%>
    <script>
        alert("로그인이 필요합니다.");
        location.href = "Login.jsp";
    </script>
<%
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PW = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    //  실제 uploads 폴더 경로
    String uploadPath = application.getRealPath("/onlycake/uploads");  // ← 이게 핵심!
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    int prdNo = 0;
    int rating = 0;
    String ordNo = "";
    String reviewText = "";
    String reviewPwd = "";
    String photoPath = "";

    try {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setSizeMax(10 * 1024 * 1024); // 10MB 제한

        List<FileItem> formItems = upload.parseRequest(request);

        for (FileItem item : formItems) {
            if (item.isFormField()) {
                String fieldName = item.getFieldName();
                String fieldValue = item.getString("EUC-KR");

                switch (fieldName) {
                    case "prdNo":
                        prdNo = Integer.parseInt(fieldValue);
                        break;
                    case "rating":
                        rating = Integer.parseInt(fieldValue);
                        break;
                    case "reviewContent":
                        reviewText = fieldValue;
                        break;
                    case "reviewPwd":
                        reviewPwd = fieldValue;
                        break;
                    case "ordNo":
                        if (fieldValue != null && !fieldValue.trim().isEmpty()) {
                            ordNo = fieldValue.trim();  // ordNo는 문자열로 처리
                        }
                        break;
                }
            } else {
                // 파일 업로드 처리
                if (!item.getName().isEmpty()) {
                    String fileName = new File(item.getName()).getName();

                    // UUID로 이름 중복 방지
                    String ext = fileName.substring(fileName.lastIndexOf("."));
                    String base = fileName.substring(0, fileName.lastIndexOf("."));
                    String newFileName = base + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
                    photoPath = newFileName;

                    File storeFile = new File(uploadPath + File.separator + newFileName);
                    System.out.println("저장 경로: " + storeFile.getAbsolutePath());

                    try {
                        item.write(storeFile);
                        System.out.println("파일 저장 완료: " + photoPath);
                    } catch (Exception ex) {
                        System.out.println("파일 저장 실패: " + ex.getMessage());
                        ex.printStackTrace();
                    }
                }
            }
        }

        // DB 저장
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PW);

        String sql = "INSERT INTO review (prdNo, memNickname, rating, reviewText, photoPath, reviewPwd, reviewCount, ordNo) " +
                     "VALUES (?, ?, ?, ?, ?, ?, 0, ?)";
        pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setInt(1, prdNo);
        pstmt.setString(2, memNickname);
        pstmt.setInt(3, rating);
        pstmt.setString(4, reviewText);
        pstmt.setString(5, photoPath);
        pstmt.setString(6, reviewPwd);
        pstmt.setString(7, ordNo);

        int result = pstmt.executeUpdate();

        int reviewIdx = 0;
        if (result > 0) {
            ResultSet rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                reviewIdx = rs.getInt(1);
            }
            rs.close();
%>
    <script>
        alert("후기가 성공적으로 등록되었습니다!");
        location.href = "ReviewDetail.jsp?reviewIdx=<%= reviewIdx %>";
    </script>
<%
        } else {
%>
    <div style="margin: 30px; padding: 20px; border: 2px solid orange; background-color: #fff8e1; font-family: monospace;">
        <h3 style="color: orange;">후기 등록에 실패했습니다</h3>
        <p>입력값을 다시 확인해주세요.</p>
    </div>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String stackTrace = sw.toString();
%>
    <div style="margin: 30px; padding: 20px; border: 2px solid red; background-color: #fff0f0; font-family: monospace;">
        <h3 style="color: red;">오류가 발생했습니다</h3>
        <pre><%= stackTrace %></pre>
    </div>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
