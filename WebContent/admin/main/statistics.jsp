<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,com.love.model.*,com.love.util.DateUtil,com.love.util.Utils" %>
<%
    User user = new User();
    int men = user.where("sex = 1").count("id");
    int women = user.where("sex = 2").count("id");
    user.close();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>
            会员信息统计
        </title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
        name="viewport">
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
                        <div class="box-header with-border"><h3 class="box-title">男女比例</h3></div>
                        <div class="box-body">
                            <canvas id="sexChart" style="height: 273px; width: 546px;"></canvas>
                        </div>
                    </div>
                </div>
                <!-- <div class="col-xs-12">
                    <div class="box box-primary">
                        <div class="box-header with-border"><h3 class="box-title">年度注册统计</h3></div>
                        <div class="box-body">
                            <canvas id="registerChart" style="height: 273px; width: 546px;"></canvas>
                        </div>
                    </div>
                </div> -->
            </div>
        </div>
        <script src="../static/js/jquery.min.js">
        </script>
        <script src="../static/js/bootstrap.min.js">
        </script>
        <script src="../static/js/chart.min.js">
        </script>
        <script src="../static/js/adminlte.min.js">
        </script>
        <script>
            $(function() {
                var sexChart = new Chart($('#sexChart').get(0).getContext('2d'));
                var sexData = [
                	{
                        value: <%= men %>,
                        color: '#00c0ef',
                        highlight: '#00c0ef',
                        label: '男'
                    },
                	{
                        value: <%= women %>,
                        color: '#f56954',
                        highlight: '#f56954',
                        label: '女'
                    }
                ];
                sexChart.Doughnut(sexData);
                
                
                /* var randomScalingFactor = function(){ return Math.round(Math.random()*100)};
                
                var registerData = {
                    labels : ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"],
                	datasets : [
                		{
                			fillColor : "#f39c12",
                			strokeColor : "#f39c12",
                			highlightFill: "#f39c12",
                			highlightStroke: "#f39c12",
                			data : [
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor(),
                				randomScalingFactor()
                			]
                		}
                	]
                }
                new Chart($('#registerChart').get(0).getContext('2d')).Bar(registerData, {
        			responsive : true
        		}); */
            })
        </script>
    </body>
</html>