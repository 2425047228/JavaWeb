<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getParameter("id");
    if (!Utils.isNumeric(id)) {
	    response.sendRedirect("users.jsp");
	    return;
    }
    User user = new User();
    Map<String, String> data = user.fields("name, avatar").where("id = '" + id + "'").get();
    if (data.isEmpty()) {
    	response.sendRedirect("users.jsp");
    	user.close();
	    return;
    }
    String avatar = data.get("avatar").equals("") ? "../static/img/user-avatar.png" : data.get("avatar");
    Album album = new Album();
    String photo_id = request.getParameter("photo_id");
    if (Utils.isNumeric(id)) {
    	album.del(id, photo_id);
    }
    List<Map> photos = album.getPhotosByUid(id);
    int size = photos.size();
    Map<String, String> photo;
    user.close();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>会员图片管理</title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <link rel="shortcut icon" href="../static/css/favicon.ico">
        <link rel="stylesheet" href="../static/css/bootstrap.min.css">
        <link rel="stylesheet" href="../static/css/font-awesome.min.css">
        <link rel="stylesheet" href="../static/css/ionicons.min.css">
        <link rel="stylesheet" href="../static/css/AdminLTE.min.css">
        <link rel="stylesheet" href="../static/css/skin-blue.min.css">
    </head>
    <body>
        <div class="container-fluid content">
            <div class="row">
                <% for (int i = 0;i < size;++i) { %>
                    <% photo = photos.get(i); %>
                    <div class="col-xs-2">
                        <div class="post">
                            <div class="user-block">
                                <img class="img-circle" src="<%= avatar %>">
                                <span class="username">
                                    <a href="javascript:void(0);"><%= data.get("name") %></a>
                                    <a href="photos.jsp?id=<%= id %>&photo_id=<%= photo.get("id") %>" class="pull-right btn-box-tool">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </span>
                                <span class="description"><%= DateUtil.timeStamp2Date(photo.get("upload_time"), "yyyy-MM-dd HH:mm:ss") %></span>
                            </div>
                            <div class="row margin-bottom">
                                <div class="col-xs-12"><img class="img-responsive" src="<%= photo.get("path") %>"></div>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>
    </body>
</html>