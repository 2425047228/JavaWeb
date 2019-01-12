<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    User user = new User();
    List<Map> list = user.order("id desc").getAll();
    int size = list.size();
    Map<String, String> item;
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="../static/css/bootstrap.min.css">
  <link rel="stylesheet" href="../static/css/font-awesome.min.css">
  <link rel="stylesheet" href="../static/css/ionicons.min.css">
  <link rel="stylesheet" href="../static/css/AdminLTE.min.css">
<title>会员信息管理</title>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
        <div class="box">
            <div class="box-header">
              <h3 class="box-title">会员列表</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body no-padding">
              <table class="table table-striped table-c">
                <tbody><tr>
                  <th>id</th>
                  <th>姓名</th>
                  <th>性别</th>
                  <th>年龄</th>
                  <th>身高</th>
                  <th>手机号</th>
                  <th>注册时间</th>
                  <th>操作</th>
                </tr>
                <% for (int i = 0;i < size;++i) { %>
                    <% item = list.get(i); %>
                    <tr>
                      <td><%= item.get("id") %></td>
                      <td>
                          <% if (!item.get("avatar").equals("")) { %>
                              <div><img style="height:60px;width:60px;" src="<%= item.get("avatar") %>"/></div>
                          <% } %>
                          <%= item.get("name") %>
                      </td>
                      <td><%= user.sex(Integer.valueOf(item.get("sex"))) %></td>
                      <td><%= Utils.getAgeByBirthday(Long.parseLong(item.get("birthday"))) %></td>
                      <td><%= item.get("height") %>cm</td>
                      <td><%= item.get("phone") %></td>
                      <td><%= DateUtil.timeStamp2Date(item.get("reg_time"), "yyyy-MM-dd HH:mm:ss") %></td>
                      <td>
                          <a href="edit.jsp?id=<%= item.get("id") %>" class="btn btn-primary btn-sm">编辑</a>
                          <a href="photos.jsp?id=<%= item.get("id") %>" class="btn btn-info btn-sm">管理照片</a>
                      </td>
                    </tr>
                <% } %>
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
        </div>
    </div>
</div>
        
</body>
</html>