<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/28
  Time: 22:30
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
            <form class="form-horizontal" id="saveHalfPart_form">
                <div class="form-group">
                    <label class="col-sm-2 control-label">课题标题：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="paper_title"></p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">进度说明：</label>
                    <div class="col-sm-10">
                        <textarea class="form-control" rows="7" name="halfProgress" id="progress_textarea"></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="createName" value="${sessionScope.user.sName}">
                    <input type="hidden" name="sno" value="${sessionScope.user.sno}">
                    <input type="hidden" name="paperId" id="paper_id_input">
                    <input type="hidden" name="paperTitle" id="paper_title_input">
                </div>
            </form>
        </div>
    </div>
    <div class="row" style="margin-top: 30px;">
        <div class="col-md-2 col-md-offset-2">
            <button type="button" class="btn btn-primary btn-block" id="progress_save_btn">提交</button>
        </div>
    </div>
</div>

<script type="text/javascript">


    var pId=${sessionScope.user.paperNum};

    $(function () {
        to_content(pId);
        // $("#progress_textarea").attr("disabled","true");
    });

    //刷新页面
    function to_content(pId){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/paper/"+pId,
            type:"GET",
            success:function(result){

                checkProgressHasSave(result);

                build_check_half_progress(result);
                // console.log(result);

            }
        });
    }

    function build_check_half_progress(result){
        $("#paper_title").text("");
        var paper=result.extendMap.paper;
        $("#paper_title").append(paper.pName);


        $("#paper_id_input").attr("value",paper.pId);
        $("#paper_title_input").attr("value",paper.pName);



    }


    function checkProgressHasSave(se) {
        var paper=se.extendMap.paper;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/halfPartController/checkProgressHas",
            type:"POST",
            data:"sno="+paper.sno,
            success:function(result) {
                if (result.code==101){
                    $("#progress_save_btn").hide();
                    $("#progress_textarea").attr("disabled","true");
                    $("#progress_textarea").val(result.extendMap.halfPart.halfProgress);
                }
            }
        });
    }

    $("#progress_save_btn").click(function () {
        if (confirm("确认提交吗？提交后不可更改")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/halfPartController/saveHalfPart",
                type:"POST",
                data:$("#saveHalfPart_form").serialize(),
                success:function(result) {
                    alert(result.msg);
                    to_content(pId);
                }
            });
        }
    });


</script>

</body>
</html>
