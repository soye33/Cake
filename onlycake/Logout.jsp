<%@ page contentType="text/html; charset=euc-kr" %>
<%
    session.invalidate();    //  세션설정을 무효화시킴
    response.sendRedirect("Main.jsp");     
%>