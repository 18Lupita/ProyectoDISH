<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Prototipo <g:meta name="info.app.version"/></title>
    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    
    <asset:stylesheet src="application.css"/>
	<asset:javascript src="application.js"/>
    
    <g:layoutHead/>
</head>
<body>
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
				<span style="font-size:20px;padding-left:20px;">¡Bienvenido!</span>

            </div>
        </div>
    </div>
	
    <g:layoutBody/>

    <div class="footer" role="contentinfo">
        <g:copyright startYear="2018" encodeAs="raw">Copyright. <i class="fa fa-map-marker"></i>&nbsp;Agustín Lara #52, Altavista, Cuernavaca, Morelos, Méx. 62010&nbsp;<i class="fa fa-phone"></i>&nbsp;01 (777) 246 6177 o 78</g:copyright>
        <a href="http://weykhans.com"><img src="${request.contextPath}/assets/ws_red.png" width="100px" style="float:right" border="0px"></a>
    </div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>
</body>
</html>
