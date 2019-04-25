<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userLG.label', default: 'Usuario')}" />
        <g:set var="entitiesName" value="${message(code: 'userLG.label', default: 'Usuarios')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <script language="javascript">
			$( document ).ready(function() {
				$("#myTime").show();
			});
            function jconfirm(pregunta,mensaje){
                swal({
                    title: pregunta,
                    text: mensaje,
                    type: "error",
                    showCancelButton: true,
                     confirmButtonColor: "#CA002D",
                    confirmButtonText: "<i class='fa fa-check'></i> ¡Si, eliminar!",
                    cancelButtonText: "<i class='fa fa-times'></i> Cancelar",
                    confirmButtonClass: "btn btn-success",
                    cancelButtonClass: "btn btn-danger",
                    buttonsStyling: true
                }).then(function() {
                     $( "#delete_form" ).submit();
                });
            }

            function restart(id){
                swal({
                    title: '<g:message code="default.restart.ask.message" default="Do you want continue?"/>',
                    text: '<g:message code="default.restart.info.message" default="The password will be restart using the nick name"/>',
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: '#FFD100',
                     confirmButtonText: "<i class='fa fa-check'></i> ¡Si, continuar!",
                    cancelButtonText: "<i class='fa fa-times'></i> Cancelar",
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: true
                }).then(function() {
					location.href = "${request.contextPath}/userLG/restart/"+id;
                });
            }

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
			  <li><g:link action="index"><g:message code="default.list.label" args="[entitiesName]" /></g:link></li>
			  <li class="active">${userLG.nombre}</li>
			</ul>
		  </div>
		</div>
		<!-- .breadcrumb-box -->
        <a href="#show-userLG" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
                <li><a href="javascript:go('edit')"		class="edit"><g:message code="default.button.edit.label" default="Edit" /></a></li>
                <li><a href="javascript:go('delete')"	class="delete"><g:message code="default.button.delete.label" default="Delete" /></a></li>
                <li><a href="javascript:go('password')"	class="password"><g:message code="default.button.restart.label" default="Restart" /></a></li>
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

            <f:with bean="userLG">
                <ol class="property-list userLG">
					
					<li class="fieldcontain">
						<span id="nombre-label" class="property-label"><g:message code="userLG.nombre.label" default="Nombre" /></span>
						<div class="property-value" aria-labelledby="nombre-label"><f:display property="nombre"/></div>
					</li>
					
                    <li class="fieldcontain">
                        <span id="username-label" class="property-label">Usuario</span>
                        <div class="property-value" aria-labelledby="username-label"><f:display property="username"/></div>
                    </li>
					
					<li class="fieldcontain">
                        <span id="password-label" class="property-label">Contraseña</span>
                        <div class="property-value" aria-labelledby="password-label"><f:display property="password"/></div>
                    </li>
					
                    <li class="fieldcontain">
                        <span id="username-label" class="property-label"><g:message code="userLG.rol.label" default="Rol" /></span>
                        <div class="property-value" aria-labelledby="username-label">${userLG.getRolName()}</div>
                    </li>
					
                    <li class="fieldcontain">
                        <span id="accountLocked-label" class="property-label">Cuenta bloqueada</span>
                        <div class="property-value" aria-labelledby="accountLocked-label">${userLG.accountLocked==false?"No":"Sí"}</div>
                    </li>

                    <li class="fieldcontain">
                        <span id="accountExpired-label" class="property-label">Expira la cuenta</span>
                        <div class="property-value" aria-labelledby="accountExpired-label">${userLG.accountExpired==false?"No":"Sí"}</div>
                    </li>

                    <li class="fieldcontain">
                        <span id="passwordExpired-label" class="property-label">Expira la contraseña</span>
                        <div class="property-value" aria-labelledby="passwordExpired-label">${userLG.passwordExpired==false?"No":"Sí"}</div>
                    </li>

                    <li class="fieldcontain">
                        <span id="enabled-label" class="property-label">Activo</span>
                        <div class="property-value" aria-labelledby="enabled-label">${userLG.enabled==false?"No":"Sí"}</div>
                    </li>
                </ol>
            </f:with>
            
            <g:form resource="${this.userLG}" method="DELETE" name="delete_form">
                <fieldset class="buttons">
					<g:link name="footer-edit" class="edit" action="edit" resource="${this.userLG}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:link name="footer-delete" class="delete" url="javascript:void(0)" onclick="jconfirm('${message(code: 'default.delete.ask.message', default: 'Are you sure?')}','${message(code: 'default.delete.info.message', default: 'You are deleting the record.')}');"><g:message code="default.button.delete.label" default="Delete" /></g:link>
                    <g:link name="footer-password" class="password" url="javascript:restart(${this.userLG.id})"><g:message code="default.button.restart.label" default="Restart" /></g:link>
                    <g:link name="footer-close" class="close" action="index"><g:message code="default.button.close.label" default="Close" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
