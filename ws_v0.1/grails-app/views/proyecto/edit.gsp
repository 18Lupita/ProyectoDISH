<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'proyecto.label', default: 'Proyecto')}" />
        <g:set var="entitiesName" value="${message(code: 'proyecto.label', default: 'Proyectos')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <style>
            #nombre {width:70%}
            #projectManager, #desarrolladores {width:40%}
            #status {width:15%}
            #descripcion, #observacion {width:50%}
        </style>
        <script language="javascript">
			$( document ).ready(function() {
				$("#status").select2({
					language: "es"
				});
				$("#desarrolladores, #projectManager").select2({
					language: "es"
				});
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
			  <li><g:link action="index"><g:message code="default.list.label" args="[entitiesName]" /></g:link></li>
			  <li><g:link action="show" resource="${this.proyecto}"><g:message code="default.show.label" args="[entityName]" /></g:link></li>
			  <li class="active"><g:message code="default.edit.label" /> ${proyecto.nombre}</li>
			</ul>	
		  </div>
		</div>
		<!-- .breadcrumb-box -->
        <a href="#edit-proyecto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
				<li><a href="javascript:go('save')"		class="save"><g:message code="default.button.save.label" default="Edit" /></a></li>
                <li><a href="javascript:go('close')"	class="close"><g:message code="default.button.close.label" default="close" /></a></li>
            </ul>
        </div>
        <div id="edit-proyecto" class="content scaffold-edit" role="main">
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
            <g:hasErrors bean="${this.proyecto}">
				<script type="text/javascript">
					var mensaje = "";
					<g:eachError bean="${this.proyecto}" var="error">
					mensaje += '<g:message error="${error}"/></br>';
					</g:eachError>
					$.amaran({
						'theme'     :'awesome ok',
						'delay'     :5000,
						'position'  :'top left',
						'content'   :{
							bgcolor:'#27ae60',
							color:'#fff',
							title:'¡Mensaje!',
							message:mensaje,
							info:'', %{--<g:formatDate format="yyyy-MM-dd HH:mm:ss" date="${new Date()}"/>--}%
							icon:'fa fa-bell-o fa-2x'
						},
						'inEffect': 'slideLeft',
						'outEffect' :'slideLeft'
					});
				</script>
            </g:hasErrors>
            <g:form resource="${this.proyecto}" method="PUT">
                <g:hiddenField name="version" value="${this.proyecto?.version}" />
                <fieldset class="form">
                    
                    %{--
                    <f:all bean="proyecto"/>
                    --}%
                    
                    <f:with bean="proyecto">
                         <f:field property="nombre"/>
                        <f:field property="descripcion"/>
                        <f:field property="status"/>
                        <f:field property="observacion"/>
                        <f:field property="projectManager"/>
                        <div class="fieldcontain">
                            <label for="desarrolladores" class="">${message(code: 'proyecto.desarrolladores.label', default: 'Desarrolladores')}</label>
                            <g:select multiple="true" optionKey="id" optionValue="nombre" name="desarrolladores" value="${proyecto?.desarrolladores*.id}" from="${desarrolladoresList}" />
                        </div>
                    </f:with>
                    
                </fieldset>
                <g:submitButton name="footer-save" style="visibility:hidden;position:absolute;top:0px;width:0px;"/>
                <fieldset class="buttons">
					<g:link class="save" url="javascript:go('save')"><g:message code="default.button.save.label" default="Save" /></g:link>
                    <g:link name="footer-close" class="close" action="show" resource="${this.proyecto}"><g:message code="default.button.close.label" default="Close" /></g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
