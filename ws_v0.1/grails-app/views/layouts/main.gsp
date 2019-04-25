<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Prototipo <g:meta name="info.app.version"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <asset:stylesheet src="application.css"/>
	<asset:javascript src="application.js"/>
    
    <script language="javascript">
		$(document).ready(function(e){
			updateMyTime();
			setInterval("updateMyTime()",1000);
			
		});
		
		function updateMyTime(){
			var tiempo = new Date();
			$("#myTime").html(tiempo.format("HH:MM TT"));
		}
    </script>
<g:if test="${session.getAttribute("username_establecimiento_bg")}">
	<style>
		body{
			background-image: url(${request.contextPath}/assets/upload/${session.getAttribute("username_establecimiento_bg")}) !important;
		}
	</style>
</g:if>

    <g:layoutHead/>
</head>
<body>
    <g:if test="${session.getAttribute("redirect")}">
    <script languaje="javascript">
		location.href="${request.contextPath}${session.getAttribute("redirect")}";
    </script>
    </g:if>
    <g:else>
    <div class="navbar navbar-default navbar-static-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="navbar-collapse collapse" aria-expanded="false" style="height: 0.8px;">
				<span style="font-size:20px;color:gray;padding-left:20px;">¡Bienvenido! <span style="font-weight:bold;color:white;text-shadow: 2px 2px #666;">${session.getAttribute("username_main")}</span></span>
				<ul class="nav navbar-nav navbar-right">
                    <g:pageProperty name="page.nav" />
                </ul>
            </div>
            <div id="myTime"></div>
        </div>
    </div>
	
    <g:layoutBody/>

    <div class="footer" role="contentinfo">
        <g:copyright startYear="2019" encodeAs="raw">Copyright.</g:copyright>
        <!--
        <a href="http://weykhans.com"><img src="${request.contextPath}/assets/ws_red.png" width="100px" style="float:right" border="0px"></a>
        -->
    </div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>
    </g:else>
</body>
</html>
