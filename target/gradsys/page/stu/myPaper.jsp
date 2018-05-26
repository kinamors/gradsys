<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/28
  Time: 16:06
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
            <div class="col-md-12">
                <h1>课题信息</h1>
            </div>

    </div>

    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" id="savePaper_form">
                <div class="form-group">
                    <label class="col-sm-1 control-label">课题编号:</label>
                    <div class="col-sm-4">
                        <h3 id="paper_id_h3"></h3>
                        <span class="help-block"></span>
                    </div>
                    <label class="col-sm-1 control-label">课题标题:</label>
                    <div class="col-sm-4">
                        <h3 id="paper_name_h3"></h3>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">指导老师:</label>
                    <div class="col-sm-4">
                        <h5 id="paper_tec_name_h5"></h5>
                        <span class="help-block"></span>
                    </div>
                    <label class="col-sm-1 control-label">学院:</label>
                    <div class="col-sm-4">
                        <h5 id="paper_college_h5">${sessionScope.user.collName}</h5>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-1 control-label">课题简介:</label>
                    <div class="col-sm-4">
                        <h5 id="paper_Msg_h5"></h5>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                        <input type="hidden" name="sno" value="${sessionScope.user.sno}">
                        <input type="hidden" name="pId" id="paper_id_input">
                        <input type="hidden" name="author" value="${sessionScope.user.sName}">
                        <input type="hidden" name="pName" id="paper_name_input">
                        <input type="hidden" name="tecName" id="paper_tec_name_input">
                        <input type="hidden" name="college" id="paper_college_input">

                </div>
                </div>
            </form>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <button type="button" class="btn btn-primary btn-block" id="paper_save_btn">确认课题信息</button>
        </div>
    </div>
</div>


<script type="text/javascript">


    var paperNum=${sessionScope.user.paperNum};

    $(function () {
        to_content(paperNum);
    });


    //刷新页面
    function to_content(paperNum){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+paperNum,
            type:"GET",
            success:function(result){

                checkPaperHasSave(result);

                build_check_paper(result);
                // console.log(result);

            }
        });
    }

    function build_check_paper(result){


        var selectPaper=result.extendMap.selectPaper;
        $("#paper_id_h3").append(selectPaper.selectId);
        $("#paper_name_h3").append(selectPaper.selectTitle);
        $("#paper_tec_name_h5").append(selectPaper.createName);
        $("#paper_Msg_h5").append(selectPaper.selectMsg);

        $("#paper_id_input").attr("value",selectPaper.selectId);
        $("#paper_name_input").attr("value",selectPaper.selectTitle);
        $("#paper_tec_name_input").attr("value",selectPaper.createName);
        $("#paper_college_input").attr("value","${sessionScope.user.collName}");



    }

    $("#paper_save_btn").click(function () {
        if (confirm("确认提交吗？提交后不可更改")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/paperController/savePaper",
                type:"POST",
                data:$("#savePaper_form").serialize(),
                success:function(result) {
                    alert(result.msg);

                }
            });
        }
    });

    function checkPaperHasSave(se) {
        var selectPaper=se.extendMap.selectPaper;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/checkPaperHas",
            type:"POST",
            data:"pId="+selectPaper.selectId,
            success:function(result) {
                if (result.code==101){
                    $("#paper_save_btn").hide();
                }
            }
        });
    }
</script>
</body>
</html>
