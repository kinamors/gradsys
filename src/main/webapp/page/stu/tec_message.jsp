<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/5/1
  Time: 1:25
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

<body>
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-4">
            <h1 id="paper_title"></h1>
        </div>
        <div class="col-md-2 col-md-offset-10">
            <p id="stu_name"></p>
            <p id="tec_name"></p>
        </div>
    </div>
    <div class="row" style="height: 300px">
        <div class="col-md-4">
            <p id="paper_msg" class=".lead">

            </p>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">

    </div>


    <div class="row">
        <div class="col-md-12" id="paper_Message">
            <table class="table table-bordered" id="paper_Message_table">
                <thead>
                <tr>
                    <th class="col-md-1">#</th>
                    <th class="col-md-1">姓名</th>
                    <th class="col-md-7">回复内容</th>
                    <th class="col-md-1">时间</th>
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

    <div class="row">
        <div class="col-md-12" id="paper_Message_input">
            <table class="table" id="paper_Message_table_input">
                <thead>
                <tr>
                    <th class="col-md-1">姓名</th>
                    <th class="col-md-7">回复内容</th>
                    <th class="col-md-1">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <form>
                        <td>${sessionScope.user.sName}</td>
                        <td><textarea class="form-control" rows="5" name="mContent" id="content_input"></textarea></td>
                        <td><button type="button" class="btn btn-primary" id="message_save">回复</button></td>
                        <input type="hidden" name="mUser" value="${sessionScope.user.sName}">
                        <input type="hidden" name="mTitle" id="mTitle_input">
                        <input type="hidden" name="sno" value="${sessionScope.user.sno}">
                    </form>
                </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>


<script type="text/javascript">
    var paperId="${sessionScope.user.paperNum}";
    var totalrecord,currentPage;
    var title;

    console.log(paperId);



    $(function () {
        if (paperId==""){
            alert("你还没选课题");
            $("#content_input").attr("disabled","true");
            $("#message_save").attr("disabled","true");
            return
        }else
        {
            get_paperContent(paperId);
            get_paper(paperId);

        }


    });


    function get_paperContent(paperId){


        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/selectPaper/"+paperId,
            type:"GET",

            success:function(result){

                build_paperContent(result);
                // console.log(result);

            }
        });
    }


    function build_paperContent(result) {
        var paper=result.extendMap.selectPaper;
        $("#paper_msg").append(paper.selectMsg);

    }

    //得到论文简介
    function get_paper(paperId){
        console.log(paperId);
        $.ajax({
            url:"${pageContext.request.getContextPath()}/paperController/paper/"+paperId,
            type:"GET",
            success:function(result){
                console.log(result);
                if (result.code==101){
                        alert("请确认选题信息");
                        $("#content_input").attr("disabled","true");
                        $("#message_save").attr("disabled","true");
                        return
                }
                build_paper(result);
                // console.log(result);

            }
        });
    }

    function build_paper(result) {
        var paper=result.extendMap.paper;
        $("#paper_title").append(paper.pName);
        title=paper.pName;
        console.log(paper.author);
        $("#mTitle_input").attr("value",title);
        $("#stu_name").append("学生："+paper.author);
        $("#tec_name").append("导师："+paper.tecName);
        to_page(1);

    }


    $("#message_save").click(function () {
        $.ajax({
            url:"${pageContext.request.getContextPath()}/messageController/saveMessage",
            type:"POST",
            data:$("#paper_Message_table_input form").serialize(),
            success:function(result){
                if(result.code==100){
                    to_page(totalrecord);
                }
//                alert(result.msg);
            }
        });
    });


    function to_page(page){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/messageController/getMessageByTitle",
            data:"page="+page+"&title="+title,
            type:"GET",

            success:function(result){


                get_message_content(result);
                // console.log(result);
                build_page_nav(result);

                totalrecord=result.extendMap.pageInfo.total;
                currentPage=result.extendMap.pageInfo.pageNum;
            }
        });
    }

    function get_message_content(result) {
        $("#paper_Message_table tbody").empty();
        if(result.code==101){
            return
        }
        var messages=result.extendMap.pageInfo.list;
        var count=0;
        $.each(messages,function (index,item) {
            count=count+1;
            var countNum=$("<td></td>").append(count);
            var mUser=$("<td></td>").append(item.mUser);
            var mContent=$("<td></td>").append(item.mContent);
            var date=timestampToTime(item.mDate);
            var mDate=$("<td></td>").append(date);


            $("<tr></tr>").append(countNum)
                .append(mUser)
                .append(mContent)
                .append(mDate).appendTo("#paper_Message_table tbody");



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
