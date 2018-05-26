<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/27
  Time: 2:01
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
            <h1>论文</h1>
        </div>
    </div>
    <div class="row ">
        <div class="col-xs-10 col-md-9" id="search_div">
            <form class="form-inline">
                <div class="form-group">
                    <label>学号</label>
                    <input type="text" name="sno" class="form-control">
                </div>
                <div class="form-group">
                    <label>姓名:</label>
                    <input type="text" name="author" class="form-control">
                </div>
                <div class="form-group">
                    <label>课题编号:</label>
                    <input type="text" name="pId" class="form-control">
                </div>
                <div class="form-group">
                    <label>导师:</label>
                    <input type="text" name="tecName" class="form-control">
                </div>
                <div class="form-group">
                    <label>学院:</label>
                    <select class="form-control" name="collegeId" id="select_collName">

                    </select>
                </div>

            </form>
        </div>
        <div class="col-xs-1 col-md-2">
            <button class="btn btn-primary" id="search_paper">查询</button>
        </div>
        <div class="col-xs-2 col-md-2">
            <span class="help-block" id="s_result"></span>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="paper_table">
                <thead>
                <tr>
                    <th class="col-md-1">论文(课题)编号</th>
                    <th class="col-md-1">学生</th>
                    <th class="col-md-2">论文题目</th>
                    <th class="col-md-1">学号</th>
                    <th class="col-md-1">指导老师</th>
                    <th class="col-md-1">学院</th>
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

    $(function () {
        to_page(1);
    });

    //刷新页面
    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/papers",
            data:"page="+page,
            type:"GET",
            success:function(result){

                get_collName("#select_collName");

                build_paper_table(result);
                // console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }
    //显示课题表格
    function build_paper_table(result) {
        $("#paper_table tbody").empty();
        if(result.code==101){
            return
        }
        var papers=result.extendMap.pageInfo.list;
        $.each(papers,function (index,item) {
            var pId=$("<td></td>").append(item.pId);
            var author=$("<td></td>").append(item.author);
            var pName=$("<td></td>").append(item.pName);
            var sno=$("<td></td>").append(item.sno);
            var tecName=$("<td></td>").append(item.tecName);
            var college=$("<td></td>").append(item.college);

            $("<tr></tr>").append(pId)
                .append(author)
                .append(pName)
                .append(sno)
                .append(tecName)
                .append(college).appendTo("#paper_table tbody");
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

    //获取学院select选项
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


    //多级查询
    $("#search_paper").click(function () {
        $("#s_result").text('');
        var  page=1;
        console.log($("#search_div form").serialize());
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/getPaperBy",
            type:"POST",
            data:$("#search_div form").serialize()+"&page=1",
            success:function (result) {
                if (result.code==100){
                    build_paper_table(result);
                }else{
                    build_paper_table(result);
                    var msg= result.extendMap.s_result;
                    $("#s_result").text(msg);
                }
            }
        });
    });
</script>
</body>
</html>
