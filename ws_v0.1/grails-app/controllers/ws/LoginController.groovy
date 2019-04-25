package ws

import grails.converters.JSON
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.authentication.AccountExpiredException
import org.springframework.security.authentication.CredentialsExpiredException
import org.springframework.security.authentication.DisabledException
import org.springframework.security.authentication.LockedException
import org.springframework.security.core.Authentication
import org.springframework.security.core.context.SecurityContextHolder
import org.springframework.security.web.WebAttributes
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.security.access.annotation.Secured
import org.springframework.security.authentication.AuthenticationTrustResolver

//import org.grails.web.servlet.mvc.GrailsWebRequest

import org.springframework.web.context.request.RequestContextHolder
import javax.servlet.http.HttpServletResponse

@Secured('permitAll')
class LoginController {
	
	/** Dependency injection for the authenticationTrustResolver. */
	AuthenticationTrustResolver authenticationTrustResolver

	/** Dependency injection for the springSecurityService. */
	def springSecurityService
	
	/** Default action; redirects to 'defaultTargetUrl' if logged in, /login/auth otherwise. */
	def index() {
		if (springSecurityService.isLoggedIn()) {
			redirect uri: conf.successHandler.defaultTargetUrl
		}
		else {
			redirect action: 'auth', params: params
		}
	}
	
	def noInscrito(String username){
		flash.message = username + " NO se encuentra inscrito actualmente.";
		redirect action: 'auth', params: params
	}
	
	def noHora(String horario){
		if (horario != "") {
			flash.message = "Su horario de acceso es " + horario + ".";
		} else {
			flash.message = "No existe un horario definido para su acceso a\u00fan.";
		}
		redirect action: 'auth', params: params
	}
	
	def noSesion(String username, String fingreso){
		flash.message = username + " tiene una sesi\u00f3n abierta.";
		redirect action: 'auth', params: params
	}
	
	def checkTime() {
		String sessionId = RequestContextHolder.getRequestAttributes()?.getSessionId()
		//print "Session:"+sessionId
		
		//Eliminando el ciclo de redireccionamiento infinito
		session.setAttribute("redirect", "");
		
		def isInscrito = true;
		def isHora = false;
		String horario = "";
		def isSesion = false;
		String fingreso = "";
		
		def principal = springSecurityService.principal;
        String username = principal.username;
        int user_id = principal.id;
        
        //println username;
        //println user_id;
        
		username = toTitleCase(username);
		session.setAttribute("username_main", username);
		
		
		//Buscando el usuario por el ID
		UserLG usuario = UserLG.findById(user_id)
        if (usuario) {
			//Recuperando información del usuario para pasarla a variables de sesion
			session.setAttribute("username_nombre", usuario.nombre);
			/*
			if (usuario.archivo_Foto){
				session.setAttribute("username_archivo_Foto", usuario.archivo_Foto);
			}else{
				session.setAttribute("username_archivo_Foto", "default.png");
			}
			*/
			session.setAttribute("username_rolActivoNombre", usuario.getRolName());
			session.setAttribute("username_rolActivo", usuario.getRol());
		}
		
		
		Date now = new Date();
		
		//Validando que el usuario este inscrito
		if (!isInscrito){
			session.invalidate();
			/*
			GrailsWebRequest request = RequestContextHolder.currentRequestAttributes()
			GrailsWebRequest.lookup(request).session = null
			*/
			redirect action: 'noInscrito', params: [username: username]
			//redirect uri: SpringSecurityUtils.securityConfig.logout.filterProcessesUrl + "?spring-security-redirect=login/auth";
		}else{
			isHora = true;
			
			//Elimina la validación de horario para los usuarios no estudiantes
			if (SecurityContextHolder.getContext().getAuthentication().getAuthorities().toString() != "[ROLE_STUDENT]") isHora = true;
			
			if (!isHora) {
				session.invalidate();
				redirect action: 'noHora', params: [horario: horario]
			} else {
				//Validando la sesion
				isSesion = false;
				if (springSecurityService.isLoggedIn()) {
					redirect uri: conf.successHandler.defaultTargetUrl
				} else {
					redirect action: 'auth', params: params
				}
			}
		}
	}
	
	/** Show the login page. */
	def auth() {
		def conf = getConf()

		if (springSecurityService.isLoggedIn()) {
			redirect uri: conf.successHandler.defaultTargetUrl
			return
		}

		String postUrl = request.contextPath + conf.apf.filterProcessesUrl
		render view: 'auth', model: [postUrl: postUrl,
		                             rememberMeParameter: conf.rememberMe.parameter,
		                             usernameParameter: conf.apf.usernameParameter,
		                             passwordParameter: conf.apf.passwordParameter,
		                             gspLayout: conf.gsp.layoutAuth]
	}

	/** The redirect action for Ajax requests. */
	def authAjax() {
		response.setHeader 'Location', conf.auth.ajaxLoginFormUrl
		render(status: HttpServletResponse.SC_UNAUTHORIZED, text: 'Unauthorized')
	}

	/** Show denied page. */
	def denied() {
		if (springSecurityService.isLoggedIn() && authenticationTrustResolver.isRememberMe(authentication)) {
			// have cookie but the page is guarded with IS_AUTHENTICATED_FULLY (or the equivalent expression)
			redirect action: 'full', params: params
			return
		}

		[gspLayout: conf.gsp.layoutDenied]
	}

	/** Login page for users with a remember-me cookie but accessing a IS_AUTHENTICATED_FULLY page. */
	def full() {
		def conf = getConf()
		render view: 'auth', params: params,
		       model: [hasCookie: authenticationTrustResolver.isRememberMe(authentication),
		               postUrl: request.contextPath + conf.apf.filterProcessesUrl,
		               rememberMeParameter: conf.rememberMe.parameter,
		               usernameParameter: conf.apf.usernameParameter,
		               passwordParameter: conf.apf.passwordParameter,
		               gspLayout: conf.gsp.layoutAuth]
	}
	
	/** Callback after a failed login. Redirects to the auth page with a warning message. */
	def authfail() {
		String msg = ''
		def exception = session[WebAttributes.AUTHENTICATION_EXCEPTION]
		if (exception) {
			if (exception instanceof AccountExpiredException) {
				msg = message(code: 'springSecurity.errors.login.expired')
			}
			else if (exception instanceof CredentialsExpiredException) {
				msg = message(code: 'springSecurity.errors.login.passwordExpired')
			}
			else if (exception instanceof DisabledException) {
				msg = message(code: 'springSecurity.errors.login.disabled')
			}
			else if (exception instanceof LockedException) {
				msg = message(code: 'springSecurity.errors.login.locked')
			}
			else {
				msg = message(code: 'springSecurity.errors.login.fail')
			}
		}

		if (springSecurityService.isAjax(request)) {
			render([error: msg] as JSON)
		}
		else {
			flash.message = msg
			redirect action: 'auth', params: params
		}
	}

	/** The Ajax success redirect url. */
	def ajaxSuccess() {
		render([success: true, username: authentication.name] as JSON)
	}

	/** The Ajax denied redirect url. */
	def ajaxDenied() {
		render([error: 'access denied'] as JSON)
	}

	protected Authentication getAuthentication() {
		SecurityContextHolder.context?.authentication
	}

	protected ConfigObject getConf() {
		SpringSecurityUtils.securityConfig
	}
	
	private String toTitleCase(String input) {
        StringBuilder titleCase = new StringBuilder();
        boolean nextTitleCase = true;
        for (char c : input.toCharArray()) {
            if (Character.isSpaceChar(c)) {
                nextTitleCase = true; //true = Hola Mundo Nuevo
            } else if (nextTitleCase) {
                c = Character.toUpperCase(c);
                nextTitleCase = false;
            }else{
                c = Character.toLowerCase(c);
            }
            titleCase.append(c);
        }
        return titleCase.toString();
    }
}
