<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    String mail_id = request.getParameter("mail_id");
    User user = new User();
    Mail mail = new Mail();
    if (Utils.isNumeric(mail_id)) {
    	String del = request.getParameter("del");
    	if (null != del && !del.equals("")) {
    		mail.del(mail_id, id);
    	} else {
    		mail.read(mail_id, id);
    	}
    }

    List<Map> mails = mail.getMails(id);
    Map<String, String> data = user.where("id = '" + id + "'").get();
    String avatar = data.get("avatar").equals("") ? "../css/avatar.png" : data.get("avatar");
    int mail_count = mail.getCountByUid(id);
    int size = mails.size();
    Map<String, String> item;
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>消息列表</title>
        <link rel="shortcut icon" href="../css/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <link href="../css/mail.css" rel="stylesheet">
    </head>
    <body>
        <div id="app" data-v-24cd0f9c="">
            <div class="top-bar overflow-div bg-purple" style="position:fixed;" data-v-813ab9b4="" data-v-24cd0f9c="">
                <div class="CONTAINER primary" data-v-813ab9b4="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-813ab9b4="">
                    <div data-v-813ab9b4="" class="link-data f-fl">
                        <a href="index.jsp" data-v-813ab9b4="">我的珍爱</a>
                    </div>
                    <div class="right-part f-fr part-margin-left" data-v-813ab9b4="">
                        <div data-v-813ab9b4="" class="is-login f-cl">
                            <div data-v-813ab9b4="" class="right-mail f-fl">
                                <div data-v-813ab9b4="" class="mail-icon">
                                    <a href="mail.jsp"><img data-v-813ab9b4="" src="../css/message.png"/></a>
                                    <% if (mail_count > 0) { %>
                                        <span data-v-813ab9b4="" class="right-count"><%= mail_count %></span>
                                    <% } %>
                                </div>
                            </div>
                            <div data-v-813ab9b4="" class="right-me f-fl">
                                <div data-v-813ab9b4="" class="me-icon" id="user"><a href="logout"><img data-v-813ab9b4="" src="../css/logout.png"/></a></div>
                            </div>
                        </div>
                     </div>
                </div>
            </div>
            <div class="CONTAINER f-cl f-topIndex primary" style="padding:100px 0 0 0;margin:0px auto 0;" data-v-24cd0f9c="">
                <div class="CONTAINER primary" data-v-24cd0f9c="">
                    <div class="CONTAINER f-fl" style="width:880px;margin:0 30px 0 0;" data-v-24cd0f9c="">
                        <div data-v-e6779e36="" data-v-49b0a9d4="" data-v-24cd0f9c="" class="Message-box">
                            <div data-v-e6779e36="" class="Title f-cl">
                                <span data-v-e6779e36="">消息中心</span></div>
                            <div data-v-e6779e36="" class="Content">
                                <div data-v-49b0a9d4="" data-v-e6779e36="" class="content">
                                    <div data-v-49b0a9d4="" class="Tabs" data-v-e6779e36="">
                                        <div data-v-ccf50200="" data-v-49b0a9d4="" class="message-list" style="">
                                            <div data-v-ccf50200="">
                                                <ul data-v-ccf50200="" class="mail-ul">
                                                    <% for (int i = 0;i < size;++i) { %>
                                                        <% item = mails.get(i); %>
                                                        <li data-v-ccf50200="" class="mail-li">
                                                            <a data-v-ccf50200="" target="_blank" class="f-fl" href="user.jsp?id=<%= item.get("id") %>">
                                                                <div 
                                                                    data-v-ccf50200="" 
                                                                    class="avatar f-fl" 
                                                                    style="background-image:url(<%= item.get("avatar").equals("") ? "../css/avatar.png" : item.get("avatar") %>);"
                                                                ></div>
                                                                <div data-v-ccf50200="" class="info f-fl">
                                                                    <div data-v-ccf50200="" class="name">
                                                                        <div data-v-ccf50200="" class="nickname"><%= item.get("name") %></div>
                                                                    </div>
                                                                    <div 
                                                                        data-v-ccf50200="" 
                                                                        class="show-content"
                                                                    ><%= Utils.getAgeByBirthday(Long.parseLong(item.get("birthday"))) %>岁 | <%= user.edu(Integer.valueOf(item.get("edu"))) %></div>
                                                                    <div data-v-ccf50200="" class="time"><%= DateUtil.timeStamp2Date(item.get("send_time"), "yyyy年MM月dd日") %></div>
                                                                </div>
                                                            </a>
                                                            <% if (item.get("status").equals("1")) { %>
                                                                <div data-v-ccf50200="" class="tips f-fl">未读</div>
                                                                <div data-v-ccf50200="" class="BTN unread f-fl" style="width: 100px; margin-top: 25px;">
                                                                    <a href="mail.jsp?mail_id=<%= item.get("mail_id") %>" class="BTN-box primary" style="display:block;height: 36px; line-height: 36px;">已读</a>
                                                                </div>
                                                            <% } %>
                                                            <a href="mail.jsp?del=1&mail_id=<%= item.get("mail_id") %>">
                                                                <img data-v-ccf50200="" src="../css/delete.269ecca.png" class="delete">
                                                            </a>
                                                        </li>
                                                    <% } %>
                                                </ul>
                                            </div>
                                        </div>
                                   
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="CONTAINER f-fl" style="width:290px;" data-v-24cd0f9c="">
                        <div data-v-271df60e="" data-v-24cd0f9c="" class="Info">
                            <div data-v-271df60e="" class="Avatar">
                                <div data-v-271df60e="" style="background-image: url(<%= avatar %>);"></div>
                            </div>
                            <div data-v-271df60e="" class="Nickname"><%= data.get("name") %></div>
                            <div data-v-271df60e="" class="Box">
                                <div data-v-271df60e="" class="List">
                                    <span data-v-271df60e="" class="Text f-fl">消息</span>
                                    <span data-v-271df60e="" class="Counts Counts-color f-fr"><%= size %></span>
                                    <span data-v-271df60e="" class="New f-fr"><%= mail_count %>未读</span>
                                </div>
                                <div class="List" data-v-271df60e="">
                                    <a href="my_base_info.jsp" class="New f-fr" style="color:#8b76f9" data-v-271df60e="">完善资料</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>



    </body>

</html>