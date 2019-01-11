<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getParameter("id");
    if (!Utils.isNumeric(id)) {
    	response.sendRedirect("index.jsp");
    	return;
    }
    User user = new User();
    Map<String, String> data = user.where("id = '" + id + "'").get();
    if (data.isEmpty()) {
    	response.sendRedirect("index.jsp");
    	return;
    }
    String avatar = data.get("avatar").equals("") ? "../css/avatar.png" : data.get("avatar");
    int age = Utils.getAgeByBirthday( Long.parseLong( data.get("birthday") ) );
    String edu = user.edu( Integer.valueOf( data.get("edu") ) );
    String marital = user.marital( Integer.valueOf( data.get("marital") ) );
    
    Album album = new Album();
    List<Map> photos = album.getPhotosByUid(id);
    int size = photos.size();
    Map<String, String> photo;
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn">
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= data.get("name") %>的照片资料</title>
        <link href="../css/favicon.ico" rel="shortcut icon">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link href="../css/user.css" rel="stylesheet">
    </head>
    
    <body class=" ">
        <div id="app">
            <div class="top-bar overflow-div bg-transparent" style="position:absolute;" data-v-813ab9b4="">
                <div class="CONTAINER primary" data-v-813ab9b4="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-813ab9b4="">
                </div>
            </div>
            <div>
                <div class="m-gap" data-v-0af9a42e=""></div>
                <div class="CONTAINER f-cl f-topIndex primary" style="margin:-215px auto 0;">
                    <div class="CONTAINER f-fl" style="width:880px;">
                        <div class="m-userInfo" data-v-5b109fc3="">
                            <div class="top f-cl" data-v-5b109fc3="">
                                <div class="logo f-fl" style="background-image:url(<%= avatar %>);" data-v-5b109fc3=""></div>
                                <div class="right f-fl" data-v-5b109fc3="">
                                    <div class="info" data-v-5b109fc3="">
                                        <div class="name" data-v-5b109fc3=""><h1 class="nickName" data-v-5b109fc3=""><%= data.get("name") %></h1></div>
                                        <div class="id" data-v-5b109fc3="">ID：<%= data.get("id") %></div>
                                        <div data-v-5b109fc3="" class="des f-cl">
                                            <%= data.get("addr") %> | 
                                            <%= age %>岁 | 
                                            <%= edu %> | 
                                            <%= marital %> | 
                                            <%= data.get("height") %>cm | 月收入<%= data.get("income") %>元
                                        </div>
                                    </div>
                                    <div data-v-5b109fc3="" class="m-photos">
                                        <div data-v-5b109fc3="" class="photoWrapper">
                                            <div data-v-5b109fc3="" class="photoBox">
                                                <% for (int i = 0;i < size;++i) { %>
                                                    <% photo = photos.get(i); %>
                                                    <a href="<%= photo.get("path") %>" target="_blank" data-v-5b109fc3="" class="photoItem z-cursor-big active">
                                                        <img data-v-5b109fc3="" src="<%= photo.get("path") %>">
                                                        <div data-v-5b109fc3="" class="num"><%= i + 1 %>/<%= size %></div>
                                                    </a>
                                                <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="CONTAINER" style="width:100%;margin:20px auto 0;">
                            <div class="m-userInfoDetail" data-v-bff6f798="">
                                <div class="m-title" data-v-bff6f798="">个人资料</div>
                                <div class="m-content-box" data-v-bff6f798="">
                                    <div class="purple-btns" data-v-bff6f798="">
                                        <div class="m-btn purple" data-v-bff6f798=""><%= user.marital(Integer.valueOf(data.get("marital"))) %></div>
                                        <div class="m-btn purple" data-v-bff6f798=""><%= age %>岁</div>
                                        <div class="m-btn purple" data-v-bff6f798=""><%= data.get("height") %>cm</div>
                                        <div class="m-btn purple" data-v-bff6f798=""><%= edu %></div>
                                        <div class="m-btn purple" data-v-bff6f798="">所在地:<%= data.get("addr") %></div>
                                        <div class="m-btn purple" data-v-bff6f798="">月收入:<%= data.get("income") %></div>
                                    </div>
                                </div>
                                <div class="m-title" data-v-bff6f798="">择偶条件</div>
                                <div class="m-content-box" data-v-bff6f798="">
                                    <div class="gray-btns" data-v-bff6f798="">
                                        <div class="m-btn" data-v-bff6f798="">性取向:<%= user.sex(Integer.valueOf(data.get("for_sex"))) %></div>
                                        <div class="m-btn" data-v-bff6f798="">学历:<%= user.edu(Integer.valueOf(data.get("for_edu"))) %></div>
                                        <div class="m-btn" data-v-bff6f798="">婚姻状况:<%= user.marital(Integer.valueOf(data.get("for_marital"))) %></div>
                                        <div class="m-btn" data-v-bff6f798="">年龄:<%= user.forAge(data.get("min_age"), data.get("max_age")) %></div>
                                        <div class="m-btn" data-v-bff6f798="">身高:<%= user.forHeight(data.get("min_height"), data.get("max_height")) %></div>
                                        <div class="m-btn" data-v-bff6f798="">月收入:<%= user.forIncome(data.get("min_income"), data.get("max_income")) %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>