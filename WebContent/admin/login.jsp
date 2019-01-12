<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils,com.love.util.JWT" %>
<%
    String msg = "登陆";
    if (request.getMethod().equals("POST")) {
    	String account = request.getParameter("account");
    	String pwd = request.getParameter("pwd");
    	if (account.length() > 0) {
    		if (pwd.length() > 0) {
    			Admin admin = new Admin();
    			String id = admin.sign(account, pwd);
    			if (Utils.isNumeric(id)) {
    				long hours = DateUtil.hours(24);
    				String token = JWT.create(id, hours);
    				Cookie cookie = new Cookie("admin_token", token);
    				cookie.setPath("/");
    				cookie.setMaxAge((int) hours);
    				response.addCookie(cookie);
    				response.sendRedirect("main/index.jsp");
    			} else {
    				msg = "<span style='color:red'>用户名或密码错误</span>";
    			}
    		} else {
    			msg = "<span style='color:red'>密码格式不正确</span>";
    		}
    	} else {
    		msg = "<span style='color:red'>账号格式不正确</span>";
    	}
    }

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>珍爱网后台登陆</title>
  <link rel="shortcut icon" href="static/css/favicon.ico"> 
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="stylesheet" href="static/css/bootstrap.min.css">
  <link rel="stylesheet" href="static/css/font-awesome.min.css">
  <link rel="stylesheet" href="static/css/ionicons.min.css">
  <link rel="stylesheet" href="static/css/AdminLTE.min.css">
  <link rel="stylesheet" href="static/plugins/iCheck/square/blue.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
  <div class="login-logo">
    <span><b>珍爱网</b>管理后台</span>
  </div>
  <div class="login-box-body">
    <p class="login-box-msg"><%= msg %></p>
    <form method="post">
      <div class="form-group has-feedback">
        <input type="number" name="account" maxlength="11" class="form-control" placeholder="账号" required/>
        <span class="glyphicon glyphicon-phone form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" name="pwd" class="form-control" placeholder="密码" required/>
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-8"></div>
        <div class="col-xs-4">
          <button type="submit" class="btn btn-primary btn-block btn-flat">登陆</button>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>
