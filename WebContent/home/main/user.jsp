<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getParameter("id");
    User user = new User();
    Mail mail = new Mail();
    
    Map<String, String> data = user.where("id = '" + id + "'").get();
    int mail_count = mail.getCountByUid(id);
    user.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>