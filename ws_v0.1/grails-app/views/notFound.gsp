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
							   <b>ERROR 404</b> PÁGINA NO ENCONTRADA <br>
							   <small>Favor de revisar la liga de acceso.</small>
							</h3>
						</div>

						<div class="wizard-navigation">
							<ul>
								<li style="margin:0px !important;padding:0px !important;"><a href="#person" data-toggle="tab" style="margin:0px !important;padding:0px !important;">${request.forwardURI}</a></li>
							</ul>
						</div>
						<center>
						<img src="${request.contextPath}/assets/404.gif" style="width:570px;">
						</center>
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
