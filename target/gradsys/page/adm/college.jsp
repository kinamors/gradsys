<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/28
  Time: 11:10
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

<!-- college添加Modal -->
<div class="modal fade" id="college_addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">学院添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学院编号</label>
                        <div class="col-sm-10">
                            <input type="text" name="cid" class="form-control" id="cId_add_input" placeholder="1000">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学院名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="cname" class="form-control" id="cname_add_input">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="college_add_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>
<!-- classes添加Modal -->
<div class="modal fade" id="classes_addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel2">班级添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">班级名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="className" class="form-control" id="className_add_input" placeholder="14软件2班">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学院名称</label>
                        <div class="col-sm-10">
                            <select class="form-control" name="cId" id="select_collName">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="classes_add_save_btn">提交</button>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-12">
            <h1>班级</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10">
            <button class="btn btn-primary" id="college_add_modal_btn">新增学院</button>
            <button class="btn btn-primary" id="classes_add_modal_btn">新增班级</button>
            <button class="btn btn-danger" id="classes_delall_btn">删除</button>
        </div>
        <div class="col-xs-2 col-md-2">
            <span class="help-block" id="t_result"></span>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="colAndClass_table">
                <thead>
                <tr>
                    <th class="col-md-1">
                        <input type="checkbox" id="check_all">
                    </th>
                    <th class="col-md-1">id</th>
                    <th class="col-md-4">班级名称</th>
                    <th class="col-md-1">学院编号</th>
                    <th class="col-md-4">学院名称</th>
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
            url:"${pageContext.request.getContextPath()}/classesController/getColAndClasses",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_colAndClass_table(result);
                console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }

    function build_colAndClass_table(result) {
        $("#colAndClass_table tbody").empty();
        if(result.code==101){
            return
        }
        var colAndClass=result.extendMap.pageInfo.list;
        $.each(colAndClass,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='check_item'></td>");
            var id=$("<td></td>").append(item.id);
            var className=$("<td></td>").append(item.className);
            var cId=$("<td></td>").append(item.college.cid);
            var cname=$("<td></td>").append(item.college.cname);
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("del_id",item.id);
            var Btns=$("<td></td>").append(delBtn);
            $("<tr></tr>").append(checkbox)
                .append(id)
                .append(className)
                .append(cId)
                .append(cname)
                .append(Btns).appendTo("#colAndClass_table tbody");



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
        var className = $(this).parents("tr").find("td:eq(2)").text();
        var id = $(this).attr("del_id");
        if(confirm("确认删除【"+className+"】吗")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/classesController/classes/"+id,
                type:"DELETE",
                success:function(result){
                    console.log(result);
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //添加学院modal
    $("#college_add_modal_btn").click(function(){
        reset_form("#college_addModal form");
        $("#college_addModal").modal({
            backdrop:"static"
        }) ;
    });

    //添加班级modal
    $("#classes_add_modal_btn").click(function(){
        reset_form("#classes_addModal form");
        get_collName("#select_collName");
        $("#classes_addModal").modal({
            backdrop:"static"
        }) ;
    });


    //添加时验证学院编号
    $("#cId_add_input").change(function(){
        var cid=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/collegeController/checkCId",
            data:"cid="+cid,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#cId_add_input","success","学院编号可用");
                    $("#college_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#cId_add_input","error",result.extendMap.va_msg);
                    $("#college_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });

    //添加时验证学院名称
    $("#cname_add_input").change(function(){
        var cname=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/collegeController/checkCName",
            data:"cname="+cname,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#cname_add_input","success","学院名称可用");
                    $("#admin_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#cname_add_input","error",result.extendMap.va_msg);
                    $("#admin_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });

    //添加时验证班级名称
    $("#className_add_input").change(function(){
        var className=this.value;
        $.ajax({
            url:"${pageContext.request.getContextPath()}/classesController/checkClassName",
            data:"className="+className,
            type:"POST",
            success:function(result){
                if(result.code==100){
                    show_validate_msg("#className_add_input","success","班级名称可用");
                    $("#admin_add_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#className_add_input","error",result.extendMap.va_msg);
                    $("#admin_add_save_btn").attr("ajax-va","failure");
                }
            }
        });
    });

    //学院添加页面的保存操作
    $("#college_add_save_btn").click(function(){

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/collegeController/saveCollege",
            type:"POST",
            data:$("#college_addModal form").serialize(),
            success:function(result){
                if(result.code==100){
                    $("#college_addModal").modal('hide');
                    to_page(totalrecord);
                }
//                alert(result.msg);
            }
        });
    });

    //班级添加页面的保存操作
    $("#classes_add_save_btn").click(function(){

        if($(this).attr("ajax-va")=="failure"){
            return false;
        }
        $.ajax({
            url:"${pageContext.request.getContextPath()}/classesController/saveClasses",
            type:"POST",
            data:$("#classes_addModal form").serialize(),
            success:function(result){
                if(result.code==100){
                    $("#classes_addModal").modal('hide');
                    to_page(totalrecord);
                }
//                alert(result.msg);
            }
        });
    });

    //批量删除
    $("#classes_delall_btn").click(function(){
        var classes="";
        var ids="";
        $.each($(".check_item:checked"),function(){
            classes+=$(this).parents("tr").find("td:eq(2)").text()+",";
            ids+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        classes=classes.substring(0,classes.length-1);
        ids=ids.substring(0,ids.length-1);
        if(confirm("确认删除【"+classes+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/classesController/classes/"+ids,
                type:"DELETE",
                success:function(result){
                    alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //获取学院select
    function get_collName(ele){
        $(ele).empty();
        $.ajax({
            url:"${pageContext.request.getContextPath()}/collegeController/getAllColleges",
            type:"GET",
            success:function(result){
                $.each(result.extendMap.colleges,function(index,item){
                    var option=$("<option></option>").append(item.cname).attr("value",item.cid);
                    $(ele).append(option);
                });
            }

        });
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
    //    重置模态框
    function reset_form(ele){
        $(ele)[0].reset();
        $(ele).find("*").removeClass("has-success has-error");
        $(ele).find(".help-block").text("");
    }
</script>

</body>
</html>
