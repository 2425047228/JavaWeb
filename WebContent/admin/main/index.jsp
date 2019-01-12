<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    String logout = request.getParameter("logout");
    if (Utils.isNumeric(logout)) {
    	Cookie cookie = new Cookie("admin_token", null);
		cookie.setPath("/");
		cookie.setMaxAge(1);
		response.addCookie(cookie);
		response.sendRedirect("../login.jsp");
		return;
    }
    Admin admin = new Admin();
    Map<String, String> data = admin.getAdminById(id);
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>珍爱网管理后台</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <link rel="shortcut icon" href="../static/css/favicon.ico"> 
  <link rel="stylesheet" href="../static/css/bootstrap.min.css">
  <link rel="stylesheet" href="../static/css/font-awesome.min.css">
  <link rel="stylesheet" href="../static/css/ionicons.min.css">
  <link rel="stylesheet" href="../static/css/AdminLTE.min.css">
  <link rel="stylesheet" href="../static/css/skin-blue.min.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="index.jsp" class="logo">
      <span class="logo-mini"><b>爱</b></span>
      <span class="logo-lg"><b>珍爱网</b></span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="../static/img/avatar.png" class="user-image" alt="User Image">
              <span class="hidden-xs"><%= data.get("name") %></span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="../static/img/avatar.png" class="img-circle" alt="User Image">
                <p><%= data.get("name") %></p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-right">
                  <a href="index.jsp?logout=1" class="btn btn-default btn-flat">退出登陆</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="../static/img/avatar.png" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p><%= data.get("name") %></p>
          <a href="#"><i class="fa fa-circle text-success"></i> 在线</a>
        </div>
      </div>
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
          <li class="redirect active" data-href="default.jsp">
              <a><i class="fa fa-home"></i> <span>首页</span></a>
          </li>
          <li class="redirect" data-href="users.jsp">
              <a><i class="fa fa-user"></i> <span>会员信息管理</span></a>
          </li>
          <li class="redirect" data-href="statistics.jsp">
              <a><i class="fa  fa-pie-chart"></i> <span>会员信息统计</span></a>
          </li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" id="iframe-container">
      <iframe id="iframe" src="default.jsp" height="100%" width="100%" frameborder=0></iframe>
  </div>
</div>

<script src="../static/js/jquery.min.js"></script>
<script src="../static/js/bootstrap.min.js"></script>
<script src="../static/js/adminlte.min.js"></script>
<script>
    $(function () {
    	$('.redirect').click(function () {
    		$('.redirect').each(function() {
    			$(this).removeClass('active');
    		});
    		$(this).addClass('active');
    		$('#iframe').attr('src', $(this).attr('data-href'));
    	});
    	$('#iframe').attr('height', document.getElementById("iframe-container").scrollHeight + 'px');
    });
</script>
</body>
</html>
