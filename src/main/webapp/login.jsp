<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <%
        String context = request.getContextPath();
    %>
    <title>Title</title>
    <script type="text/javascript" src="js/main.js"></script>
</head>
<body>
<form action="<%=context%>/loginCtrl/login" method="post">
    用户名<input type="text" id="username" name="username"/>
    密码<input type="password" id="password" name="password"/>
    <input type="submit" value="提交"/>
</form>
</body>
</html>
