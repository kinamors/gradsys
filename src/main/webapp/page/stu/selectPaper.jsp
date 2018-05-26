<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/26
  Time: 17:49
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
            <h1>论文课题</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-10 form-inline">
            <select class="form-control" id="selectType">
                <option value="all">全部</option>
                <option value="canChoose">可选</option>
                <option value="cantChoose">已选</option>
            </select>
            <button class="btn btn-primary" id="choosePaper_btn">选题</button>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">
        <div class="col-md-12" style="height: 600px">
            <table class="table table-hover" id="paperTitle_table">
                <thead>
                <tr>
                    <th class="col-md-1">

                    </th>
                    <th class="col-md-1">课题编号</th>
                    <th class="col-md-1">课题标题</th>
                    <th class="col-md-5">课题简介</th>
                    <th class="col-md-1">导师</th>
                    <th class="col-md-2">添加时间</th>
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
    var type;
    var sno="${sessionScope.user.sno}";
    $(function(){
        type="selectPapers";
        checkStuSelected();
        to_page(1);

    });

    //下拉菜单
    $("#selectType").change(function () {


         if ($(this).val()=="canChoose"){
            type="selectPapersNotChoose" ;
            $("#choosePaper_btn").show();
            to_page(1);

        }else if ($(this).val()=="all"){
            type="selectPapers" ;
            $("#choosePaper_btn").show();
            to_page(1);

        }else if ($(this).val()=="cantChoose"){
            type="selectPapersHasChoose";
            $("#choosePaper_btn").hide();
            to_page(1);
        }
        console.log(type);

    });

    //多选变单选
    function checkBoxOnly(obj) {
        var aa = $(".check_item");
        for (var i = 0; i < aa.length; i++) {
            aa[i].checked = false;
        }
        obj.checked = true;
    }

    //选课
    $("#choosePaper_btn").click(function () {
        checkStuSelected();

        if ($(this).attr("ajax-va")=="failure"){
            alert("你已经选完课题了");
            return false;
        }
       var paperName="";
       var paperId="";
       $.each($(".check_item:checked"),function () {
           paperName+=$(this).parents("tr").find("td:eq(2)").text();
           paperId+=$(this).parents("tr").find("td:eq(1)").text();
       });



        if(confirm("确认选择【"+paperName+"】吗？")){
            $.ajax({
                url:"${pageContext.request.getContextPath()}/studentController/choosePaper/"+sno,
                type:"PUT",
                data:"paperId="+paperId,
                success:function(result){
                    alert(result.msg);
                    refreshStudent(sno);
                    to_page(1);
                }
            });
        }
    });

    function checkPaperIsSelected() {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/studentController/checkStuIsSelected",
            data:"sno="+sno,
            type:"POST",
            success:function (result) {
                if (result.code==100) {
                    $("#choosePaper_btn").attr("ajax-va","success");
                }else{
                    $("#choosePaper_btn").attr("ajax-va","failure");

                }
            }
        });
    }

    function refreshStudent() {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/studentController/freshStudent/"+sno,
            type:"POST",
            success:function(result){
                console.log(result);
            }
        });
    }

    //校验学生是否已经选题
    function checkStuSelected() {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/studentController/checkStuIsSelected",
            data:"sno="+sno,
            type:"POST",
            success:function (result) {
               if (result.code==100) {
                   $("#choosePaper_btn").attr("ajax-va","success");
               }else{
                   $("#choosePaper_btn").attr("ajax-va","failure");

               }
            }
        });
    }

    //刷新页面
    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/"+type,
            data:"page="+page,
            type:"GET",

            success:function(result){

                build_paperTitle_table(result);
                console.log(result);
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
            var checkbox=$("<td><input type='checkbox' name='cb' class='check_item' onclick='checkBoxOnly(this)'></td>");
            var sId=$("<td></td>").append(item.selectId);
            var selectTitle=$("<td></td>").append(item.selectTitle);
            var selectMsg=$("<td></td>").append(item.selectMsg);
            var createName=$("<td></td>").append(item.createName);
            var date=timestampToTime(item.addDate);
            var addDate=$("<td></td>").append(date);

            $("<tr></tr>").append(checkbox)
                .append(sId)
                .append(selectTitle)
                .append(selectMsg)
                .append(createName)
                .append(addDate).appendTo("#paperTitle_table tbody");



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



</script>
</body>
</html>
