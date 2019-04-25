import org.weykhans.LoginEventListener
import org.apache.catalina.filters.CorsFilter

// Place your Spring DSL code here
beans = {
	loginEventListener(LoginEventListener)
	corsFilter(CorsFilter)
	localeResolver(org.springframework.web.servlet.i18n.SessionLocaleResolver) {
      defaultLocale = new Locale("mx","MX")
      java.util.Locale.setDefault(defaultLocale)
   }
}
