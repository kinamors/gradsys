<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/24
  Time: 13:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Cache-Control" content="no-siteapp" />

    <script type="text/javascript"
            src="${pageContext.request.getContextPath()}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
          rel="stylesheet">
    <script src="${pageContext.request.getContextPath()}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <title>首页</title>

</head>
<!-- 添加Modal -->
<div class="modal fade" id="notice_addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">添加公告</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公告标题</label>
                        <div class="col-sm-10">
                            <input type="text" name="noticeTitle" class="form-control" id="noticeTitle_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公告内容</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="5" name="noticeContent" id="noticeContent_add_textarea"></textarea>
                            <span class="help-block"></span>
                        </div>
                        <%
                            if (session.getAttribute("loginType")=="adm"){

                        %>
                        <input type="hidden" name="noticeAuthor" id="create_user" value="${sessionScope.user.username}">
                        <%

                            }else if (session.getAttribute("loginType")=="tec"){
                        %>
                        <input type="hidden" name="noticeAuthor" id="create_user" value="${sessionScope.user.tname}">
                        <%
                            }
                        %>

                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="notice_add_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改Modal -->
<div class="modal fade" id="notice_updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">公告修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公告标题</label>
                        <div class="col-sm-10">
                            <input type="text" name="noticeTitle" class="form-control" id="noticeTitle_update_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">公告内容</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="5" name="noticeContent" id="noticeContent_update_textarea"></textarea>
                            <span class="help-block"></span>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="notice_update_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12 col-md-offset-4">
            <h1>毕业设计公告</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10 form-inline">
            <button class="btn btn-primary" id="notice_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="notice_delall_btn">删除</button>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="notice_table">
                <thead>
                <tr>
                    <th class="col-md-1" id="cb_th">
                        <input type="checkbox" id="check_all">
                    </th>
                    <th class="col-md-1">#</th>
                    <th class="col-md-5">公告标题</th>
                    <th class="col-md-1">作者</th>
                    <th class="col-md-2">添加时间</th>
                    <th class="col-md-2" id="op_th">操作</th>
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
    var loginType="${sessionScope.loginType}";

    $(function(){

        if (loginType=="stu"){
            $("#cb_th").hide();
            $("#op_th").hide();
            $("#notice_add_modal_btn").hide();
            $("#notice_delall_btn").hide();


        }else if (loginType=="tec"){
            $("#cb_th").hide();
            $("#op_th").hide();
            $("#notice_delall_btn").hide();
        }
        to_page(1);

    });


    //刷新页面
    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/noticeController/getAllNotices",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_notice_table(result);
                // console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }
    //显示课题表格
    function build_notice_table(result) {
        $("#notice_table tbody").empty();
        var notices=result.extendMap.pageInfo.list;
        $.each(notices,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='check_item'></td>");
            var noticeId=$("<td></td>").append(item.noticeId);
            var noticeTitle=$("<td></td>").append($("<a></a>").attr("href","noticeContent.jsp?noticeId="+item.noticeId+"").append(item.noticeTitle));
            var noticeContent=$("<td></td>").append(item.noticeContent);
            var noticeAuthor=$("<td></td>").append(item.noticeAuthor);
            var date=timestampToTime(item.noticeTime);
            var addDate=$("<td></td>").append(date);
            if(loginType=="adm"){
                var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                delBtn.attr("del_id",item.noticeId);
                var Btns=$("<td></td>").append(delBtn);

                $("<tr></tr>").append(checkbox)
                    .append(noticeId)
                    .append(noticeTitle)
                    .append(noticeAuthor)
                    .append(addDate)
                    .append(Btns).appendTo("#notice_table tbody");
            }else{
                $("<tr></tr>").append(noticeId)
                    .append(noticeTitle)
                    .append(noticeAuthor)
                    .append(addDate).appendTo("#notice_table tbody");
            }



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
    $("#notice_add_modal_btn").click(function(){
        reset_form("#notice_addModal form");
        $("#notice_addModal").modal({
            backdrop:"static"
        }) ;
    });

    //添加页面的保存操作
    $("#notice_add_save_btn").click(function(){

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/noticeController/saveNotice",
            type:"POST",
            data:$("#notice_addModal form").serialize(),
            success:function(result){
                if(result.code==100){
                    $("#notice_addModal").modal('hide');
                    to_page(totalrecord);
                }
//                alert(result.msg);
            }
        });
    });


    //删除单个操作
    $(document).on("click",".del_btn",function(){
        var title = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("del_id");
        if(confirm("确认删除【"+title+"】吗")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/noticeController/notice/"+id,
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
    $("#notice_delall_btn").click(function(){
        var titles="";
        var ids="";
        $.each($(".check_item:checked"),function(){
            titles+=$(this).parents("tr").find("td:eq(2)").text()+",";
            ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        titles=titles.substring(0,titles.length-1);
        ids=ids.substring(0,ids.length-1);
        if(confirm("确认删除【"+titles+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/noticeController/notice/"+ids,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //查询单个课题
    function getNotice(id){
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


</script>
</body>
</html>
