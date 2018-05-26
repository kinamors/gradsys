<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/26
  Time: 0:20
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
<div class="container">
    <div class="row">
        <div class="col-md-6 col-md-offset-4">
            <h1 id="notice_title"></h1>
        </div>
        <div class="col-md-2 col-md-offset-10">
            <p id="notice_author"></p>
            <p id="notice_time"></p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <p id="notice_content" class=".lead">

            </p>
        </div>
    </div>
    <%--主内容--%>
    <div class="row">

    </div>


    <div class="row">
        <div class="col-md-offset-4" id="page_info_nav">
        </div>
    </div>
</div>
<script type="text/javascript">

    var noticeId=<%=request.getParameter("noticeId")%>

        $(function () {
            to_content(noticeId);


        });

    //刷新页面
    function to_content(noticeId){

        $.ajax({
            url:"${pageContext.request.getContextPath()}/noticeController/getNotice",
            data:"noticeId="+noticeId,
            type:"GET",

            success:function(result){

                build_notice(result);
                // console.log(result);

            }
        });
    }

    function build_notice(result){
        var notice=result.extendMap.notice;
        var time=timestampToTime(notice.noticeTime)
        $("#notice_title").append(notice.noticeTitle);
        $("#notice_content").append(notice.noticeTitle);
        $("#notice_author").append("作者："+notice.noticeAuthor);
        $("#notice_time").append("发表时间："+time);

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
