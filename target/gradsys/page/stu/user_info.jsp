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

<div class="modal fade" id="student_updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="student_update_btn">保存</button>
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
                    <label class="col-sm-2 control-label">学号：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_sno_p">${sessionScope.user.sno}</p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓名：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_name_p"></p>
                        <span class="help-block"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">手机号码：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_mobile_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_sex_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">学院：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_collname_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">班级：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_classes_p"></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">论文编号：</label>
                    <div class="col-sm-10">
                        <p class="form-control-static" id="stu_paperNum_p"></p>
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
                    <button type="button" class="btn btn-primary btn-block" id="update_stu_btn">完善个人信息</button>
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
    var sno=${sessionScope.user.sno};


    $(function () {
        getStudentBySno(sno);
    });

    $("#update_stu_btn").click(function () {
        $("#student_update_btn").attr("edit_id","${sessionScope.user.sno}");
        $("#student_updateModal").modal({
            backdrop:"static"
        });
    });


    function getStudentBySno(sno) {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/studentController/student/"+sno,
            type:"GET",
            success:function(result){
                var student=result.extendMap.student;
                console.log(student);
                $("#stu_name_p").text(student.sName);
                $("#stu_mobile_p").text(student.mobile);
                if (student.sex=="male"){
                    $("#stu_sex_p").text("男");
                }else
                {
                    $("#stu_sex_p").text("女");
                }
                $("#stu_collname_p").text(student.collName);
                $("#stu_classes_p").text(student.classes);
                $("#stu_paperNum_p").text(student.paperNum);

            }
        });
    }

    $("#student_update_btn").click(function () {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/studentController/student/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#student_updateModal form").serialize(),
            success:function(result){
                $("#student_updateModal").modal("hide");
                getStudentBySno(sno);
            }
        });
    })
</script>

</body>
</html>
