<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/27
  Time: 23:49
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
<div class="modal fade" id="admin_addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">管理员添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" name="username" class="form-control" id="username_add_input" placeholder="admin">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="password" name="password" class="form-control" id="password_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="admin_add_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>



<div class="container-fluid">
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-12">
            <h1>管理员</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="admin_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="admin_delall_btn">删除</button>
        </div>
        <div class="col-xs-2 col-md-2">
            <span class="help-block" id="t_result"></span>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="admin_table">
                <thead>
                <tr>
                    <th class="col-md-1">
                        <input type="checkbox" id="check_all">
                    </th>
                    <th class="col-md-1">id</th>
                    <th class="col-md-4">username</th>
                    <th class="col-md-4">password</th>
                    <th class="col-md-3">option</th>
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
            url:"${pageContext.request.getContextPath()}/adminController/getAllAdmins",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_admin_table(result);
                console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }

    function build_admin_table(result) {
        $("#admin_table tbody").empty();
        if(result.code==101){
            return
        }
        var admins=result.extendMap.pageInfo.list;
        $.each(admins,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='check_item'></td>");
            var id=$("<td></td>").append(item.id);
            var password=$("<td></td>").append(item.password);
            var username=$("<td></td>").append(item.username);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("del_id",item.id);
            var Btns=$("<td></td>").append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(id)
                .append(username)
                .append(password)
                .append(Btns).appendTo("#admin_table tbody");



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

    //删除单个课题操作
    $(document).on("click",".del_btn",function(){
        var username = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("del_id");
        if(confirm("确认删除【"+username+"】吗")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/adminController/admin/"+id,
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
    $("#admin_delall_btn").click(function(){
        var usernames="";
        var ids="";
        $.each($(".check_item:checked"),function(){
            usernames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        usernames=usernames.substring(0,usernames.length-1);
        ids=ids.substring(0,ids.length-1);
        if(confirm("确认删除【"+usernames+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/adminController/admin/"+ids,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //添加管理员
    $("#admin_add_modal_btn").click(function(){
        reset_form("#admin_addModal form");
        $("#admin_addModal").modal({
            backdrop:"static"
        }) ;
    });
    //添加时验证用户名
    $("#username_add_input").change(function(){
        var username=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/adminController/checkUsername",
            data:"username="+username,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#username_add_input","success","用户名可用");
                    $("#admin_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#username_add_input","error",result.extendMap.va_msg);
                    $("#admin_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });

    //添加页面的保存操作
    $("#admin_add_save_btn").click(function(){

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/adminController/saveAdmin",
            type:"POST",
            data:$("#admin_addModal form").serialize(),
            success:function(result){
                if(result.code==100){
                    $("#admin_addModal").modal('hide');
                    to_page(totalrecord);
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

    //    重置模态框
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
</script>
</body>
</html>
