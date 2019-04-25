<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userLG.label', default: 'Usuario')}" />
        <title><g:message code="default.login.label" args="[entityName]" /></title>
        <script language="javascript">
			function submit() {
				$('form#authenticate_form').submit();
			}
        </script>
        <style>
			.login_box {
				border-radius: 10px 10px 10px 10px;
				-moz-border-radius: 10px 10px 10px 10px;
				-webkit-border-radius: 10px 10px 10px 10px;
				background-color: #FAFAFA;
				width:280px;
				height:410px;
				z-index: 10;
				position: absolute;
				right: 50px;
				top: 50px;
				box-shadow: 0 3px 12px rgba(0, 0, 0, 0.5);
				-webkit-box-shadow: 0 3px 12px rgba(0, 0, 0, 0.5);
				-moz-box-shadow: 0 3px 12px rgba(0, 0, 0, 0.5);
				border-color: rgba(120, 130, 140, 0.13);
			}
			.login_title {
				margin-top: 30px;
				padding: 10px 4px;
				background-color: #a3a2a0;
				width:90%;
				border-radius: 0px 5px 5px 0px;
				-moz-border-radius: 0px 5px 5px 0px;
				-webkit-border-radius: 0px 5px 5px 0px;
				border: 0px solid #FFFFFF;
				color: #FFFFFF;
				box-shadow: 3px 3px 3px #DEDEDE;
			   -webkit-box-shadow: 3px 3px 3px #DEDEDE;
			   -moz-box-shadow: 3px 3px 3px #DEDEDE;
				
			}
			.login_btn, .login_btn:focus, .login_btn:active {
				text-decoration: none;
				width:90%;
				color:white;
				font-family: arial;
				font-size: 20px;
				background-color: #CA002D;
				border: 2px solid #fff;
				-webkit-box-shadow: 0 2px 2px 0 rgba(66, 165, 245, 0.14), 0 3px 1px -2px rgba(66, 165, 245, 0.2), 0 1px 5px 0 rgba(66, 165, 245, 0.12);
				box-shadow: 0 2px 2px 0 rgba(66, 165, 245, 0.14), 0 3px 1px -2px rgba(66, 165, 245, 0.2), 0 1px 5px 0 rgba(66, 165, 245, 0.12);
				-webkit-transition: 0.2s ease-in;
				-o-transition: 0.2s ease-in;
				transition: 0.2s ease-in;
			}
			.login_btn:hover {
				color:#fff;
				opacity: 0.5;
				filter: alpha(opacity=50);
			}
			.main_title {
				background-color: transparent !important;
				width:100%;
				text-align: left;
				font-family: 'WireOne';
				font-size: 100px;
				position:absolute;
				top:62px;
				padding-left: 40px;
				text-shadow: 2px 2px #fff;
			}
			.main_title span{
				font-size: 14px;
				font-family: 'arial';
				font-weight: bold;
			}
			.login_footer {
				padding-left:10px;
				padding-right:10px;
				width: 100%;
				color: #5e5e5e;
				position: absolute;
				bottom: 0;
			}
			.login_footer a {
				color: #CA002D;
				font-weight: bold;
				text-decoration: none;
			}
			.login_footer a:hover {
				color: #e27d92;
			}
        </style>
    </head>
    <body>
        <g:render template="/layouts/menu" />
        <a href="#create-userLG" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="main_title">
        PROTOTIPO<span> v<g:meta name="info.app.version"/></span>
        </div>
        
        <div class="login_box">
            <h1 class="login_title"><img src="${request.contextPath}/assets/caret_login.png" border="0" style="position:relative;top:-3px">&nbsp;<g:message code="default.login.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.userLG}">
            <ul class="errors" role="alert" style="valign:top">
                <g:eachError bean="${this.userLG}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="authenticate" autocomplete="off" name="authenticate_form">
				<fieldset class="form" style="margin-left:0px; width:100%">
					
					<div class="form-group">
						<label for="name" class="cols-sm-2 control-label">${message(code: 'default.login.user.label', default: 'User')}
						<span class='required-indicator'>*</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
								<input type="text" class="form-control" value="" name="username" id="username"  placeholder="Capture su usuario" />
								<!--required=""--> 
							</div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="password" class="cols-sm-2 control-label">${message(code: 'default.login.password.label', default: 'Pass')}
						<span class='required-indicator'>*</span></label>
						<div class="cols-sm-10">
							<div class="input-group">
								<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
								<input type="password" class="form-control" value="" name="password" id="password"  placeholder="8 o más caracteres"/>
							</div>
						</div>
					</div>
					
					<div class="form-group">
					  <input type="checkbox" name="remember_me" id="remember_me" />&nbsp;<b>Recuérdame</b>
					</div>
					
					<span class="form-group">  
						<center>   
							<a href="javascript:submit();" class="btn login_btn" style="font-family:arial">${message(code: 'default.button.login.label', default: 'Login')}</a>
						</center>
					</span>
				</fieldset>
            </g:form>
            <!--
            <div class="login_footer">Acceso al <a href="${request.contextPath}/public/register">preregistro</a> de visitas.</div>
            -->
        </div>
    </body>
</html>
