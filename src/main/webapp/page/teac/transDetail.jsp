<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/29
  Time: 12:30
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
            <h1>外文翻译</h1>
        </div>
    </div>
    <div class="row ">
        <div class="col-xs-10 col-md-9" id="search_div">
            <form class="form-inline">
                <div class="form-group">
                    <label>学号</label>
                    <input type="text" name="upSno" class="form-control">
                </div>
                <div class="form-group">
                    <label>姓名:</label>
                    <input type="text" name="upUserName" class="form-control">
                    <input type="hidden" name="upFileType" id="fileType_input" value="trans">
                </div>

            </form>
        </div>
        <div class="col-xs-1 col-md-2">
            <button class="btn btn-primary" id="search_upLoadRecord">查询</button>
        </div>
        <div class="col-xs-2 col-md-2">
            <span class="help-block" id="s_result"></span>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="reportUpRecord_table">
                <thead>
                <tr>
                    <th class="col-md-1">#</th>
                    <th class="col-md-1">学生</th>
                    <th class="col-md-2">学号</th>
                    <th class="col-md-2">外文翻译</th>
                    <th class="col-md-1">时间</th>
                    <th class="col-md-1">操作</th>
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
        to_page(1)
    });

    //刷新页面
    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/upLoadRecordController/getTransUpRecord",
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_reportUpRecord_table(result);
                // console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }
    //显示课题表格
    function build_reportUpRecord_table(result) {
        $("#reportUpRecord_table tbody").empty();
        if(result.code==101){
            return
        }
        var reportUpRecord=result.extendMap.pageInfo.list;
        var count=0;
        $.each(reportUpRecord,function (index,item) {
            count=count+1;
            var countNum=$("<td></td>").append(count);
            var upUserName=$("<td></td>").append(item.upUserName);
            var upSno=$("<td></td>").append(item.upSno);
            var upFilename=$("<td></td>").append(item.upFilename);
            var date=timestampToTime(item.upTime);
            var upTime=$("<td></td>").append(date);
            var downloadBtn=$("<button></button>").addClass("btn btn-primary btn-sm download_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("下载");

            downloadBtn.attr("url",item.upUrl).attr("filename",item.upFilename);
            var Btns=$("<td></td>").append(downloadBtn);
            $("<tr></tr>").append(countNum)
                .append(upUserName)
                .append(upSno)
                .append(upFilename)
                .append(upTime)
                .append(Btns).appendTo("#reportUpRecord_table tbody");



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


    //下载按钮点击
    $(document).on("click",".download_btn",function(){
        downloadReport($(this).attr("url"),$(this).attr("filename"));
    });

    function downloadReport(fileUrl,filename) {
        window.location.href="${pageContext.request.getContextPath()}/download?filename="+filename+"&url="+fileUrl;
    }


    //多级查询
    $("#search_upLoadRecord").click(function () {
        $("#s_result").text('');
        var  page=1;
        console.log($("#search_div form").serialize());
        $.ajax({
            url:"${pageContext.request.getContextPath()}/upLoadRecordController/getUpRecordBy",
            type:"POST",
            data:$("#search_div form").serialize()+"&page=1",
            success:function (result) {
                if (result.code==100){
                    build_reportUpRecord_table(result);
                }else{
                    build_reportUpRecord_table(result);
                    var msg= result.extendMap.s_result;
                    $("#s_result").text(msg);
                }
            }
        });
    });

</script>

</body>
</html>
