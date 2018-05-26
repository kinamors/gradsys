<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/29
  Time: 2:12
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
    <div class="row" style="height: 30px">
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
        <div class="col-md-4"></div>
    </div>
    <div class="row">
        <div class="col-md-6">
            <form enctype="multipart/form-data" id="uploadForm">
                <div class="form-group">
                    <label>请上传你的毕业论文</label>

                    <%--<input type="text" name="description">--%>
                    <%--<input type="file" name="file" id="report_upload_input">--%>
                    <%--<p class="help-block">Example block-level help text here.</p>--%>
                    <table>
                        <tr>
                            <td>文件描述:</td>
                            <td><input type="text" name="description" id="description_input"></td>
                        </tr>
                        <tr>
                            <td>请选择文件:</td>
                            <td><input type="file" name="file" id="file_input"></td>
                        </tr>
                    </table>
                    <input type="hidden" name="type" id="type_input" value="paper">
                </div>
            </form>
            <button type="button" class="btn btn-primary" id="upload_button">上传</button>

        </div>
        <div class="col-md-6"></div>
    </div>
</div>

<script type="text/javascript">

    $("#upload_button").click(function () {
        var formData=new FormData();
        formData.append("file",$("#file_input")[0].files[0]);
        formData.append("description",$("#description_input").val());
        formData.append("fileType",$("#type_input").val());
        $.ajax({
            url:"${pageContext.request.getContextPath()}/upload",
            type:"POST",
            data:formData,
            cache: false,
            processData: false,
            contentType: false,
            success:function (result) {
                console.log(result);
                alert(result.extendMap.upLoad);


            }

        });

    });

</script>

</body>
</html>
