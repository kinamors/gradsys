<%--
  Created by IntelliJ IDEA.
  User: SKy
  Date: 2018/4/28
  Time: 0:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<p>注销成功，请点击<a href="${pageContext.request.getContextPath()}">返回登陆页</a></p>
${sessionScope.user.username}
</body>
</html>
