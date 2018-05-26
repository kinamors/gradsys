<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/5/1
  Time: 3:18
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

<body>

<div class="container-fluid">
    <div class="row" style="height: 20px;">

    </div>

    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" id="saveMark_form">
                <div class="form-group">
                    <label class="col-sm-2 control-label">学号：</label>
                    <div class="col-sm-10">
                        <input type="number" name="sno" id="sno_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">论文编号：</label>
                    <div class="col-sm-10">
                        <input type="number" name="paperId" id="paperId_input">
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">评价：</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="7" name="comment" id="mark_comment_textarea"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">成绩：</label>
                    <div class="col-sm-10">
                        <input type="number" name="mark" id="mark_input">
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="tno" value="${sessionScope.user.tno}">
                    <input type="hidden" name="paperName" id="paperName_input">
                </div>
            </form>
        </div>
    </div>
    <div class="row" style="margin-top: 30px;">
        <div class="col-md-2 col-md-offset-2">
            <button type="button" class="btn btn-primary btn-block" id="mark_save_bt">提交</button>
        </div>
    </div>
</div>



<script type="text/javascript">




    //添加时验证学号是否已经添加
    $("#sno_input").change(function(){
        var sno=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/markController/checkMarkBySno",
            data:"sno="+sno,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#sno_input","success","学号可使用");
                    $("#mark_save_bt").attr("ajax-va","success");
                }else{
                    show_validate_msg("#sno_input","error",result.extendMap.va_msg);
                    $("#mark_save_bt").attr("ajax-va","failure");
                }
            }
        });
    });

    //添加时查找课题名称
    $("#paperId_input").change(function(){
        var num=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/paper/"+num,
            type:"GET",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#paperId_input","success",result.extendMap.paper.pName);
                    $("#paperName_input").attr("value",result.extendMap.paper.pName);
                    $("#mark_save_bt").attr("ajax-va","success");
                }else{
                    show_validate_msg("#paperId_input","error","没有找到结果，请重新填写");
                    $("#mark_save_bt").attr("ajax-va","failure");
                }
            }
        });
    });


    $("#mark_save_bt").click(function () {

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/markController/saveMark",
            type:"POST",
            data:$("#saveMark_form").serialize(),
            success:function(result){
                if(result.code==100){
                    alert(result.msg);
                }
//                alert(result.msg);
            }
        });

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
