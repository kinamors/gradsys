<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/26
  Time: 13:13
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
<!-- 添加Modal -->
<div class="modal fade" id="selectPaper_addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">课题添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题编号</label>
                        <div class="col-sm-10">
                            <input type="number" name="selectId" class="form-control" id="selectId_add_input" placeholder="1000">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题标题</label>
                        <div class="col-sm-10">
                            <input type="text" name="selectTitle" class="form-control" id="selectTitle_add_input" placeholder="...系统">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题简介</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="5" name="selectMsg" id="selectMsg_add_textarea" placeholder="例如...."></textarea>
                            <span class="help-block"></span>
                        </div>
                        <input type="hidden" name="createName" id="create_user" value="${sessionScope.user.tname}">
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="selectPaper_add_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改Modal -->
<div class="modal fade" id="selectPaper_updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">课题修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题编号</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="selectId_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题标题</label>
                        <div class="col-sm-10">
                            <input type="text" name="selectTitle" class="form-control" id="selectTitle_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">课题简介</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="5" name="selectMsg" id="selectMsg_update_textarea"></textarea>
                            <span class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="selectPaper_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-12">
            <h1>论文课题</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="selectPaper_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="selectPaper_delall_btn">删除</button>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="paperTitle_table">
                <thead>
                <tr>
                    <th class="col-md-1">
                        <input type="checkbox" id="check_all">
                    </th>
                    <th class="col-md-1">课题编号</th>
                    <th class="col-md-1">课题标题</th>
                    <th class="col-md-5">课题简介</th>
                    <th class="col-md-1">导师</th>
                    <th class="col-md-2">添加时间</th>
                    <th class="col-md-2">操作</th>
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


    //刷新页面
    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/selectPapers",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_paperTitle_table(result);
                // console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }
    //显示课题表格
    function build_paperTitle_table(result) {
        $("#paperTitle_table tbody").empty();
        var selectPapers=result.extendMap.pageInfo.list;
        $.each(selectPapers,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='check_item'></td>");
            var sId=$("<td></td>").append(item.selectId);
            var selectTitle=$("<td></td>").append(item.selectTitle);
            var selectMsg=$("<td></td>").append(item.selectMsg);
            var createName=$("<td></td>").append(item.createName);
            var date=timestampToTime(item.addDate);
            var addDate=$("<td></td>").append(date);
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            editBtn.attr("edit_id",item.selectId);
            delBtn.attr("del_id",item.selectId);
            var Btns=$("<td></td>").append(editBtn).append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(sId)
                .append(selectTitle)
                .append(selectMsg)
                .append(createName)
                .append(addDate)
                .append(Btns).appendTo("#paperTitle_table tbody");



        });

    }
    //分页栏
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
    //时间戳转化时间
    function timestampToTime(timestamp) {
        var date = new Date(timestamp);//时间戳为10位需*1000，时间戳为13位的话不需乘1000
        Y = date.getFullYear() + '-';
        M = (date.getMonth()+1 < 10 ? '0'+(date.getMonth()+1) : date.getMonth()+1) + '-';
        D = date.getDate() + ' ';
        h = date.getHours() + ':';
        m = date.getMinutes() + ':';
        s = date.getSeconds();
        return Y+M+D+h+m+s;
    }



    //全选框
    $("#check_all").click(function(){
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function(){
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_all").prop("checked",flag);
    });


    //    重置模态框
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
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


    //添加按钮操作
    $("#selectPaper_add_modal_btn").click(function(){
        reset_form("#selectPaper_addModal form");
        $("#selectPaper_addModal select").empty();
        $("#selectPaper_addModal").modal({
            backdrop:"static"
        }) ;
    });

    //添加时验证课题标题
    $("#selectTitle_add_input").change(function(){
        var title=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/checkTitle",
            data:"selectTitle="+title,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#selectTitle_add_input","success","课题可用");
                    $("#selectPaper_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#selectTitle_add_input","error",result.extendMap.va_msg);
                    $("#selectPaper_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });
    //添加时验证课题编号
    $("#selectId_add_input").change(function(){
        var num=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/checkSelectId",
            data:"selectId="+num,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#selectId_add_input","success","编号可用");
                    $("#selectPaper_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#selectId_add_input","error",result.extendMap.va_msg);
                    $("#selectPaper_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });
    //添加页面的保存操作
    $("#selectPaper_add_save_btn").click(function(){

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/addSelectPaper",
            type:"POST",
            data:$("#selectPaper_addModal form").serialize(),
            success:function(result){
                if(result.code==100){
                    $("#selectPaper_addModal").modal('hide');
                    to_page(totalrecord);
                }
//                alert(result.msg);
            }
        });
    });


    //删除单个课题操作
    $(document).on("click",".del_btn",function(){
        var title = $(this).parents("tr").find("td:eq(2)").text();
        var selectId = $(this).attr("del_id");
        if(confirm("确认删除【"+title+"】吗")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+selectId,
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
    $("#selectPaper_delall_btn").click(function(){
        var titles="";
        var selectIds="";
        $.each($(".check_item:checked"),function(){
            titles+=$(this).parents("tr").find("td:eq(2)").text()+",";
            selectIds+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        titles=titles.substring(0,titles.length-1);
        selectIds=selectIds.substring(0,selectIds.length-1);
        if(confirm("确认删除【"+titles+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+selectIds,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });


    //查询单个课题
    function getSelectPaper(id){
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+id,
            type:"GET",
            success:function(result){
                var paper=result.extendMap.selectPaper;
                $("#selectId_update_static").text(paper.selectId);
                $("#selectTitle_update_input").val(paper.selectTitle);
                $("#selectMsg_update_textarea").val(paper.selectMsg);

            }
        });
    }

    //修改时验证课题
    $("#selectTitle_update_input").change(function(){
        var title=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/checkTitle",
            data:"selectTitle="+title,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#selectTitle_update_input","success","课题可用");
                    $("#selectPaper_update_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#selectTitle_update_input","error",result.extendMap.va_msg);
                    $("#selectPaper_update_btn").attr("ajax-va","failure");
                }
            }
        });
    });

    //修改操作
    $(document).on("click",".edit_btn",function(){
        getSelectPaper($(this).attr("edit_id"));
        $("#selectPaper_update_btn").attr("edit_id",$(this).attr("edit_id"));
        $("#selectPaper_updateModal").modal({
            backdrop:"static"
        });
    });

    $("#selectPaper_update_btn").click(function(){
        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+$(this).attr("edit_id"),
            type:"PUT",
            data:$("#selectPaper_updateModal form").serialize(),
            success:function(result){
                $("#selectPaper_updateModal").modal("hide");
                //2、回到本页面
                to_page(currentPage);
            }
        });
    });

</script>
</body>
</html>
