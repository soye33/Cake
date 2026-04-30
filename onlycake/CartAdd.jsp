<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.io.*, java.sql.*, java.util.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>

<%
    request.setCharacterEncoding("EUC-KR");

    String id = (String) session.getAttribute("sid");
    String memNickname = (String) session.getAttribute("memNickname");

    if (id == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='Login.jsp';</script>");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/cake";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String uploadPath = application.getRealPath("/") + "onlycake/uploads";
    File uploadDir = new File(uploadPath);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    // 변수 초기화
    String prdCakesize = "", prdTaste = "", prdCandle = "", prdCooling = "", prdDeliverydate = "";
    String prdMessage = "", prdName = "", prdDesign = null, prdImage = "";
    int prdSizeprice = 0, prdCandleprice = 0, prdCoolingprice = 0, prdPrice = 0, prdNo = 0;
    String prdFruit = "", prdTopcream = "", prdBottomcream = "", prdLettering = "";
    int prdFruitprice = 0;

    try {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> formItems = upload.parseRequest(request);

        if (formItems != null && !formItems.isEmpty()) {
            for (FileItem item : formItems) {
                if (item.isFormField()) {
                    String field = item.getFieldName();
                    String value = item.getString("EUC-KR").trim();
                    switch (field) {
                        case "prdNo": prdNo = Integer.parseInt(value); break;
                        case "prdCakesize": prdCakesize = value; break;
                        case "prdTaste": prdTaste = value; break;
                        case "prdCandle": prdCandle = value; break;
                        case "prdCooling": prdCooling = value; break;
                        case "prdDeliverydate": prdDeliverydate = value; break;
                        case "prdMessage": prdMessage = value; break;
                        case "prdName": prdName = value; break;
                        case "prdSizeprice": prdSizeprice = Integer.parseInt(value.isEmpty() ? "0" : value); break;
                        case "prdCandleprice": prdCandleprice = Integer.parseInt(value.isEmpty() ? "0" : value); break;
                        case "prdCoolingprice": prdCoolingprice = Integer.parseInt(value.isEmpty() ? "0" : value); break;
                        case "prdPrice": prdPrice = Integer.parseInt(value.isEmpty() ? "0" : value); break;
                        case "prdFruit": prdFruit = value; break;
                        case "prdFruitprice": prdFruitprice = Integer.parseInt(value.isEmpty() ? "0" : value); break;
                        case "prdTopcream": prdTopcream = value; break;
                        case "prdBottomcream": prdBottomcream = value; break;
                        case "prdLettering": prdLettering = value; break;
                        case "prdImage": prdImage = value; break;
                    }
                } else if (!item.getName().isEmpty()) {
                    String fileName = new File(item.getName()).getName();
                    prdDesign = fileName;
                    item.write(new File(uploadPath + File.separator + fileName));
                }
            }
        }

        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 상품 존재 여부 확인
        pstmt = conn.prepareStatement("SELECT prdNo, prdImage, prdPrice FROM cake WHERE prdNo = ?");
        pstmt.setInt(1, prdNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            prdImage = rs.getString("prdImage");
            prdPrice = rs.getInt("prdPrice");
        } else {
            rs.close(); pstmt.close();
            pstmt = conn.prepareStatement("SELECT IFNULL(MAX(prdNo), 0) + 1 FROM cake");
            rs = pstmt.executeQuery();
            if (rs.next()) prdNo = rs.getInt(1);
            rs.close(); pstmt.close();

            pstmt = conn.prepareStatement("INSERT INTO cake(prdNo, prdName, prdPrice, prdImage) VALUES (?, ?, ?, ?)");
            pstmt.setInt(1, prdNo);
            pstmt.setString(2, prdName);
            pstmt.setInt(3, prdPrice);
            pstmt.setString(4, prdImage);
            pstmt.executeUpdate();
            pstmt.close();
        }

        // productDetail 업데이트
        pstmt = conn.prepareStatement(
            "INSERT INTO productDetail (prdNo, prdCakesize, prdSizeprice, prdTaste, prdCandle, prdCandleprice, " +
            "prdCooling, prdCoolingprice, prdDeliverydate, prdDesign, prdMessage, prdFruit, prdFruitprice, prdTopcream, prdBottomcream, prdLettering) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) " +
            "ON DUPLICATE KEY UPDATE prdCakesize=VALUES(prdCakesize), prdSizeprice=VALUES(prdSizeprice), " +
            "prdTaste=VALUES(prdTaste), prdCandle=VALUES(prdCandle), prdCandleprice=VALUES(prdCandleprice), " +
            "prdCooling=VALUES(prdCooling), prdCoolingprice=VALUES(prdCoolingprice), prdDeliverydate=VALUES(prdDeliverydate), " +
            "prdDesign=VALUES(prdDesign), prdMessage=VALUES(prdMessage), prdFruit=VALUES(prdFruit), " +
            "prdFruitprice=VALUES(prdFruitprice), prdTopcream=VALUES(prdTopcream), prdBottomcream=VALUES(prdBottomcream), prdLettering=VALUES(prdLettering)"
        );
        pstmt.setInt(1, prdNo);
        pstmt.setString(2, prdCakesize);
        pstmt.setInt(3, prdSizeprice);
        pstmt.setString(4, prdTaste);
        pstmt.setString(5, prdCandle);
        pstmt.setInt(6, prdCandleprice);
        pstmt.setString(7, prdCooling);
        pstmt.setInt(8, prdCoolingprice);
        pstmt.setString(9, prdDeliverydate);
        pstmt.setString(10, prdDesign);
        pstmt.setString(11, prdMessage);
        pstmt.setString(12, prdFruit);
        pstmt.setInt(13, prdFruitprice);
        pstmt.setString(14, prdTopcream);
        pstmt.setString(15, prdBottomcream);
        pstmt.setString(16, prdLettering);
        pstmt.executeUpdate();
        pstmt.close();

        // cart 중복 검사 (옵션 & 가격까지)
        pstmt = conn.prepareStatement(
            "SELECT ctNo FROM cart WHERE memId = ? AND prdNo = ? AND prdCakesize = ? AND prdTaste = ? AND prdFruit = ? " +
            "AND prdTopcream = ? AND prdBottomcream = ? AND prdCandle = ? AND prdCooling = ? AND prdDeliverydate = ? AND prdLettering = ? " +
            "AND prdSizeprice = ? AND prdFruitprice = ? AND prdCandleprice = ? AND prdCoolingprice = ? AND prdMessage = ?"
        );
        pstmt.setString(1, id);
        pstmt.setInt(2, prdNo);
        pstmt.setString(3, prdCakesize);
        pstmt.setString(4, prdTaste);
        pstmt.setString(5, prdFruit);
        pstmt.setString(6, prdTopcream);
        pstmt.setString(7, prdBottomcream);
        pstmt.setString(8, prdCandle);
        pstmt.setString(9, prdCooling);
        pstmt.setString(10, prdDeliverydate);
        pstmt.setString(11, prdLettering);
        pstmt.setInt(12, prdSizeprice);
        pstmt.setInt(13, prdFruitprice);
        pstmt.setInt(14, prdCandleprice);
        pstmt.setInt(15, prdCoolingprice);
		pstmt.setString(16, prdMessage);

        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 중복일 경우 수량 증가
            String ctNo = rs.getString("ctNo");
            pstmt.close();
            pstmt = conn.prepareStatement("UPDATE cart SET ctQty = ctQty + 1 WHERE ctNo = ?");
            pstmt.setString(1, ctNo);
            pstmt.executeUpdate();
        } else {
            // 새로 장바구니에 추가
            pstmt.close();
            pstmt = conn.prepareStatement(
                "INSERT INTO cart (ctNo, prdNo, ctQty, memId, memNickname, prdCakesize, prdTaste, prdFruit, prdTopcream, prdBottomcream, " +
                "prdCandle, prdCooling, prdDeliverydate, prdLettering, prdSizeprice, prdFruitprice, prdCandleprice, prdCoolingprice, prdDesign, prdMessage) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
            );
            pstmt.setString(1, UUID.randomUUID().toString());
            pstmt.setInt(2, prdNo);
            pstmt.setInt(3, 1);
            pstmt.setString(4, id);
            pstmt.setString(5, memNickname);
            pstmt.setString(6, prdCakesize);
            pstmt.setString(7, prdTaste);
            pstmt.setString(8, prdFruit);
            pstmt.setString(9, prdTopcream);
            pstmt.setString(10, prdBottomcream);
            pstmt.setString(11, prdCandle);
            pstmt.setString(12, prdCooling);
            pstmt.setString(13, prdDeliverydate);
            pstmt.setString(14, prdLettering);
            pstmt.setInt(15, prdSizeprice);
            pstmt.setInt(16, prdFruitprice);
            pstmt.setInt(17, prdCandleprice);
            pstmt.setInt(18, prdCoolingprice);
            pstmt.setString(19, prdDesign);
			pstmt.setString(20, prdMessage);
            pstmt.executeUpdate();
        }

        out.println("<script>alert('장바구니에 추가되었습니다.'); location.href='Cart.jsp';</script>");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p style='color:red;'>에러 발생: " + e.getMessage() + "</p>");
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }
%>
