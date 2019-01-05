<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    User user = new User();
    Mail mail = new Mail();
    Album album = new Album();
    Map data = user.where("id = '" + id + "'").get();
    String avatar = data.get("avatar").equals("") ? "../css/avatar.png" : "";
    int mail_count = mail.getCountByUid(id);
    List photos = album.getPhotosByUid(id);
    Map photo;
    int size = photos.size();
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn"> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>珍爱网-我的相册</title>
        <link rel="shortcut icon" href="../css/favicon.ico" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link href="../css/album.css" rel="stylesheet">
        <style>
            .file-upload-container{position:relative;}
            .file-upload{
                position:absolute;
                top:0;
                left:0;
                opacity:0;
                filter:alpha(opacity=0);
                width:100%;
                height:100%;
            }
        </style>
    </head>
    <body>
        <div id="app" data-v-f806c9bc="">
            <div class="top-bar overflow-div bg-purple" style="position:fixed;" data-v-813ab9b4="" data-v-f806c9bc="">
                <div class="CONTAINER primary" data-v-813ab9b4="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-813ab9b4="">
                    <div class="right-part f-fr part-margin-left" data-v-813ab9b4="">
                        <div data-v-813ab9b4="" class="is-login f-cl">
                            <div data-v-813ab9b4="" class="right-mail f-fl">
                                <div data-v-813ab9b4="" class="mail-icon">
                                    <a href="mail.html"><img data-v-813ab9b4="" src="../css/message.png"/></a>
                                    <% if (mail_count > 0) { %>
                                        <span data-v-813ab9b4="" class="right-count"><%= mail_count %></span>
                                    <% } %>
                                </div>
                            </div>
                            <div data-v-813ab9b4="" class="right-me f-fl">
                                <div data-v-813ab9b4="" class="me-icon">
                                    <a href="logout"><img data-v-813ab9b4="" src="../css/logout.png"/></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="CONTAINER f-cl f-topIndex primary" style="padding:100px 0 0 0;margin:0px auto;" data-v-f806c9bc="">
                <div class="CONTAINER f-fl" style="width:250px;" data-v-f806c9bc="">
                    <div class="USER-INFO-NAV" data-v-8dc533f6="" data-v-f806c9bc="">
                        <div class="baseInfo" data-v-8dc533f6="">
                            <img src="<%= avatar %>" class="logo" style="width:220px;height:220px;"/>
                            <p class="name" data-v-8dc533f6=""><%= data.get("name") %></p>
                        </div>
                        <div class="nav" data-v-8dc533f6="">
                            <a href="my_base_info.jsp" class="nav-item" data-v-8dc533f6="">个人资料</a>
                            <a href="seek.jsp" class="nav-item" data-v-8dc533f6="">择偶条件</a>
                            <a href="javascript:;" class="nav-item active" data-v-8dc533f6="">我的相册</a>
                        </div>
                    </div>
                </div>
                <div class="CONTAINER f-fr" style="width:920px;" data-v-f806c9bc="">
                    <div class="USER-INFO-FORM" data-v-c94da60e="" data-v-33e4e2a4="" data-v-f806c9bc="">
                        <div class="title f-cl" data-v-c94da60e="">我的相册</div>
                        <div class="content" data-v-c94da60e="">
                            <div data-v-33e4e2a4="" data-v-c94da60e="">
                                <div data-v-33e4e2a4="" data-v-c94da60e="" class="m-album-title">
                                    <span data-v-33e4e2a4="" data-v-c94da60e="" class="main-title">我的头像</span>
                                </div>
                                <div data-v-33e4e2a4="" data-v-c94da60e="" class="m-avatar-box f-cl">
                                    <img data-v-33e4e2a4="" data-v-c94da60e="" src="<%= avatar %>" class="f-fl">
                                    <div data-v-33e4e2a4="" class="BTN f-fl" data-v-c94da60e="" style="width: 130px; margin-left: 20px;">
                                        <div class="BTN-box primary file-upload-container">
                                                                                                                                     更换头像
                                            <input class="file-upload" type="file" accept="image/jpeg,image/jpg,image/png,image/gif">
                                        </div>
                                    </div>
                                </div>
                                <div data-v-33e4e2a4="" data-v-c94da60e="" class="m-album-title f-cl">
                                    <span data-v-33e4e2a4="" data-v-c94da60e="" class="main-title">我的相册</span>
                                    <span data-v-33e4e2a4="" data-v-c94da60e="" class="main-content">最多上传 6 张生活照</span>
                                </div>
                                <div data-v-33e4e2a4="" data-v-c94da60e="" class="m-album-box f-cl">
                                    <% 
                                        for (int i = 0;i < size;++i) { 
                                            photo = (Map) photos.get(i);
                                    %>
                                        <div data-v-33e4e2a4="" data-v-c94da60e="" class="album-item f-fl">
                                            <img data-v-33e4e2a4="" data-v-c94da60e="" src="<%= photo.get("path") %>">
                                            <i data-v-33e4e2a4="" data-v-c94da60e="" data-id="<%= photo.get("id") %>"></i>
                                        </div>
                                    <% } %>
                                    <% if (size < 6) { %>
                                    <div data-v-33e4e2a4="" data-v-c94da60e="" class="f-fl">
                                        <span data-v-6de725fd="" data-v-33e4e2a4="" class="upload-box" data-v-c94da60e="">
                                            <div data-v-33e4e2a4="" data-v-6de725fd="" class="upload file-upload-container">
                                                <input class="file-upload" type="file" accept="image/jpeg,image/jpg,image/png,image/gif">
                                            </div>
                                        </span>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src='../js/jquery-1.8.3.min.js'></script>
        <script>
            $(function() {
            	
            });
        </script>
    </body>
</html>