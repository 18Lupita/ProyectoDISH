<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'desarrollador.label', default: 'Desarrollador')}" />
        <g:set var="entitiesName" value="${message(code: 'desarrollador.label', default: 'Desarrolladores')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <script language="javascript">
			$( document ).ready(function() {
				
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
			  <li class="active"><g:message code="default.show.label" args="[entityName]" /></li>
			</ul>
		  </div>
		</div>
		<!-- .breadcrumb-box -->
        <a href="#show-desarrollador" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
                <li><a href="javascript:go('edit')"		class="edit"><g:message code="default.button.edit.label" default="Edit" /></a></li>
                <li><a href="javascript:go('delete')"	class="delete"><g:message code="default.button.delete.label" default="Delete" /></a></li>
                <li><a href="javascript:go('close')"	class="close"><g:message code="default.button.close.label" default="close" /></a></li>
            </ul>
        </div>
        <div id="show-desarrollador" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
				<script type="text/javascript">
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
            <f:display bean="desarrollador" />
            --}%
            
			<f:with bean="desarrollador">
                <ol class="property-list desarrollador">
                    <li class="fieldcontain">
                        <span id="nombre-label" class="property-label"><g:message code="desarrollador.nombre.label" default="Nombre" /></span>
                        <div class="property-value" aria-labelledby="nombre-label"><f:display property="nombre"/></div>
                    </li>
                </ol>
                <ol class="property-list desarrollador">
                    <li class="fieldcontain">
                        <span id="telefono-label" class="property-label"><g:message code="desarrollador.telefono.label" default="Phone" /></span>
                        <div class="property-value" aria-labelledby="telefono-label"><f:display property="telefono"/></div>
                    </li>
                </ol>
                <ol class="property-list desarrollador">
                    <li class="fieldcontain">
                        <span id="domicilio-label" class="property-label"><g:message code="desarrollador.domicilio.label" default="Adress" /></span>
                        <div class="property-value" aria-labelledby="domicilio-label"><f:display property="domicilio"/></div>
                    </li>
                </ol>
                <ol class="property-list desarrollador">
                    <li class="fieldcontain">
                        <span id="isManager-label" class="property-label"><g:message code="desarrollador.isManager.label" default="Manager" /></span>
                        <div class="property-value" aria-labelledby="isManager-label"><f:display property="isManager"/></div>
                    </li>
                </ol>
            </f:with>
			
            
            <g:form resource="${this.desarrollador}" method="DELETE" name="delete_form">
				<fieldset class="buttons">
					<g:link name="footer-edit" class="edit" action="edit" resource="${this.desarrollador}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:link name="footer-delete" class="delete" url="javascript:void(0)" onclick="jconfirm('${message(code: 'default.delete.ask.message', default: 'Are you sure?')}','${message(code: 'default.delete.info.message', default: 'You are deleting the record.')}');"><g:message code="default.button.delete.label" default="Delete" /></g:link>
                    <g:link name="footer-close" class="close" action="index"><g:message code="default.button.close.label" default="Close" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
