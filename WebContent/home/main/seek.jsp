<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    User user = new User();
    Mail mail = new Mail();
    if (request.getMethod().equals("POST")) {    //表单数据提交处理时
    	String for_sex = request.getParameter("for_sex")
    	,      for_marital = request.getParameter("for_marital")
    	,      for_edu = request.getParameter("for_edu")
    	,      min_age = request.getParameter("min_age").equals("") ? "0" : request.getParameter("min_age")
        ,      max_age = request.getParameter("max_age").equals("") ? "0" : request.getParameter("max_age")
        ,      min_height = request.getParameter("min_height").equals("") ? "0" : request.getParameter("min_height")
        ,      max_height = request.getParameter("max_height").equals("") ? "0" : request.getParameter("max_height")
        ,      min_income = request.getParameter("min_income").equals("") ? "0" : request.getParameter("min_income")
        ,      max_income = request.getParameter("max_income").equals("") ? "0" : request.getParameter("max_income")
    	,      err_msg = "";
        if (Integer.valueOf(max_height) > 255) {
        	max_height = "255";
        }
    	if (!for_sex.equals("0") && !for_sex.equals("1") && !for_sex.equals("2")) {
			err_msg = "性别错误";
		} else if (!for_marital.equals("0") && !for_marital.equals("1") && !for_marital.equals("2") && !for_marital.equals("3")) {
			err_msg = "婚姻状况错误";
		} else if (!for_edu.equals("0") && !for_edu.equals("1") && !for_edu.equals("2") && !for_edu.equals("3") && !for_edu.equals("4") && !for_edu.equals("5") && !for_edu.equals("6")) {
			err_msg = "学历错误";
		} else if (Integer.valueOf(min_age) > 100) {
			err_msg = "最小年龄错误";
		} else if (Integer.valueOf(min_height) > 255) {
			err_msg = "最低身高错误";
		} else if (min_income.length() > 10 || max_income.length() > 10) {
			err_msg = "月收入标准过高";
		} else {
			Map<String, String> map = new HashMap();
			map.put("id", id);
			map.put("for_sex", for_sex);
			map.put("for_marital", for_marital);
			map.put("for_edu", for_edu);
			map.put("min_age", min_age);
			map.put("max_age", max_age);
			map.put("min_height", min_height);
			map.put("max_height", max_height);
			map.put("min_income", min_income);
			map.put("max_income", max_income);
			user.modify(map);
		}
    	if (!err_msg.equals("")) {
    		user.close();
    		out.println(err_msg);
    		return;
    	}
    }
    Map<String, String> data = user.where("id = '" + id + "'").get();
    int mail_count = mail.getCountByUid(id);
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>珍爱网-择偶标准</title>
        <link rel="shortcut icon" href="../css/favicon.ico" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <link href="../css/my_base_info.css" rel="stylesheet" />
    </head>
    <body>
        <div id="app" data-v-09c8f4cc="">
            <div class="top-bar overflow-div bg-purple" style="position:fixed;" data-v-813ab9b4="" data-v-09c8f4cc="">
                <div class="CONTAINER primary" data-v-813ab9b4="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-813ab9b4="" />
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
                                <div data-v-813ab9b4="" class="me-icon">
                                    <a href="logout"><img data-v-813ab9b4="" src="../css/logout.png"/></a>
                                </div>
                            </div>
                        </div>
                        <!---->
                    </div>
                </div>
            </div>
            <div class="CONTAINER f-cl f-topIndex primary" style="padding:100px 0 0 0;margin:0px auto 60px;" data-v-09c8f4cc="">
                <div class="CONTAINER f-fl" style="width:250px;" data-v-09c8f4cc="">
                    <div class="USER-INFO-NAV" data-v-8dc533f6="" data-v-09c8f4cc="">
                        <div class="baseInfo" data-v-8dc533f6="">
                            <img src="<%= data.get("avatar").equals("") ? "../css/avatar.png" : Utils.getResourcePath(data.get("avatar")) %>" class="logo" style="width:220px;height:220px;"/>
                            <p class="name" data-v-8dc533f6=""><%= data.get("name") %></p>
                        </div>
                        <div class="nav" data-v-8dc533f6="">
                            <a href="my_base_info.jsp" class="nav-item" data-v-8dc533f6="">个人资料</a>
                            <a href="javascript:;" class="nav-item active" data-v-8dc533f6="">择偶条件</a>
                            <a href="album.jsp" class="nav-item" data-v-8dc533f6="">我的相册</a>
                        </div>
                    </div>
                </div>
                <div class="CONTAINER f-fr" style="width:920px;" data-v-09c8f4cc="">
                    <div class="USER-INFO-FORM" data-v-c94da60e="" data-v-16a2994a="" data-v-09c8f4cc="">
                        <div class="title f-cl" data-v-c94da60e="">择偶条件</div>
                        <div class="content" data-v-c94da60e="">
                            <form method="post" id="form" data-v-16a2994a="" data-v-c94da60e="">
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">性取向</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-16a2994a="">
                                                <input type="radio" name="for_sex" value="0" <%= data.get("for_sex").equals("0") ? "checked" : "" %>/>&nbsp;不限
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-16a2994a="">
                                                <input type="radio" name="for_sex" value="1" <%= data.get("for_sex").equals("1") ? "checked" : "" %>/>&nbsp;男性
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-16a2994a="">
                                                <input type="radio" name="for_sex" value="2" <%= data.get("for_sex").equals("2") ? "checked" : "" %>/>&nbsp;女性
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl"  data-v-16a2994a="">
                                        <div class="label f-fl"  data-v-16a2994a="">学历</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="0" <%= data.get("for_edu").equals("0") ? "checked" : "" %>/>&nbsp;不限
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="1" <%= data.get("for_edu").equals("1") ? "checked" : "" %>/>&nbsp;高中及以下
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="2" <%= data.get("for_edu").equals("2") ? "checked" : "" %>/>&nbsp;中专
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="3" <%= data.get("for_edu").equals("3") ? "checked" : "" %>/>&nbsp;大专
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="4" <%= data.get("for_edu").equals("4") ? "checked" : "" %>/>&nbsp;本科
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="5" <%= data.get("for_edu").equals("5") ? "checked" : "" %>/>&nbsp;硕士
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_edu" value="6" <%= data.get("for_edu").equals("6") ? "checked" : "" %>/>&nbsp;博士
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl"  data-v-16a2994a="">
                                        <div class="label f-fl"  data-v-16a2994a="">婚姻状态</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_marital" value="0" <%= data.get("for_marital").equals("0") ? "checked" : "" %>/>&nbsp;不限
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_marital" value="1" <%= data.get("for_marital").equals("1") ? "checked" : "" %>/>&nbsp;未婚
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_marital" value="2" <%= data.get("for_marital").equals("2") ? "checked" : "" %>/>&nbsp;离婚
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="for_marital" value="3" <%= data.get("for_marital").equals("3") ? "checked" : "" %>/>&nbsp;丧偶
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最小年龄</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="min_age" placeholder="不填写或为0时为不限年龄" maxlength="2" type="number" value="<%= data.get("min_age").equals("0") ? "" : data.get("min_age") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最大年龄</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="max_age" placeholder="不填写或为0时为不限年龄" maxlength="2" type="number" value="<%= data.get("max_age").equals("0") ? "" : data.get("max_age") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最低身高</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="min_height" placeholder="不填写或为0时为不限身高" maxlength="3" type="number" value="<%= data.get("min_height").equals("0") ? "" : data.get("min_height") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最高身高</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="max_height" placeholder="不填写或为0时为不限身高" maxlength="3" type="number" value="<%= data.get("max_height").equals("0") ? "" : data.get("max_height") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最低收入</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="min_income" placeholder="不填写或为0时为不限收入"  maxlength="10" type="number" value="<%= data.get("min_income").equals("0") ? "" : data.get("min_income") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">最高收入</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="max_income" placeholder="不填写或为0时为不限收入"  maxlength="10" type="number" value="<%= data.get("max_income").equals("0") ? "" : data.get("max_income") %>"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="btn-actions-wrapper f-cl" data-v-c94da60e="" data-v-16a2994a="">
                                    <div class="btn-actions" data-v-c94da60e="" data-v-16a2994a="">
                                        <div class="BTN f-fl" style="width:130px;margin-right:10px;" data-v-16a2994a="" data-v-c94da60e="">
                                            <button type="submit" class="BTN-box primary" style="border:none;">保存</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>