<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/28
  Time: 1:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript"
            src="${pageContext.request.getContextPath()}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row" style="height: 20px;">

    </div>

    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" id="updatePwd_form">
                <div class="form-group">
                    <label class="col-sm-1 control-label">学号</label>
                    <div class="col-sm-4">
                        <p class="form-control-static" id="username_update_static">${sessionScope.user.sno}</p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">密码</label>
                    <div class="col-sm-4">
                        <input type="password" class="form-control" id="pwdStart_update_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">请在输入一遍密码</label>
                    <div class="col-sm-4">
                        <input type="password" name="password" class="form-control" id="pwdEnd_update_input">
                        <span class="help-block"></span>
                        <input type="hidden" name="sno" value="${sessionScope.user.sno}">
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <button type="button" class="btn btn-primary btn-block" id="stu_updatePwd_btn">提交</button>
        </div>
    </div>
</div>

<script type="text/javascript">

    //验证密码
    function checkPassword() {
        var passwordS=$("#pwdStart_update_input").val();
        var passwordE=$("#pwdEnd_update_input").val();
        if (passwordS==passwordE){
            return true;
        }else{
            return false;
        }
    }
    $("#stu_updatePwd_btn").click(function () {
        $("#pwdStart_update_input").next("span").text("");
        if (checkPassword()==true){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/studentController/updatePwd",
                type:"POST",
                data:$("#updatePwd_form").serialize(),
                success:function(result){
                    if(result.code==100){
                        alert(result.msg);
                    }
//                alert(result.msg);
                }
            });
        }else{
            show_validate_msg("#pwdStart_update_input","error","两次输入的密码不相同");
            return
        }
    });




    //验证信息
    function show_validate_msg(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success"==status){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error"==status){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }
</script>
</body>
</html>
