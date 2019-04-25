<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'proyecto.label', default: 'Proyecto')}" />
        <g:set var="entitiesName" value="${message(code: 'proyecto.label', default: 'Proyectoes')}" />
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

            function jremove_punto(pregunta,mensaje,id){
                swal({
                    title: pregunta,
                    text: mensaje,
                    type: "question",
                    showCancelButton: true,
                    confirmButtonColor: "#DA291C",
                    confirmButtonText: "Si, eliminar!",
                    cancelButtonText: "No",
                    confirmButtonClass: "btn btn-success",
                    cancelButtonClass: "btn btn-danger",
                    buttonsStyling: true
                }).then(function() {
                     location.href = "${request.contextPath}/desarrollador/remove/"+id;
                });
            }
            
            function go(id_tag){
				$('[name="footer-'+id_tag+'"]')[0].click();
			}

            function window_view(id, nombre, appaterno, apmaterno, telefono, domicilio){
                url_submit = "${request.contextPath}/entidad/save";
                title_name = "<g:message code='default.new.label' args='[entityName]' />";
                if(id != null){
                    url_submit = "${request.contextPath}/entidad/update/"+id;
                    title_name = "<g:message code='default.edit.label' args='[entityName]'/>";
                }
                swal({title: title_name,
                    showCancelButton: true,
                    type: "success",
                    confirmButtonColor: "#207a9c",
                    confirmButtonText:"<i class='fa fa-check'></i> ¡Sí, Guardar!",
                    cancelButtonText: "<i class='fa fa-times'></i> Cancelar",
                    confirmButtonClass: "btn btn-success",
                    cancelButtonClass: "btn btn-danger",
                    buttonsStyling: true,
                    html:
                    "<table border='0px' cellpadding='0px' cellspacing='0px' style='width:100%;border:0px !important;'>"+
                    "<tr><td style='text-align:right;width:80px !important;border-bottom:0px;'><span style='color:red'>*</span>&nbsp;<g:message code="municipio.nombre.label" default="Name" />:&nbsp;</td><td style='border-bottom:0px;''><input type='text' name='window_name' id='window_name' value='"+nombre+"'/></td></tr>"+
                    "</table></br>",
                }).then((value) => {
                    if ($("#window_name").val() == ""){
                        swal({
                            title: "Advertencia",
                            text: "El nombre del municipio no puede ser vacío",
                            type: "warning",
                            showCancelButton: false,
                            confirmButtonColor: '#207a9c',
                            confirmButtonText: '<i class="fa fa-check"></i> Aceptar',
                            confirmButtonClass: 'btn btn-success',
                            buttonsStyling: true
                        });
                    }else{
                        $("#window_form #nombre").val($("#window_name").val());
                        $("#window_form #id").val(id);
                        if (url_submit == "${request.contextPath}/entidad/save"){
                            $("#window_form #_method").val("");
                        }
                        $("#window_form").attr('action', url_submit);
                        $("#window_form").submit();
                    }
                });
                $('#window_name').focus()
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
        <a href="#show-proyecto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
                <sec:ifAnyGranted roles='ROLE_ADMIN'>
                <li><a href="javascript:go('edit')"		class="edit"><g:message code="default.button.edit.label" default="Edit" /></a></li>
                
                <li><a href="javascript:go('delete')"	class="delete"><g:message code="default.button.delete.label" default="Delete" /></a></li>
                </sec:ifAnyGranted>
                <li><a href="javascript:go('close')"	class="close"><g:message code="default.button.close.label" default="close" /></a></li>
            </ul>
        </div>
        <div id="show-proyecto" class="content scaffold-show" role="main">
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
            <f:display bean="proyecto" />
            --}%
            
			<f:with bean="proyecto">
                <ol class="property-list proyecto">
                    <li class="fieldcontain">
                        <span id="nombre-label" class="property-label"><g:message code="proyecto.nombre.label" default="Nombre" /></span>
                        <div class="property-value" aria-labelledby="nombre-label"><f:display property="nombre"/></div>
                    </li>
                    <li class="fieldcontain">
                        <span id="descripcion-label" class="property-label"><g:message code="proyecto.descripcion.label" default="Description" /></span>
                        <div class="property-value" aria-labelledby="descripcion-label"><f:display property="descripcion"/></div>
                    </li>
                    <li class="fieldcontain">
                        <span id="status-label" class="property-label"><g:message code="proyecto.status.label" default="Status" /></span>
                        <div class="property-value" aria-labelledby="status-label"><f:display property="status"/></div>
                    </li>
                    <li class="fieldcontain">
                        <span id="observacion-label" class="property-label"><g:message code="proyecto.observacion.label" default="Observations" /></span>
                        <div class="property-value" aria-labelledby="observacion-label"><f:display property="observacion"/></div>
                    </li>
                    <li class="fieldcontain">
                        <span id="projectManager-label" class="property-label"><g:message code="proyecto.projectManager.label" default="Administrador" /></span>
                        <div class="property-value" aria-labelledby="projectManager-label"><f:display property="projectManager"/></div>
                    </li>
                    <li class="fieldcontain">
                        <span id="desarrolladores-label" class="property-label"><g:message code="proyecto.desarrolladores.label" default="Desarrolladores" /></span>
                        <div class="property-value" aria-labelledby="desarrolladores-label"><f:display property="desarrolladores"/></div>
                    </li>
                </ol>
                    
            </f:with>
			
            <g:form resource="${this.proyecto}" method="DELETE" name="delete_form">
				<fieldset class="buttons">
                    <sec:ifAnyGranted roles='ROLE_ADMIN'>
    					<g:link name="footer-edit" class="edit" action="edit" resource="${this.proyecto}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
                        </sec:ifAnyGranted>
                        <sec:ifAnyGranted roles='ROLE_ADMIN'>
                        <g:link name="footer-delete" class="delete" url="javascript:void(0)" onclick="jconfirm('${message(code: 'default.delete.ask.message', default: 'Are you sure?')}','${message(code: 'default.delete.info.message', default: 'You are deleting the record.')}');"><g:message code="default.button.delete.label" default="Delete" /></g:link>
</sec:ifAnyGranted>
                    <g:link name="footer-close" class="close" action="index"><g:message code="default.button.close.label" default="Close" /></g:link>
                    <g:link name="footer-create" class="create" action="create" controller="desarrollador" params="[proyecto: "${this.proyecto.id}"]" style="float:right"><g:message code="default.new.label_a" args="['Desarrollador']" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
