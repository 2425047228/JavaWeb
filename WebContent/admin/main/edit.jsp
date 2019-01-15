<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getParameter("id");
    if (!Utils.isNumeric(id)) {
    	response.sendRedirect("users.jsp");
    	return;
    }
    User user = new User();
    if (request.getMethod().equals("POST")) {
    	String name = Utils.iso2utf8(request.getParameter("name"))
    	,      sex = request.getParameter("sex")
    	,      addr = Utils.iso2utf8(request.getParameter("addr"))
    	,      marital = request.getParameter("marital")
    	,      edu = request.getParameter("edu")
    	,      msg = "";
    	long birthday = DateUtil.date2TimeStamp(request.getParameter("birthday"), "yyyy-MM-dd");
    	int height =Integer.parseInt(request.getParameter("height"));
    	int income = Integer.parseInt(request.getParameter("income"));
    	if (name.equals("") || name.length() > 8) {
    	    msg = "姓名格式错误";
    	} else if (!sex.equals("1") && !sex.equals("2")) {
    		msg = "性别错误";
    	} else if (birthday < 1) {
    		msg = "生日错误";
    	} else if (!marital.equals("1") && !marital.equals("2") && !marital.equals("3")) {
    		msg = "婚姻状况错误";
    	} else if (height < 50) {
    		msg = "身高错误";
    	} else if (height > 255) {
    		height = 255;
    	} else if (!edu.equals("1") && !edu.equals("2") && !edu.equals("3") && !edu.equals("4") && !edu.equals("5") && !edu.equals("6")) {
    		msg = "学历错误";
    	} else if (income > 999999999) {
    		income = 1000000000;
    	} else if (income < 0) {
    		msg = "月收入错误";
    	}
    	if (msg.length() > 0) {
    		out.println(msg);
    		return;
    	} else {
    		Map<String, String> map = new HashMap();
    		map.put("id", id);
			map.put("name", name);
			map.put("sex", sex);
			map.put("addr", addr);
			map.put("marital", marital);
			map.put("edu", edu);
			map.put("birthday", String.valueOf(birthday));
			map.put("height", String.valueOf(height));
			map.put("income", String.valueOf(income));
			user.modify(map);
    	}
    					
    }
    
    Map<String, String> data;
    data = user.getById(id);
    user.close();
    if (data.isEmpty()) {
    	response.sendRedirect("users.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>维护用户信息</title>
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
        <div class="col-xs-12">
            <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">用户 <b><%= data.get("name") %></b> 个人信息维护</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form method="post" class="form-horizontal">
              <input type="hidden" name="id" value="<%= data.get("id") %>"/>
              <div class="box-body">
                <div class="form-group">
                  <label for="name" class="col-sm-2 control-label">姓名</label>
                  <div class="col-sm-10">
                    <input type="text" maxlength="8" class="form-control" id="name" name="name" value="<%= data.get("name") %>" required>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">性别</label>
                  <div class="col-sm-10">
                    <input type="radio" value="1" name="sex" <%= data.get("sex").equals("1") ? "checked" : "" %>> 男
                    &emsp;<input type="radio" value="2" name="sex" <%= data.get("sex").equals("2") ? "checked" : "" %>> 女
                  </div>
                </div>
                <div class="form-group">
                  <label for="height" class="col-sm-2 control-label">身高</label>
                  <div class="col-sm-10">
                    <input type="number" maxlength="3" max="255" class="form-control" id="height" name="height" value="<%= data.get("height") %>" required>
                  </div>
                </div>
                <div class="form-group">
                  <label for="birthday" class="col-sm-2 control-label">生日</label>
                  <div class="col-sm-10">
                    <input type="date" class="form-control" id="birthday" name="birthday" value="<%= DateUtil.timeStamp2Date(data.get("birthday"), null) %>" required>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">学历</label>
                  <div class="col-sm-10">
                    <input type="radio" name="edu" value="1" <%= data.get("edu").equals("1") ? "checked" : "" %>/>&nbsp;高中及以下
                    &emsp;<input type="radio" name="edu" value="2" <%= data.get("edu").equals("2") ? "checked" : "" %>/>&nbsp;中专
                    &emsp;<input type="radio" name="edu" value="3" <%= data.get("edu").equals("3") ? "checked" : "" %>/>&nbsp;大专
                    &emsp;<input type="radio" name="edu" value="4" <%= data.get("edu").equals("4") ? "checked" : "" %>/>&nbsp;本科
                    &emsp;<input type="radio" name="edu" value="5" <%= data.get("edu").equals("5") ? "checked" : "" %>/>&nbsp;硕士
                    &emsp;<input type="radio" name="edu" value="6" <%= data.get("edu").equals("6") ? "checked" : "" %>/>&nbsp;博士
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">婚姻状态</label>
                  <div class="col-sm-10">
                    <input type="radio" name="marital" value="1" <%= data.get("marital").equals("1") ? "checked" : "" %>/>&nbsp;未婚
                    &emsp;<input type="radio" name="marital" value="2" <%= data.get("marital").equals("2") ? "checked" : "" %>/>&nbsp;离婚
                    &emsp;<input type="radio" name="marital" value="3" <%= data.get("marital").equals("3") ? "checked" : "" %>/>&nbsp;丧偶
                  </div>
                </div>
                <div class="form-group">
                  <label for="income" class="col-sm-2 control-label">月收入</label>
                  <div class="col-sm-10">
                    <input type="number" maxlength="10" class="form-control" id="income" name="income" value="<%= data.get("income") %>" required>
                  </div>
                </div>
                <div class="form-group">
                  <label for="addr" class="col-sm-2 control-label">所在地</label>
                  <div class="col-sm-10">
                    <input type="text" maxlength="100" class="form-control" id="addr" name="addr" value="<%= data.get("addr") %>" required>
                  </div>
                </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <a href="users.jsp" class="btn btn-default">取消</a>
                <button type="submit" class="btn btn-info pull-right">保存</button>
              </div>
              <!-- /.box-footer -->
            </form>
          </div>
        </div>
    </div>
</div>
</body>
</html>