<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/2
  Time: 11:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <title>毕业设计过程管理系统</title>
    <script type="text/javascript"
            src="${pageContext.request.getContextPath()}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <style>

        body {
            background-image: url(static/common/image/sen.jpg);
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }

        #row1 {
            background: url(static/common/image/login-bg-6.png);
            background-size: 30% 100%;
            background-position: left;
            -moz-background-size: 35% 100%;
            opacity: 0.7;
            background-repeat: no-repeat;
            height: 500px;
            width: 1100px;
            margin-left: auto;
            margin-right: auto;
        }

        #top {
            height: 150px;
            margin-left: auto;
            margin-right: auto;
        }
    </style>
</head>
<body>
<%--注册modal--%>
<div class="modal fade" id="reg_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">注册页面</h4>
            </div>
            <div class="modal-body">
                <div>

                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#stuPanel" aria-controls="stuPanel" role="tab"
                                                                  data-toggle="tab">学生</a></li>
                        <li role="presentation"><a href="#tecPanel" aria-controls="tecPanel" role="tab"
                                                   data-toggle="tab">教师</a></li>
                    </ul>
                    <br>
                    <!-- Tab panes -->
                    <div class="tab-content">
                        <%--学生注册--%>
                        <div role="tabpanel" class="tab-pane active" id="stuPanel">
                            <form>
                                <div class="form-group form-inline">
                                    <label for="snoInput">学号</label>
                                    <input type="text" class="form-control" id="snoInput" name="sno">
                                </div>
                                <div class="form-group form-inline">
                                    <label for="stuRegPwdInput">密码</label>
                                    <input type="password" class="form-control" id="stuRegPwdInput" name="password">
                                </div>
                                <div class="form-group form-inline">
                                    <label for="snameInput">姓名</label>
                                    <input type="text" class="form-control" id="snameInput" placeholder="小明"
                                           name="sName">
                                </div>
                                <%--<div class="form-group form-inline">--%>
                                <%--<label for="mobileInput">手机</label>--%>
                                <%--<input type="text" class="form-control" id="mobileInput">--%>
                                <%--</div>--%>
                                <br>
                                <div class="form-group">
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" value="male">男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="sex" value="female">女
                                    </label>
                                </div>
                                <br>
                                <div class="form-group form-inline">
                                    <label for="select_collName">学院</label>
                                    <select class="form-control" name="collName" id="select_collName">

                                    </select>
                                    <label for="select_classes">班级</label>
                                    <select class="form-control" name="classes" id="select_classes">

                                    </select>
                                </div>
                                <%--<div class="form-group">--%>
                                <%--<label for="exampleInputEmail1">Email address</label>--%>
                                <%--<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">--%>
                                <%--</div>--%>
                                <button type="button" class="btn btn-primary" id="student_reg_submit">提交</button>
                            </form>
                        </div>
                        <%--教师注册--%>
                        <div role="tabpanel" class="tab-pane" id="tecPanel">
                            <form>
                                <div class="form-group">
                                    <label for="snoInput">教师编号</label>
                                    <input type="text" class="form-control" id="tnoInput" name="tno">
                                </div>
                                <div class="form-group form-inline">
                                    <label for="teaRegPwdInput">密码</label>
                                    <input type="password" class="form-control" id="teaRegPwdInput" name="password">
                                </div>
                                <div class="form-group form-inline">
                                    <label for="tnameInput">姓名</label>
                                    <input type="text" class="form-control" id="tnameInput" placeholder="小明"
                                           name="tname">
                                </div>
                                <%--<div class="form-group form-inline">--%>
                                <%--<label for="mobileInput">手机</label>--%>
                                <%--<input type="text" class="form-control" id="mobileInput">--%>
                                <%--</div>--%>
                                <br>
                                <br>
                                <div class="form-group form-inline">
                                    <label>学历</label>
                                    <select class="form-control" name="education">
                                        <option>本科</option>
                                        <option>硕士</option>
                                        <option>博士</option>
                                        <option value="">其他</option>
                                    </select>
                                    <label>职称</label>
                                    <select class="form-control" name="post">
                                        <option>教师</option>
                                        <option>辅导员</option>
                                        <option>教授</option>
                                        <option value="">其他</option>
                                    </select>
                                </div>
                                <%--<div class="form-group">--%>
                                <%--<label for="exampleInputEmail1">Email address</label>--%>
                                <%--<input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email">--%>
                                <%--</div>--%>
                                <button type="button" class="btn btn-primary" id="teacher_reg_submit">提交</button>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-4"></div>
        <div class="col-md-4" id="top">


        </div>
        <div class="col-md-4"></div>
    </div>
    <div class="row" id="row1">
        <div class="col-md-12">
            <div class="col-md-4">
                <h2>
                    毕业设计过程管理系统
                </h2>
            </div>
            <br>
            <br>
            <br>
            <div class="row" id="main_content" style="margin-top: 70px">
                <div class="col-md-5 ">
                    <form class="form-horizontal" method="post" action="loginController/login" onsubmit="return check();">
                        <div class="form-group">
                            <label for="inputUsername" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-5">
                                <input type="text" class="form-control" name="username" id="inputUsername"
                                       placeholder="请输入用户名">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputPassword" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" name="password" id="inputPassword"
                                       placeholder="请输入密码">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="loginRadios" id="stuRadio" value="stu"> 学生
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="loginRadios" id="tecRadio" value="tec"> 教师
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="loginRadios" id="admRadio" value="adm"> 管理员
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-10 col-sm-offset-1">
                                没有账号，请点击<a href="javascript:void(0)" onclick="reg()">注册</a>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-1 col-sm-10">
                                <button type="submit" class="btn btn-primary col-sm-8" id="login_btn">登陆</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">


    $(function () {
        get_collName("#select_collName");
        $("#stuRadio").attr("checked", "true");
    });



    function check() {
        if ($("#inputUsername").val()==""){
            alert("请输入用户名");
            return false;
        }
        if ($("#inputPassword").val()==""){
            alert("请输入密码");
            return false;
        }

        return true;
    }


    //获取学院select选项
    function get_collName(ele){
        $(ele).empty();
        $.ajax({
            url:"${pageContext.request.getContextPath()}/collegeController/getAllColleges",
            type:"GET",
            success:function(result){
                $.each(result.extendMap.colleges,function(index,item){
                    var option=$("<option></option>").append(item.cname).attr("value",item.cid);
                    $(ele).append(option);
                });
                getClasses(ele);
            }

        });

    }
    //获取班级下拉菜单
    $("#select_collName").change(function () {
        getClasses($(this));
    });

    function getClasses(ele) {
        $("#select_classes").empty();
        var cId=$(ele).val();
        $.ajax({
            url:"${pageContext.request.getContextPath()}/classesController/getClassesByCId",
            type:"GET",
            data:"cid="+cId,
            success:function(result){
                if (result.code==100){
                    $.each(result.extendMap.classes,function(index,item){
                        var option=$("<option></option>").append(item.className).attr("value",item.id);
                        $("#select_classes").append(option);
                    });
                }else{
                    var option=$("<option></option>").append("没有");
                    $("#select_classes").append(option);
                }

            }

        });

    }

    // 注册页面
    function reg() {
        $("#reg_modal").modal({
            backdrop: "static"
        });
    }


    $("#student_reg_submit").click(function () {
        $.ajax({
            url: "${pageContext.request.getContextPath()}/loginController/regStudent",
            type: "POST",
            data: $("#stuPanel form").serialize(),
            success: function (result) {
                alert("注册成功");
                $("#reg_modal").modal('hide');
            }
        })
    });

    $("#teacher_reg_submit").click(function () {
        $.ajax({
            url: "${pageContext.request.getContextPath()}/loginController/regTeacher",
            type: "POST",
            data: $("#tecPanel form").serialize(),
            success: function (result) {
                alert("注册成功");
                $("#reg_modal").modal('hide');
            }
        })
    });


</script>


</body>
</html>
