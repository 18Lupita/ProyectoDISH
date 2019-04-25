environments {
    development {
        uploadFolder = "C:/Users/1200/Documents/Grails/ws_v0.1/grails-app/assets/images/"
        serverAddress = "http://74.208.120.163/ws/"
        jasper_serverAddress = "/jasperserver/"
        jasper_user = "jasperadmin"
        jasper_password = "jasperadmin"
    }
    test {
        uploadFolder = "/opt/bitnami/apache-tomcat/webapps/ws/assets/"
        serverAddress = "http://74.208.120.163/ws/"
        jasper_serverAddress = "/jasperserver/"
        jasper_user = "jasperadmin"
        jasper_password = "jasperadmin"
    }
    production {
        uploadFolder = "/opt/bitnami/apache-tomcat/webapps/ws/assets/"
        serverAddress = "http://74.208.120.163/ws/"
        jasper_serverAddress = "/jasperserver/"
        jasper_user = "jasperadmin"
        jasper_password = "jasperadmin"
    }
}

grails.plugin.databasemigration.updateOnStart = true
grails.plugin.databasemigration.updateOnStartFileNames = ['changelog.groovy']


// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.useSecurityEventListener = true
grails.plugin.springsecurity.userLookup.userDomainClassName = 'ws.UserLG'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'ws.UserLGRoleLG'
grails.plugin.springsecurity.authority.className = 'ws.RoleLG'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/*',				 access: ['permitAll']],
	[pattern: '/public/*',		 access: ['permitAll']],
	[pattern: '/main/index',     access: ['permitAll']],
	[pattern: '/portal/*',		 access: ['permitAll']],
	[pattern: '/WS_Proyecto/*',  access: ['permitAll']],
	
	[pattern: '/proyecto/*',     access: ['ROLE_ADMIN', 'ROLE_VISOR', 'ROLE_PROGRAMMER']],
	[pattern: '/desarrollador/*',     access: ['ROLE_ADMIN', 'ROLE_PROGRAMMER']],
	[pattern: '/userLG/myuser',  access: ['ROLE_ADMIN', 'ROLE_PROGRAMMER']],
	[pattern: '/userLG/updateMyuser',   access: ['ROLE_ADMIN', 'ROLE_PROGRAMMER']],
	[pattern: '/userLG/*',       access: ['ROLE_ADMIN', 'ROLE_PROGRAMMER']],
	[pattern: '/userLGRoleLG/*', access: ['ROLE_ADMIN', 'ROLE_PROGRAMMER']],
	[pattern: '/logout/*',       access: ['permitAll']],
	
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]
