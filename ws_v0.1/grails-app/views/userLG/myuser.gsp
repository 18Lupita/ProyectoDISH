<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userLG.label', default: 'Usuario')}" />
        <g:set var="entitiesName" value="${message(code: 'userLG.label', default: 'Usuarios')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <style>
            #nombre {width:50%}
            #email {width:30%}
        </style>
        <script language="javascript">
			$( document ).ready(function() {
				$("#myTime").show();
			});
			function go(id_tag){
				$('[name="footer-'+id_tag+'"]')[0].click();
			}
			
		</script>
    </head>
    <body>
		<g:render template="/layouts/menu" />
		<!-- .menu-box -->
		<div class="breadcrumb-box">
		  <div class="container">
			<ul class="breadcrumb">
			  <li><a href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			  <li class="active"><g:message code="default.myuser.label" args="[entityName]" /></li>
			</ul>	
		  </div>
		</div>
		<!-- .breadcrumb-box -->
        <a href="#show-userLG" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
				<li><a href="javascript:go('save')"		class="save"><g:message code="default.button.save.label" default="Edit" /></a></li>
                <li><a href="javascript:go('close')"	class="close"><g:message code="default.button.close.label" default="close" /></a></li>
            </ul>
        </div>
        <div id="show-userLG" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
				<script type="text/javascript">					  
					 $.amaran({
						'theme'     :'awesome ok',
						'delay'     :5000,
						'position'  :'top left',
						'content'   :{
							bgcolor:'#27ae60',
							color:'#fff',
							title:'¡Mensaje!',
							message:'${flash.message}',
							info:'', %{--<g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${new Date()}"/>--}%
							icon:'fa fa-bell-o fa-2x'
						},
						'inEffect': 'slideLeft',
						'outEffect' :'slideLeft'
					});
				</script>
			</g:if>

        %{--
            <f:display bean="userLG" />
        --}%
			<g:form method="PUT" resource="${this.userLG}" action="updateMyUser" method="POST">
				<f:with bean="userLG">
					<ol class="property-list userLG">
						<li class="fieldcontain">
							<span id="username-label" class="property-label">Usuario</span>
							<div class="property-value" aria-labelledby="username-label"><f:display property="username"/></div>
						</li>

						<li class="fieldcontain">
							<span id="username-label" class="property-label">Rol</span>
							<div class="property-value" aria-labelledby="username-label">${userLG.getRol()}</div>
						</li>
						<g:hiddenField name="username" value="${userLG.username}" />
						<g:hiddenField name="role" value="${userLG.getRol()}" />
						<g:hiddenField name="enabled" value="${userLG.enabled}" />
						<g:hiddenField name="accountExpired" value="${userLG.accountExpired}" />
						<g:hiddenField name="accountLocked" value="${userLG.accountLocked}" />
						<g:hiddenField name="passwordExpired" value="${userLG.passwordExpired}" />
						
						<f:field property="password" label="Contraseña"/>
						<g:hiddenField name="password_plain" value="${userLG.password_plain}" />

						<li class="fieldcontain">
							<span id="accountLocked-label" class="property-label">Cuenta bloqueada</span>
							<div class="property-value" aria-labelledby="accountLocked-label"><f:display property="accountLocked"/></div>
						</li>

						<li class="fieldcontain">
							<span id="accountExpired-label" class="property-label">Expira la cuenta</span>
							<div class="property-value" aria-labelledby="accountExpired-label"><f:display property="accountExpired"/></div>
						</li>

						<li class="fieldcontain">
							<span id="passwordExpired-label" class="property-label">Expira la contraseña</span>
							<div class="property-value" aria-labelledby="passwordExpired-label"><f:display property="passwordExpired"/></div>
						</li>

						<li class="fieldcontain">
							<span id="enabled-label" class="property-label">Activo</span>
							<div class="property-value" aria-labelledby="enabled-label"><f:display property="enabled"/></div>
						</li>
					</ol>
				</f:with>
				<g:submitButton name="footer-save" style="visibility:hidden;position:absolute;top:0px;width:0px;"/>
                <fieldset class="buttons">
					<g:link class="save" url="javascript:go('save')"><g:message code="default.button.save.label" default="Save" /></g:link>
                    <g:link name="footer-close" class="close" uri="/"><g:message code="default.button.close.label" default="Close" /></g:link>
				</fieldset>
			</g:form>
        </div>
    </body>
</html>
