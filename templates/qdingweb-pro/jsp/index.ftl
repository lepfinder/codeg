<%@ page contentType="text/html;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"%>
<%
    String version = "15";
    String staticHost = "http://front.qdingnet.com";
    String env = request.getServerName().split("\\.")[0];
    if (env.equalsIgnoreCase("boss")) {
        staticHost = "http://front.qdingnet.com";
    }else if(env.equalsIgnoreCase("qaboss")){
        staticHost = "http://qafront.qdingnet.com";
    }else if(env.equalsIgnoreCase("devboss")){
        staticHost = "http://devfront.qdingnet.com";
    }else if(env.startsWith("http://localhost") || env.startsWith("127")){
        staticHost = "http://localhost";
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8" />
    <title>千丁互联（龙湖地产）</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="shortcut icon" href="<%=staticHost %>/public/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="<%=staticHost %>/public/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="<%=staticHost %>/public/angular-bootstrap-datetimepicker/src/css/datetimepicker.css"/>
    <link rel="stylesheet" href="<%=staticHost %>/public/fontawesome/css/font-awesome.min.css" />
    <link rel="stylesheet" href="<%=staticHost %>/public/angular-growl/build/angular-growl.min.css" />
    <link rel="stylesheet" href="<%=staticHost %>/qding/css/base.min.css?<%=version %>" />
    <link rel="stylesheet" href="<%=staticHost %>/qding/css/{{project.name}}.min.css?<%=version %>" />


    <script src="<%=staticHost %>/public/ng-file-upload/angular-file-upload-shim.min.js"></script>
    <script src="<%=staticHost %>/public/jquery/dist/jquery.min.js"></script>
    <script src="<%=staticHost %>/public/angular/angular.min.js"></script>
    <script src="<%=staticHost %>/public/ng-file-upload/angular-file-upload.min.js"></script>
    <script src="<%=staticHost %>/public/angular-ui-router/release/angular-ui-router.min.js"></script>
    <script src="<%=staticHost %>/public/angular-bootstrap/ui-bootstrap-tpls.min.js"></script>
    <script src="<%=staticHost %>/public/angular-growl/build/angular-growl.min.js"></script>
    <script src="<%=staticHost %>/public/angular-locale/angular-locale_zh-cn.js"></script>
    <script src="<%=staticHost %>/public/tinymce/tinymce.min.js"></script>
    <script src="<%=staticHost %>/public/angular-ui-tinymce/src/tinymce.js"></script>
    <script src="<%=staticHost %>/public/moment/moment.js"></script>
    <script src="<%=staticHost %>/public/moment/locale/zh-cn.js"></script>
    <script src="<%=staticHost %>/public/angular-bootstrap-datetimepicker/src/js/datetimepicker.js"></script>
    <script src="<%=staticHost %>/qding/js/{{project.name}}.min.js?<%=version %>"></script>
</head>
<body cs-layout></body>
</html>
