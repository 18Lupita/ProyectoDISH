<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'userLGRoleLG.label', default: 'Usuario-Rol')}" />
        <g:set var="entitiesName" value="${message(code: 'userLGRoleLG.label', default: 'Usuarios-Roles')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
		<g:render template="/layouts/menu" />
        <a href="#list-userLGRoleLG" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-userLGRoleLG" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entitiesName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status" style="float:left;width:97%">${flash.message}</div>
            </g:if>
            <!--
            <f:table collection="${userLGRoleLGList}" />
			-->
			
			<table>
                <thead>
                    <tr>
                        <g:sortableColumn property="userLG" title="${message(code: 'userLGroleLG.userLG.label', default: 'User')}" />
                        <g:sortableColumn property="roleLG" title="${message(code: 'userLGroleLG.roleLG.label', default: 'Role')}" />
                    </tr>
                </thead>

                <tbody>
                    <g:each in="${userLGRoleLGList}" var="userLGRoleLG" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:link method="GET" resource="${[userLGRoleLG.userLG,userLGRoleLG.roleLG.id]}">${userLGRoleLG.userLG.toString().replaceAll("UserLG\\(username:", "").replaceAll("\\)", "")}</g:link></td>
                            <td>${userLGRoleLG.roleLG.toString().replaceAll("RoleLG\\(authority:", "").replaceAll("\\)", "")}</td>
                        </tr>
                    </g:each>
                </tbody>
            </table>


            <div class="pagination">
                <g:paginate total="${userLGRoleLGCount ?: 0}" />
            </div>
        </div>
    </body>
</html>
