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
</head>
<body>
<div class="container-fluid">
    <div class="row" style="height: 20px;">

    </div>

    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" id="mark_form">
                <div class="form-group">
                    <label class="col-sm-2 control-label">学号：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="mark_sno_p">${sessionScope.user.sno}</p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">课题标题：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="paper_name_p"></p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">评价：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="mark_comment_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">成绩：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="mark_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="sno" value="${sessionScope.user.sno}">
                    <input type="hidden" name="paperId" id="paper_id_input">
                    <input type="hidden" name="paperTitle" id="paper_title_input">
                </div>
            </form>
            <div class="row" style="margin-top: 30px;">
                <div class="col-md-2 col-md-offset-2">
                    <button type="button" class="btn btn-primary btn-block" id="mark_btn">查询</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row" style="margin-top: 30px;">
        <div class="col-md-2 col-md-offset-2">
        </div>
    </div>
</div>


<script type="text/javascript">


    $("#mark_btn").click(function () {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/markController/getMarkBySno",
            type:"POST",
            data:"sno="+${sessionScope.user.sno},
            success:function(result){
                if(result.code==100){
                    $("#paper_name_p").append(result.extendMap.mark.paperName);
                    $("#mark_comment_p").append(result.extendMap.mark.comment);
                    $("#mark_p").append(result.extendMap.mark.mark);
                }else{
                    alert(result.extendMap.va_result);
                }
//                alert(result.msg);
            }
        });

    });



</script>
</body>
</html>
