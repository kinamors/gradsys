<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/27
  Time: 10:59
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
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-12">
            <h1>老师</h1>
        </div>
    </div>
    <div class="row">

        <div class="col-xs-10 col-md-9" id="search_div">
            <form class="form-inline">
                <div class="form-group">
                    <label>教师编号:</label>
                    <input type="text" name="tno" class="form-control" id="select_teacher_tno">
                </div>
                <div class="form-group">
                    <label>姓名:</label>
                    <input type="text" name="tname" class="form-control" id="select_teacher_tName">
                </div>
                <div class="form-group">
                    <label>学历:</label>
                    <input type="text" name="education" class="form-control" id="select_teacher_education">
                </div>
                <div class="form-group">
                    <label>职称:</label>
                    <input type="text" name="post" class="form-control" id="select_teacher_post">
                </div>

            </form>
        </div>
        <div class="col-xs-1 col-md-2">
            <button class="btn btn-primary" id="search_teacher">查询</button>
            <button class="btn btn-danger" id="teacher_delall_btn">删除</button>
        </div>
        <div class="col-xs-2 col-md-2">
            <span class="help-block" id="t_result"></span>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="teacher_table">
                <thead>
                <tr>
                    <th class="col-md-1">
                        <input type="checkbox" id="check_all">
                    </th>
                    <th class="col-md-1">教师编号</th>
                    <th class="col-md-1">密码</th>
                    <th class="col-md-1">姓名</th>
                    <th class="col-md-1">教育程度</th>
                    <th class="col-md-1">职称</th>
                    <th class="col-md-1">Email</th>
                    <th class="col-md-1">电话</th>
                    <th class="col-md-1">option</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>


    <div class="row">
        <div class="col-md-offset-4" id="page_info_nav">
        </div>
    </div>
</div>


<script type="text/javascript">


    var totalrecord,currentPage;

    $(function(){
        to_page(1);
    });

    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/teacherController/getAllTeachers",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_teacher_table(result);
                console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }

    function build_teacher_table(result) {
        $("#teacher_table tbody").empty();
        if(result.code==101){
            return
        }
        var teachers=result.extendMap.pageInfo.list;
        $.each(teachers,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='check_item'></td>");
            var tno=$("<td></td>").append(item.tno);
            var password=$("<td></td>").append(item.password);
            var tName=$("<td></td>").append(item.tname);
            var mobile=$("<td></td>").append(item.mobile);
            var education=$("<td></td>").append(item.education);
            var post=$("<td></td>").append(item.post);
            var email=$("<td></td>").append(item.email);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("del_id",item.tno);
            var Btns=$("<td></td>").append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(tno)
                .append(password)
                .append(tName)
                .append(education)
                .append(post)
                .append(email)
                .append(mobile)
                .append(Btns).appendTo("#teacher_table tbody");



        });
    }

    function build_page_nav(result){
        $("#page_info_nav").empty();
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));

        firstPageLi.click(function(){
            to_page(1);
        });
        prePageLi.click(function(){
            to_page(result.extendMap.pageInfo.prePage);
        });
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        nextPageLi.click(function(){
            to_page(result.extendMap.pageInfo.nextPage);
        });
        lastPageLi.click(function(){
            to_page(result.extendMap.pageInfo.pages);
        });
        var paginUl=$("<ul></ul>").addClass("pagination").append(firstPageLi).append(prePageLi);

        $.each(result.extendMap.pageInfo.navigatepageNums,function(index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item).attr("href","#"));
            if(result.extendMap.pageInfo.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function(){
                to_page(item);
            });
            paginUl.append(numLi);
        });

        paginUl.append(nextPageLi).append(lastPageLi);

        var navEle=$("<nav></nav>").append(paginUl);

        $("#page_info_nav").append(navEle);

    }

    //全选框
    $("#check_all").click(function(){
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function(){
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });

    //多级查询
    $("#search_teacher").click(function () {
        $("#t_result").text('');
        var  page=1;
        console.log($("#search_div form").serialize());
        $.ajax({
            url:"${pageContext.request.getContextPath()}/teacherController/getTeachersBy",
            type:"POST",
            data:$("#search_div form").serialize()+"&page=1",
            success:function (result) {
                if (result.code==100){
                    build_teacher_table(result);
                }else{
                    build_teacher_table(result);
                    var msg= result.extendMap.s_result;
                    $("#t_result").text(msg);
                }
            }
        });
    });

    //删除单个课题操作
    $(document).on("click",".del_btn",function(){
        var tName = $(this).parents("tr").find("td:eq(3)").text();
        var tno = $(this).attr("del_id");
        if(confirm("确认删除【"+tName+"】吗")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/teacherController/teacher/"+tno,
                type:"DELETE",
                success:function(result){
                    console.log(result);
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //批量删除
    $("#teacher_delall_btn").click(function(){
        var tNames="";
        var tnos="";
        $.each($(".check_item:checked"),function(){
            tNames+=$(this).parents("tr").find("td:eq(3)").text()+",";
            tnos+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        tNames=tNames.substring(0,tNames.length-1);
        tnos=tnos.substring(0,tnos.length-1);
        if(confirm("确认删除【"+tNames+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/teacherController/teacher/"+tnos,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
