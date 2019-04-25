package ws

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserLGController {
	//Identificación de la sesion del usuario
    def springSecurityService;
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		
		if (!session.getAttribute("controller_active").equals("UserLG")){
			session.setAttribute("controller_active", "UserLG");
			session.setAttribute("userLG_search_rows", 10);
			session.setAttribute("userLG_search_word", "");
			session.setAttribute("userLG_search_offset", 0);
		}
		
		//Recuperación de la pagina en que se encuentra
        if (params.offset){
			
        }else if (session.getAttribute("userLG_search_offset")){
			params.offset = session.getAttribute("userLG_search_offset");
        } else {
			params.offset = 0;
        }
		//Recuperación de limite maximo de registros visibles
		if (params.search_rows) {
			if (params.search_rows != session.getAttribute("userLG_search_rows")) params.offset = 0;
			params.max = params.search_rows.toInteger();
        } else if (session.getAttribute("userLG_search_rows")){
			params.max = session.getAttribute("userLG_search_rows").toInteger();
        } else {
			params.max = 10;
        }
        params.search_rows = params.max;
        //Recuperando la palabra de busqueda
        if (params.search_clean == "1") {
			params.search_word = "";
			params.offset = 0;
		} else if (params.search_word){
			//Enviada la palabra a buscar
			if (params.search_word != session.getAttribute("userLG_search_word")) params.offset = 0;
        } else if (session.getAttribute("userLG_search_word")){
			params.search_word = session.getAttribute("userLG_search_word");
        }
        
        def userLGList = UserLG.createCriteria().list (params) {
            if ( params.search_word ) {
				or {
					ilike("nombre", "%${params.search_word}%")
					ilike("username", "%${params.search_word}%")
				}
            }
            
            if (session.getAttribute("username_rolActivo") != "ROLE_PROGRAMMER"){
				sqlRestriction """ exists (SELECT * FROM userlgrolelg ur, rolelg r
										   WHERE this_.id = ur.userlg_id and ur.rolelg_id = r.id
										   AND r.authority != 'ROLE_PROGRAMADOR')"""
			}
            
            if ( !params.sort ){
				order("nombre","asc");
            }
        }
        
        session.setAttribute("userLG_search_rows", params.search_rows.toString());
        session.setAttribute("userLG_search_word", params.search_word);
        session.setAttribute("userLG_search_offset", params.offset.toString());
        
        respond userLGList, model:[userLGCount: userLGList.totalCount]
    }

    def show(UserLG userLG) {
		if (userLG == null) {
            notFound()
            return
        }
		userLG.decodePassword()
        respond userLG
    }
	
	def myuser() {
		String username = principal.username;
		UserLG userLG = UserLG.find("FROM UserLG as u WHERE u.username='"+username+"'");
 		if (userLG == null) {
            notFound()
            return
        }
		userLG.decodePassword()
        respond userLG
    }
	
	@Transactional
    def restart(UserLG userLG) {
		/*Alumnos alumno = Alumnos.find("FROM Alumnos as a WHERE a.matricula='"+userLG.username+"'")
		if (alumno){
			String contrasena_tmp = "UAEM_"+alumno.matricula
			if (alumno.curp.length() > 0){
				contrasena_tmp = alumno.curp
			}
			userLG.password = contrasena_tmp
			userLG.save flush:true
		}*/
		userLG.decodePassword()
		flash.message = message(code: 'default.restarted.message', args: [message(code: 'userLG.label', default: 'Registro'), userLG.username])
        //redirect action:"show", id:userLG.id
        redirect action:"index", method:"GET"
    }
	
	@Transactional
    def active(UserLG userLG) {
		userLG.enabled = !userLG.enabled
		userLG.password = userLG.password_plain
		userLG.save flush:true
		userLG.decodePassword()
        flash.message = message(code: 'default.reactive.message', args: [message(code: 'userLG.label', default: 'Registro'), userLG.username, (userLG.enabled?'activado':'desactivado')])
        //redirect action:"show", id:userLG.id
        redirect action:"index", method:"GET"
    }

    def create() {
		String mensaje_error = "";
		if (mensaje_error == ""){
			UserLG userLG = new UserLG(params)
			if (springSecurityService.principal)
				userLG.id_Autor = UserLG.findById(springSecurityService.principal.id);
			
			def Roles = RoleLG.list();
			if (session.getAttribute('username_rolActivo') == "ROLE_ADMIN"){
				for(int i=Roles.size()-1; i>=0; i--){
					String rol = Roles.get(i).authority;
					if(rol.equals("ROLE_PROGRAMMER")){ 
						Roles.remove(i);
					}
				}
			}
			
			respond userLG, model:[roles:Roles]
        }else{
			flash.message = mensaje_error;
			redirect action:"index", method:"GET"
        }
    }

    @Transactional
    def save(UserLG userLG) {
        if (userLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
		
		UserLG usuario = UserLG.find("FROM  UserLG AS u WHERE u.username='" + userLG.username + "'");
		if (usuario != null) {
			userLG.errors.rejectValue('username', userLG.username, 'El nombre de usuario que indico fue previamente registrado');
		}
		
		def Roles = RoleLG.list();
		if (session.getAttribute('username_rolActivo') == "ROLE_ADMIN"){
		    for(int i=Roles.size()-1; i>=0; i--){
				String rol = Roles.get(i).authority;
				if(rol.equals("ROLE_PROGRAMMER")){ 
                    Roles.remove(i);
                }
            }
		}
		
        if (userLG.hasErrors()) {
			transactionStatus.setRollbackOnly()
            respond userLG.errors, view:'create', model:[roles:Roles]
            return
        }
        
        // Recupera el id del autor
		if (springSecurityService.principal)
			userLG.id_Autor = UserLG.findById(springSecurityService.principal.id);

        userLG.save flush:true

        // Asignar rol
        UserLGRoleLG.create userLG, RoleLG.findById(params.role)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userLG.label', default: 'Registro'), userLG.username])
                //redirect userLG
                redirect action:"index", method:"GET"
            }
            '*' { respond userLG, [status: CREATED] }
        }
    }
	
	@Transactional
    def updateMyUser(UserLG userLG) {
    
        if (userLG == null) {
            transactionStatus.setRollbackOnly()
            //notFound()
            respond userLG.errors, view:'myuser', model:[roles:Roles]
            return
        }
        
        UserLG usuario = UserLG.find("FROM UserLG AS u WHERE u.username='" + userLG.username + "' AND u.id!="+userLG.id);
		if (usuario != null) {
			userLG.errors.rejectValue('username', userLG.username, 'El nombre de usuario que ha indicado ya fue previamente registrado');
		}
        
        if (userLG.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userLG.errors, view:'myuser'
            return
        }
        userLG.save flush:true

        // Actualizar rol
        if( params.long('role') != userLG.getRolID() ) {
            UserLGRoleLG.removeAll(userLG, true)
            UserLGRoleLG.create userLG, RoleLG.findById(params.role), true
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Usuario', default: 'Registro'), userLG.username])
                redirect action: "myuser"
            }
            '*'{ respond userLG, [status: OK] }
        }
    }
	
    def edit(UserLG userLG) {
		userLG.decodePassword()
		def Roles = RoleLG.list();
		if (session.getAttribute('username_rolActivo') == "ROLE_ADMIN"){
		    for(int i=Roles.size()-1; i>=0; i--){
				String rol = Roles.get(i).authority;
				if(rol.equals("ROLE_PROGRAMMER")){ 
                    Roles.remove(i);
                }
            }
		}
		respond userLG, model:[roles:Roles]
    }

    @Transactional
    def update(UserLG userLG) {
        if (userLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
		
		def Roles = RoleLG.list();
		if (session.getAttribute('username_rolActivo') == "ROLE_ADMIN"){
		    for(int i=Roles.size()-1; i>=0; i--){
				String rol = Roles.get(i).authority;
				if(rol.equals("ROLE_PROGRAMMER")){ 
                    Roles.remove(i);
                }
            }
		}
		
        if (userLG.hasErrors()) {
			transactionStatus.setRollbackOnly()
            respond userLG.errors, view:'edit', model:[roles:Roles]
            return
        }

        userLG.save flush:true

        // Actualizar rol
        if( params.long('role') != userLG.getRolID() ) {
            UserLGRoleLG.removeAll(userLG, true)
            UserLGRoleLG.create userLG, RoleLG.findById(params.role), true
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Usuario', default: 'Registro'), userLG.username])
                //redirect userLG
                redirect action:"index", method:"GET"
            }
            '*'{ respond userLG, [status: OK] }
        }
    }

    @Transactional
    def delete(UserLG userLG) {

        if (userLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
		if (TipoEquipo.findAll("from TipoEquipo as items where items.id_Autor.id = '"+userLG.id+"'").toList().size() > 0 ||
			TipoIdentificacion.findAll("from TipoIdentificacion as items where items.id_Autor.id = '"+userLG.id+"'").toList().size() > 0 ){
			
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userLG.label', default: 'Usuario'), userLG.username, 'de Visitantes u otras entidades'])
			
		}else{
			UserLGRoleLG.executeUpdate("DELETE FROM tribius.UserLGRoleLG as ur WHERE ur.userLG.id="+userLG.id.toString())
			userLG.delete flush:true
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userLG.label', default: 'Usuario'), userLG.username])
		}

        request.withFormat {
            form multipartForm {
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
	
	@Transactional
    def remove(UserLG userLG) {

        if (userLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }
        
        if (TipoEquipo.findAll("from TipoEquipo as items where items.id_Autor.id = '"+userLG.id+"'").toList().size() > 0 ||
			TipoIdentificacion.findAll("from TipoIdentificacion as items where items.id_Autor.id = '"+userLG.id+"'").toList().size() > 0 ){
			
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userLG.label', default: 'Usuario'), userLG.username, 'de Visitantes u otras entidades'])
			
		}else{
			UserLGRoleLG.executeUpdate("DELETE FROM tribius.UserLGRoleLG as ur WHERE ur.userLG.id="+userLG.id.toString())
			userLG.delete flush:true
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'userLG.label', default: 'Usuario'), userLG.username])
		}
		
        redirect action:"index", method:"GET"
    }
	
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userLG.label', default: 'Registro'), params.username])
                redirect action: "index"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
