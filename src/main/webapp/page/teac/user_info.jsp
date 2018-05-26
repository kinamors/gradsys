<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/5/1
  Time: 19:44
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

<div class="modal fade" id="teacher_updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">完善用户信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">手机号码</label>
                        <div class="col-sm-10">
                            <input type="number" name="mobile" class="form-control" id="mobile_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group form-inline">
                        <label class="col-sm-2 control-label">学历</label>
                        <select class="form-control" name="education">
                            <option>本科</option>
                            <option>硕士</option>
                            <option>博士</option>
                            <option value="">其他</option>
                        </select>
                        <label class="col-sm-2 control-label">职称</label>
                        <select class="form-control" name="post">
                            <option>教师</option>
                            <option>辅导员</option>
                            <option>教授</option>
                            <option value="">其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">简介</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="5" name="descs" id="descs_textarea"></textarea>
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="teacher_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid">
    <div class="row" style="height: 20px;">

    </div>

    <div class="row">
        <div class="col-md-8">
            <form class="form-horizontal" id="mark_form">
                <div class="form-group">
                    <label class="col-sm-2 control-label">教师编号：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_sno_p">${sessionScope.user.tno}</p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓名：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_name_p"></p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">手机号码：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_mobile_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学历：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_education_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">职责：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_post_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">Email：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_email_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">简介：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="tec_descs_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <input type="hidden" name="sno" value="${sessionScope.user.tno}">
                    <input type="hidden" name="paperId" id="paper_id_input">
                    <input type="hidden" name="paperTitle" id="paper_title_input">
                </div>
            </form>
            <div class="row" style="margin-top: 30px;">
                <div class="col-md-2 col-md-offset-2">
                    <button type="button" class="btn btn-primary btn-block" id="update_tec_btn">完善个人信息</button>
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
    var tno=${sessionScope.user.tno};

    $(function () {
        getTeacherByTno(tno);
    });

    $("#update_tec_btn").click(function () {
        $("#teacher_update_btn").attr("edit_id","${sessionScope.user.tno}");
        $("#teacher_updateModal").modal({
            backdrop:"static"
        });
    });


    function getTeacherByTno(tno) {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/teacherController/teacher/"+tno,
            type:"GET",
            success:function(result){
                var teacher=result.extendMap.teacher;
                console.log(teacher);
                $("#tec_name_p").text(teacher.tname);
                $("#tec_mobile_p").text(teacher.mobile);
                $("#tec_education_p").text(teacher.education);
                $("#tec_post_p").text(teacher.post);
                $("#tec_email_p").text(teacher.email);
                $("#tec_descs_p").text(teacher.descs);

            }
        });
    }


    $("#teacher_update_btn").click(function () {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/teacherController/teacher/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#teacher_updateModal form").serialize(),
            success:function(result){
                $("#teacher_updateModal").modal("hide");
                getTeacherByTno(tno);
            }
        });
    })
</script>
</body>
</html>
