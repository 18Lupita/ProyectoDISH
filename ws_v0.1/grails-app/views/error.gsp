<!doctype html>
<html>
    <head>
        <title>VisitaNet <g:meta name="info.app.version"/></title>
        <meta name="layout" content="clear">
        <asset:stylesheet src="gsdk-bootstrap-wizard.css"/>
        <asset:stylesheet src="jqbtk.css"/>
    </head>
    <body>
        <div class="container" style="position:relative;top:20px">
			<div class="row">
			<div class="col-sm-8 col-sm-offset-2">

				<!--      Wizard container        -->
				<div class="wizard-container">

					<div class="card wizard-card" data-color="red" id="wizardProfile">
						<div class="wizard-header">
							<h3>
							   <b>ERROR</b> INESPERADO <br>
							   <small>Favor de avisar al área de soporte técnico.</small>
							</h3>
						</div>

						<div class="wizard-navigation">
							<ul>
								<li style="margin:0px !important;padding:0px !important;"><a href="#person" data-toggle="tab" style="margin:0px !important;padding:0px !important;">Error ${request.'javax.servlet.error.status_code'}</a></li>
							</ul>
						</div>
						<g:if env="development">
							${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
							&nbsp;&nbsp;&nbsp;<strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
							&nbsp;&nbsp;&nbsp;<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
							<g:if test="${exception}">
								&nbsp;&nbsp;&nbsp;<strong>Exception Message:</strong> ${exception.message?.encodeAsHTML()} <br/>
								&nbsp;&nbsp;&nbsp;<strong>Caused by:</strong> ${exception.cause?.message?.encodeAsHTML()} <br/>
								&nbsp;&nbsp;&nbsp;<strong>Class:</strong> ${exception.className} <br/>
								&nbsp;&nbsp;&nbsp;<strong>At Line:</strong> [${exception.lineNumber}] <br/>
								&nbsp;&nbsp;&nbsp;<strong>Code Snippet:</strong><br/>
								<div class="stack" style="padding-left:10px;font-size:12px;overflow: auto;height:180px;">
									<g:each in="${exception.stackTraceLines}">${it.encodeAsHTML()}<br/></g:each>
								</div>
							</g:if>
						</g:if>
						<g:else>
							${request.'javax.servlet.error.message'.encodeAsHTML()}<br/>
							<strong>Servlet:</strong> ${request.'javax.servlet.error.servlet_name'}<br/>
							<strong>URI:</strong> ${request.'javax.servlet.error.request_uri'}<br/>
						</g:else>
					</div>
				</div>
			</div>
		</div>
		<asset:javascript src="jquery.bootstrap.wizard.js"/>
		<asset:javascript src="gsdk-bootstrap-wizard.js"/>
		<asset:javascript src="jquery.validate.min.js"/>
		<asset:javascript src="jqbtk.js"/>
    </body>
</html>
