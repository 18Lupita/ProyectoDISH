    <content tag="nav">
    <sec:ifLoggedIn>
		<sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_PROGRAMMER,ROLE_VISOR'>
			<li class="dropdown">
				<a href="${request.contextPath}/">
				<i class="fa fa-home fa" aria-hidden="true"></i></br>
				Inicio
				</a>
			</li>
		</sec:ifAnyGranted> 
		<sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_PROGRAMMER'>
			<li class="dropdown">
				<a href="${request.contextPath}/proyecto/index">
				<i class="fa fa-heart" aria-hidden="true"></i></br>
				Proyectos
				</a>
			</li>
			<li class="dropdown">
				<a href="${request.contextPath}/desarrollador/index">
				<i class="fa fa-users" aria-hidden="true"></i></br>
				Desarrolladores
				</a>
			</li>
		</sec:ifAnyGranted>
		<sec:ifAnyGranted roles='ROLE_VISOR'>
			<li class="dropdown">
				<a href="${request.contextPath}/proyecto/index">
				<i class="fa fa-heart" aria-hidden="true"></i></br>
				Proyectos
				</a>
			</li>
		</sec:ifAnyGranted>
		<sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_PROGRAMMER,ROLE_VISOR'>
			<li class="dropdown">
				<a href="${request.contextPath}/logout">
				<i class="fa fa-users" aria-hidden="true"></i></br>
				Cerrar sesión
				</a>
			</li>
		</sec:ifAnyGranted>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
		<!--
        <li class="dropdown">
			<a href="${request.contextPath}/login/auth" class="dropdown-toggle" role="button" aria-haspopup="true" aria-expanded="false">Ingresar <img src="${request.contextPath}/assets/caret_login.png" border="0"></a>
        </li>
        -->
    </sec:ifNotLoggedIn>
    </content>
