<%--<%@ page import="com.iwxp.platform.dto.UserInfo" %>--%>
<%@ page language="java" pageEncoding="UTF-8" %>
<html>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.0.1/dist/leaflet.css" />
<head>
<%--    <%
        String context = request.getContextPath();
        UserInfo user = (UserInfo)request.getSession().getAttribute("user");
        String user_name = "未登录";
        if (user!=null){
            user_name = user.getUser_name();
        }
    %>--%>
    <script type="text/javascript" src="js/main.js"></script>
    <script>
        $(function () {
            var mymap = L.map('mapid').setView([39.9788, 116.30226], 14);
        });
        function jump() {
            $.ajax({
                url: 'index/getAllUsers',
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    for (var i in data) {
                        alert(data[i].user_name);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                   /* alert(XMLHttpRequest.status);
                    alert(XMLHttpRequest.readyState);
                    alert(textStatus);*/
                }
            })
        }
    </script>
</head>
<body>
<%--<%=user_name%>--%>
<h2>mvc TEST</h2>

<input type="button" value="确认" onclick="jump()"/>
<%--<a href="<%=context%>/oginCtrl/hello" >功能a</a>--%>
<a href="login.jsp">登录</a>

<div id="map" style="height: 180px; width: 300px; border: 1px; border-color: aqua;"></div>
<a href="map.jsp">map</a>
</body>
</html>
