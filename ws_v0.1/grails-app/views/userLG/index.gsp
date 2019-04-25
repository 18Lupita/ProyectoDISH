<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userLG.label', default: 'Usuario')}" />
        <g:set var="entitiesName" value="${message(code: 'userLG.label', default: 'Usuarios')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <script language="javascript">
			$(document).ready(function(e){
				$("#myTime").show();
				if($(".js-switch")[0]){
					var a=Array.prototype.slice.call(document.querySelectorAll(".js-switch"));
					a.forEach(function(a){
						new Switchery(a,{color:"#78BE20"})
					})
				}
				$(".search-panel .dropdown-menu").find("a").click(function(e) {
					e.preventDefault();
					var param_max = $(this).attr("href").replace("#","");
					var concept = $(this).text();
					$(".search-panel span#search_concept").text(concept);
					$("#search_rows").val(param_max);
					if ($("#search_word").val() == ""){
						$("#search_clean").val("1");
					}
					$( "#search_form" ).submit();
				});
				$("#btn-search").click(function(e) {
					if ($("#search_word").val() == ""){
						$("#search_clean").val("1");
					}
					$( "#search_form" ).submit();
				});
				$("#search_word").on("keydown", function (e) {
					if (e.keyCode == 13) {
						if ($("#search_word").val() == ""){
							$("#search_clean").val("1");
						}
						$( "#search_form" ).submit();
					}
				});
				/*
				$("#search_word").donetyping(function(){
					if ($("#search_word").val() == ""){
						$("#search_clean").val("1");
					}
					$( "#search_form" ).submit();
				});
				*/
				$("#search_word").focus();
			});

            function jconfirm(pregunta,mensaje,id){
                swal({
                    title: pregunta,
                    text: mensaje,
                    type: "error",
                    showCancelButton: true,
                    confirmButtonColor: "#CA002D",
                    confirmButtonText: "<i class='fa fa-check'></i> ¡Si, eliminar!",
                    cancelButtonText: "<i class='fa fa-times'></i> Cancelar",
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: true
                }).then(function() {
                     location.href = "${request.contextPath}/userLG/remove/"+id;
                });
            }

            function restart(id){
                swal({
                    title: '<g:message code="default.restart.ask.message" default="Do you want continue?"/>',
                    text: '<g:message code="default.restart.info.message" default="The password will be restart using the nick name"/>',
                    type: 'question',
                    showCancelButton: true,
                    confirmButtonColor: "#FFD100",
                    confirmButtonText: "<i class='fa fa-check'></i> ¡Si, continuar!",
                    cancelButtonText: "<i class='fa fa-times'></i> Cancelar",
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: true
                }).then(function() {
					location.href = "${request.contextPath}/userLG/restart/"+id;
                });
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
			  <li class="active"><g:message code="default.list.label" args="[entitiesName]" /></li>
			</ul>
		  </div>
		</div>
		<!-- .breadcrumb-box -->
        <a href="#list-userLG" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav_topbar" role="navigation">
            <ul>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <div class="col-xs-6 col-xs-offset-2" style="float:right;padding: 0px;">
					<g:if test="${userLGCount != 0 || session.getAttribute('userLG_search_word')}">
					<g:form action="index" method="POST" name="search_form">
						<div class="input-group">
							<div class="input-group-btn search-panel">
								<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									<span id="search_concept">${session.getAttribute('userLG_search_rows')} Registros</span> <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu">
								  <li><a href="#10">10 Registros</a></li>
								  <li><a href="#20">20 Registros</a></li>
								  <li><a href="#50">50 Registros</a></li>
								  <li><a href="#100">100 Registros</a></li>
								</ul>
							</div>
							<input type="hidden" name="search_rows" id="search_rows" value="${session.getAttribute('userLG_search_rows')}">
							<input type="hidden" name="search_clean" id="search_clean" value="0">
							<input type="text" class="form-control" name="search_word" id="search_word" placeholder="Palabra a buscar..." value="${session.getAttribute('userLG_search_word')}">
							<span class="input-group-btn">
								<button id="btn-search" class="btn btn-primary" type="button"><li class="fa fa-search fa-lg"></li></button>
							</span>
						</div>
					</g:form>
					</g:if>
				</div>
            </ul>
        </div>
        <div id="list-userLG" class="content scaffold-list" role="main">
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
            </br>
			<!--
            <f:table collection="${userLGList}" properties="['username', 'accountLocked', 'accountExpired', 'passwordExpired', 'enabled']"/>
			-->
            <table>
				<g:if test="${userLGCount != 0}">
                <thead>
                    <tr>
						<g:sortableColumn property="nombre" title="${message(code: 'userLG.nombre.label', default: 'Name')}" style="width:350px;"/>
                        <g:sortableColumn property="username" title="${message(code: 'userLG.username.label', default: 'User')}" />
                        <th><g:message code="userLG.rol.label" default="Role" /></th>
                        <g:sortableColumn property="accountLocked" title="${message(code: 'userLG.accountLocked.label', default: 'Account lock')}" />
                        <g:sortableColumn property="accountExpired" title="${message(code: 'userLG.accountExpired.label', default: 'Account expired')}" />
                        <g:sortableColumn property="passwordExpired" title="${message(code: 'userLG.passwordExpired.label', default: 'Password expired')}" />
                        <g:sortableColumn property="enabled" title="${message(code: 'userLG.enabled.label', default: 'Enabled')}" style="text-align:center"/>
                        <th style="width:100px" class="sortable"><a href="#"><g:message code="default.actions.label" default="Actions" /></a></th>
                    </tr>
                </thead>
				</g:if>
                <tbody>
                    <g:each in="${userLGList}" var="user" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:link method="GET" resource="${user}">${user.nombre}</g:link></td>
                            <td>${user.username}</td>
                            <td>${user.getRolName()}</td>
                            <td>${user.accountLocked==false?"No":"Sí"}</td>
                            <td>${user.accountExpired==false?"No":"Sí"}</td>
                            <td>${user.passwordExpired==false?"No":"Sí"}</td>
                            <td class="celda_centrada">
								<center>
								<g:if test="${user.enabled}">
									<g:link action="active" resource="${user}" title="¡Desactivar!" >
										<input class="js-switch" checked="" style="display: none;" type="checkbox">	
									</g:link>
								</g:if>
								<g:else>
									<g:link class="js-switch" action="active" resource="${user}" title="¡Activar!">
										<input class="js-switch" style="display: none;" type="checkbox">	
									</g:link>
								</g:else>
								</center>
							</td>
                            <td style="width:100px;">
								<center>
									<a class="operations_icon" onclick="restart('${user.id}')" title="¡Restablecer contraseña!"><li class="fa fa-key"></li></a>
									<a class="operations_icon red" onclick="jconfirm('${message(code: 'default.delete.ask.message', default: 'Are you sure?')}','${message(code: 'default.delete.info_personal.message', default: 'You are deleting the record.', args:[user.username])}','${user.id}');" title="¡Eliminar!"><li class="fa fa-trash"></li></a>
								</center>
							</td>
                        </tr>
                    </g:each>
                    <g:if test="${userLGCount == 0}">
						<tr>
							<sec:ifAnyGranted roles='ROLE_PROGRAMMER'>
								<td colspan="9" style="text-align:center"></br></br><img src="${request.contextPath}/assets/empty/default.png" border="0px"/></br><span style="font-size:18px;color:#515151;"><g:message code="default.table.empty.label" args="[entitiesName.toLowerCase()]"/></span></br></br></td>
							</sec:ifAnyGranted>
							<sec:ifNotGranted roles="ROLE_PROGRAMMER">
								<td colspan="8" style="text-align:center"></br></br><img src="${request.contextPath}/assets/empty/default.png" border="0px"/></br><span style="font-size:18px;color:#515151;"><g:message code="default.table.empty.label" args="[entitiesName.toLowerCase()]"/></span></br></br></td>
							</sec:ifNotGranted>
						</tr>
                    </g:if>
                </tbody>
            </table>
            <div class="pagination">
                <g:paginate total="${userLGCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
