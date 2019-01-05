<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    String id = request.getAttribute("id").toString();
    User user = new User();
    Mail mail = new Mail();
    if (request.getMethod().equals("POST")) {    //表单数据提交处理时
    	String name = Utils.iso2utf8(request.getParameter("name"))
    	,      sex = request.getParameter("sex")
    	,      addr = Utils.iso2utf8(request.getParameter("addr"))
    	,      marital = request.getParameter("marital")
    	,      edu = request.getParameter("edu")
    	,      phone = request.getParameter("phone")
    	,      pwd = request.getParameter("pwd")
    	,      err_msg = "";
    	long birthday = DateUtil.date2TimeStamp(request.getParameter("birthday"), "yyyy-MM-dd");
    	int height =Integer.parseInt(request.getParameter("height"));
    	int income = Integer.parseInt(request.getParameter("income"));
    	if (name.equals("") || name.length() > 8) {
    		err_msg = "姓名格式错误";
		} else if (!sex.equals("1") && !sex.equals("2")) {
			err_msg = "性别错误";
		} else if (0 == birthday) {
			err_msg = "生日错误";
		} else if (!marital.equals("1") && !marital.equals("2") && !marital.equals("3")) {
			err_msg = "婚姻状况错误";
		} else if (height < 50) {
			err_msg = "身高错误";
		} else if (height > 255) {
			height = 255;
		} else if (!edu.equals("1") && !edu.equals("2") && !edu.equals("3") && !edu.equals("4") && !edu.equals("5") && !edu.equals("6")) {
			err_msg = "学历错误";
		} else if (income > 999999999) {
			income = 1000000000;
		} else if (income < 0) {
			err_msg = "月收入错误";
		} else if (phone.length() != 11 || !Utils.isNumeric(phone)) {
			err_msg = "手机号格式错误";
		} else {
			Map<String, String> map = new HashMap();
			map.put("id", id);
			map.put("name", name);
			map.put("sex", sex);
			map.put("addr", addr);
			map.put("marital", marital);
			map.put("edu", edu);
			map.put("phone", phone);
			map.put("pwd", pwd);
			map.put("birthday", String.valueOf(birthday));
			map.put("height", String.valueOf(height));
			map.put("income", String.valueOf(income));
			user.modify(map);
		}
    	if (!err_msg.equals("")) {
    		user.close();
    		out.println(err_msg);
    		return;
    	}
    }
    Map data = user.where("id = '" + id + "'").get();
    int mail_count = mail.getCountByUid(id);
    user.close();
%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>珍爱网-我的资料</title>
        <link rel="shortcut icon" href="../css/favicon.ico" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <link href="../css/my_base_info.css" rel="stylesheet" />
    </head>
    <body>
        <div id="app" data-v-09c8f4cc="">
            <div class="top-bar overflow-div bg-purple" style="position:fixed;" data-v-813ab9b4="" data-v-09c8f4cc="">
                <div class="CONTAINER primary" data-v-813ab9b4="">
                    <img src="../css/logo.28b54ad-2.png" class="f-fl" data-v-813ab9b4="" />
                    <div class="right-part f-fr part-margin-left" data-v-813ab9b4="">
                        <div data-v-813ab9b4="" class="is-login f-cl">
                            <div data-v-813ab9b4="" class="right-mail f-fl">
                                <div data-v-813ab9b4="" class="mail-icon">
                                    <a href="mail.html"><img data-v-813ab9b4="" src="../css/message.png"/></a>
                                    <%= mail_count > 0 ? "<span data-v-813ab9b4=\"\" class=\"right-count\">" + mail_count + "</span>" : "" %>
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
                            <img src="<%= data.get("avatar").equals("") ? "../css/avatar.png" : "" %>" class="logo" style="width:220px;height:220px;"/>
                            <p class="name" data-v-8dc533f6=""><%= data.get("name") %></p>
                        </div>
                        <div class="nav" data-v-8dc533f6="">
                            <a href="javascript:;" class="nav-item active" data-v-8dc533f6="">个人资料</a>
                            <a href="seek.jsp" class="nav-item" data-v-8dc533f6="">择偶条件</a>
                            <a href="album.jsp" class="nav-item" data-v-8dc533f6="">我的相册</a>
                        </div>
                    </div>
                </div>
                <div class="CONTAINER f-fr" style="width:920px;" data-v-09c8f4cc="">
                    <div class="USER-INFO-FORM" data-v-c94da60e="" data-v-16a2994a="" data-v-09c8f4cc="">
                        <div class="title f-cl" data-v-c94da60e="">基本资料</div>
                        <div class="content" data-v-c94da60e="">
                            <form method="post" id="form" data-v-16a2994a="" data-v-c94da60e="">
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">姓名</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="name" maxlength="8" placeholder="您的姓名" type="text" value="<%= data.get("name") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl"  data-v-16a2994a="">
                                        <div class="label f-fl"  data-v-16a2994a="">性别</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-16a2994a="">
                                                <input type="radio" name="sex" value="1" <%= data.get("sex").equals("1") ? "checked" : "" %>/>&nbsp;男士
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-16a2994a="">
                                                <input type="radio" name="sex" value="2" <%= data.get("sex").equals("2") ? "checked" : "" %>/>&nbsp;女士
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">生日</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="birthday" placeholder="您的生日" type="date" value="<%= DateUtil.timeStamp2Date((String) data.get("birthday"), "yyyy-MM-dd") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">工作城市</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="addr" placeholder="当前工作所在的城市" maxlength="20" type="text" value="<%= data.get("addr") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl"  data-v-16a2994a="">
                                        <div class="label f-fl"  data-v-16a2994a="">婚姻状态</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="marital" value="1" <%= data.get("marital").equals("1") ? "checked" : "" %>/>&nbsp;未婚
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="marital" value="2" <%= data.get("marital").equals("2") ? "checked" : "" %>/>&nbsp;离婚
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="marital" value="3" <%= data.get("marital").equals("3") ? "checked" : "" %>/>&nbsp;丧偶
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">身高</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="height" placeholder="单位：cm" maxlength="3" type="number" value="<%= data.get("height") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl"  data-v-16a2994a="">
                                        <div class="label f-fl"  data-v-16a2994a="">学历</div>
                                        <div class="f-fl ZA-FORM-ITEM"  data-v-16a2994a="">
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="1" <%= data.get("edu").equals("1") ? "checked" : "" %>/>&nbsp;高中及以下
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="2" <%= data.get("edu").equals("2") ? "checked" : "" %>/>&nbsp;中专
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="3" <%= data.get("edu").equals("3") ? "checked" : "" %>/>&nbsp;大专
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="4" <%= data.get("edu").equals("4") ? "checked" : "" %>/>&nbsp;本科
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="5" <%= data.get("edu").equals("5") ? "checked" : "" %>/>&nbsp;硕士
                                            </div>
                                            <div class="ZA-RADIO ZA-RADIO-theme-default ZA-RADIO-type-circle" data-v-24404f2c>
                                                <input type="radio" name="edu" value="6" <%= data.get("edu").equals("6") ? "checked" : "" %>/>&nbsp;博士
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">月收入</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input name="income" placeholder="单位：元" maxlength="5" type="number" value="<%= data.get("income") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">手机号</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input type="tel" name="phone" maxlength="11" placeholder="请输入你的手机号" value="<%= data.get("phone") %>" required/>
                                        </div>
                                    </div>
                                </div>
                                <div class="m-form" data-v-16a2994a="">
                                    <div class="form-item f-cl" data-v-16a2994a="">
                                        <div class="label f-fl" data-v-16a2994a="">新密码</div>
                                        <div class="ZA-INPUT" style="display:inline-block;width:270px;" data-v-16a2994a="">
                                            <input type="password" name="pwd" maxlength="20" placeholder="不填写时不修改密码"/>
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