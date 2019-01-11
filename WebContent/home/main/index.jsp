<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    String uid = request.getParameter("uid");
    User user = new User();
    Mail mail = new Mail();
    if (Utils.isNumeric(uid)) {
    	mail.sayHi(id, uid);
    }
    Map<String, String> data = user.where("id = '" + id + "'").get();
    String avatar = data.get("avatar").equals("") ? "../css/avatar.png" : data.get("avatar");
    int mail_count = mail.getCountByUid(id);
    List<Map> list = user.getUsers(data);
    int size = list.size();
    Map<String, String> item;
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>珍爱网-我的珍爱</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <link rel="shortcut icon" href="../css/favicon.ico">
        <link href="../css/base.css" rel="stylesheet" />
        <link href="../css/index.css" rel="stylesheet" />
    </head>
    <body>
        <div id="app" class="app-body">
            <div class="top-bar overflow-div bg-purple" style="position:fixed;" data-v-74125de8="">
                <div class="CONTAINER primary" data-v-74125de8="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-74125de8="" />
                    <div data-v-74125de8="" class="link-data f-fl">
                        <a href="index.jsp" data-v-74125de8="" class="current-active">我的珍爱</a>
                    </div>
                    <div data-v-74125de8="" class="link-data f-fl"></div>
                    <div class="right-part f-fr part-margin-left" data-v-74125de8="">
                        <div data-v-74125de8="" class="is-login f-cl">
                            <div data-v-74125de8="" class="right-mail f-fl">
                                <div data-v-74125de8="" class="mail-icon">
                                    <a href="mail.jsp"><img data-v-74125de8="" src="../css/message.png"/></a>
                                    <% if (mail_count > 0) { %>
                                        <span data-v-813ab9b4="" class="right-count"><%= mail_count %></span>
                                    <% } %>
                                </div>
                            </div>
                            <div data-v-74125de8="" class="right-me f-fl">
                                <div data-v-74125de8="" class="me-icon" id="user"><a href="logout"><img data-v-74125de8="" src="../css/logout.png"/></a></div>
                            </div>
                        </div>
                        <!---->
                    </div>
                </div>
            </div>
            <div class="CONTAINER f-cl primary" style="padding:100px 0 0 0;margin:0px auto;"></div>
            <div class="CONTAINER f-cl primary" style="margin:20px auto 0;">
                <div class="CONTAINER f-fl" style="width:880px;">
                    <div class="m-recommend" data-v-7b4fded4="">
                        <div class="recommend-title" data-v-7b4fded4="">
                            <span data-v-7b4fded4="">每日推荐<span style="font-size:10px;">(根据您当前的择偶标准，仅显示已上传头像的用户)</span></span>
                            <a href="seek.jsp" class="change f-fr" data-v-7b4fded4="">修改择偶条件</a>
                        </div>
                        <div class="recommend-content f-cl" data-v-7b4fded4="">
                            <% if (size > 0) { %>
                                <% for (int i = 0;i < size;++i) { %>
                                    <% item = list.get(i); %>
                                    <div data-v-7b4fded4="" class="recommend-item f-fl item-bottom-border">
                                        <a href="user.jsp?id=<%= item.get("id") %>" target="_blank">
                                            <img data-v-7b4fded4="" src="<%= item.get("avatar") %>" class="f-fl" />
                                        </a>
                                        <div data-v-7b4fded4="" class="f-fl">
                                            <a href="user.jsp?id=<%= item.get("id") %>" target="_blank">
                                                <div data-v-7b4fded4="" class="f-cl">
                                                    <p data-v-7b4fded4="" class="nickname f-fl"><%= item.get("name") %></p>
                                                    <div data-v-7b4fded4="" class="tags f-fl"></div>
                                                </div>
                                                <p data-v-7b4fded4="" class="condition f-cl">
                                                    <%= Utils.getAgeByBirthday(Long.parseLong(item.get("birthday"))) %>岁  | <%= item.get("height") %>cm | <%= item.get("addr") %>
                                                </p>
                                                <p data-v-7b4fded4="" class="heart-word">
                                                                                                                                                            我正在寻找学历<%=user.edu(Integer.valueOf(item.get("for_edu"))) %>,
                                                                                                                                                            婚姻状况<%=user.marital(Integer.valueOf(item.get("for_marital"))) %>的人
                                                </p>
                                            </a>
                                            <span data-v-7b4fded4="" class="f-cl">
                                                <% if (Utils.isNumeric(item.get("from_uid"))) { %>
                                                    <span data-v-7b4fded4="" class="has-sayhi">打招呼</span>
                                                <% } else { %>
                                                    <a href="index.jsp?uid=<%= item.get("id") %>" data-v-7b4fded4="" class="default-sayhi">打招呼</a>
                                                <% } %>
                                            </span>
                                        </div>
                                    </div>
                                <% } %>
                            <% } %>
                        </div>
                    </div>
                </div>
                <div class="CONTAINER f-fr" style="width:290px;">
                    <div class="m-info" data-v-77726eec="">
                        <div class="m-profile" style="height:140px;" data-v-77726eec="">
                            <div class="profile-top f-cl" data-v-77726eec="">
                                <img src="<%= avatar %>" class="f-fl" data-v-77726eec="" />
                                <div class="profile-box f-fl" data-v-77726eec="">
                                    <p class="nick-name f-fl" data-v-77726eec=""><%= data.get("name") %></p>
                                    <p class="member-id f-cl" data-v-77726eec="">ID:<%= id %></p>
                                    <div class="profile-view" data-v-77726eec="">
                                        <a href="my_base_info.jsp" class="span-purple" data-v-77726eec="">完善资料</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src='../js/jquery-1.8.3.min.js'></script>
    </body>
</html>