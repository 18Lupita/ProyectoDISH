package ws

import static org.springframework.http.HttpStatus.*
import org.springframework.transaction.TransactionStatus
import grails.transaction.*

@Transactional(readOnly = true)
class RoleLGController {
    //Identificación de la sesion del usuario
    def springSecurityService;
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		if (!session.getAttribute("controller_active").equals("RoleLG")){
			session.setAttribute("controller_active", "RoleLG");
			session.setAttribute("roleLG_search_rows", 10);
			session.setAttribute("roleLG_search_word", "");
			session.setAttribute("roleLG_search_offset", 0);
		}
		
        //Recuperación de la pagina en que se encuentra
        if (params.offset){
			
        }else if (session.getAttribute("roleLG_search_offset")){
			params.offset = session.getAttribute("roleLG_search_offset");
        } else {
			params.offset = 0;
        }
		//Recuperación de limite maximo de registros visibles
		if (params.search_rows) {
			if (params.search_rows != session.getAttribute("roleLG_search_rows")) params.offset = 0;
			params.max = params.search_rows.toInteger();
        } else if (session.getAttribute("roleLG_search_rows")){
			params.max = session.getAttribute("roleLG_search_rows").toInteger();
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
			if (params.search_word != session.getAttribute("roleLG_search_word")) params.offset = 0;
        } else if (session.getAttribute("roleLG_search_word")){
			params.search_word = session.getAttribute("roleLG_search_word");
        }
        
        def itemsList = RoleLG.createCriteria().list (params) {
			/*
            if ( params.search_word ) {
				or {
					ilike("nombre_1", "%${params.search_word}%")
					ilike("nombre_2", "%${params.search_word}%")
				}
            }
            */
            if ( params.search_word ) {
				ilike("nombre", "%${params.search_word}%")
            }
        }
        
        session.setAttribute("roleLG_search_rows", params.search_rows);
        session.setAttribute("roleLG_search_word", params.search_word);
        session.setAttribute("roleLG_search_offset", params.offset);
        
        respond itemsList, model:[roleLGCount: itemsList.totalCount]
    }

    def show(RoleLG roleLG) {
        respond roleLG
    }

    def create() {
        respond new RoleLG(params)
    }

    @Transactional
    def save(RoleLG roleLG) {
        if (roleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (roleLG.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond roleLG.errors, view:'create'
            return
        }
		
		/*
		int id = 0;
        if (RoleLG.createCriteria().get {projections {max "id"}} as Integer != null){
           id = RoleLG.createCriteria().get {projections {max "id"}} as int
        }
        id++
         roleLG.id = id
        */
        
        // Recupera el id del autor
		if (springSecurityService.principal)
			roleLG.id_Autor = UserLG.findById(springSecurityService.principal.id);
		
        roleLG.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'roleLG.label', default: 'RoleLG'), roleLG.id])
                redirect roleLG
            }
            '*' { respond roleLG, [status: CREATED] }
        }
    }

    def edit(RoleLG roleLG) {
        respond roleLG
    }

    @Transactional
    def update(RoleLG roleLG) {
        if (roleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (roleLG.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond roleLG.errors, view:'edit'
            return
        }

        roleLG.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'roleLG.label', default: 'RoleLG'), roleLG.id])
                redirect roleLG
            }
            '*'{ respond roleLG, [status: OK] }
        }
    }

    @Transactional
    def delete(RoleLG roleLG) {

        if (roleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        roleLG.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'roleLG.label', default: 'RoleLG'), roleLG.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    @Transactional
    def remove(RoleLG roleLG) {

        if (roleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        roleLG.delete flush:true

		flash.message = message(code: 'default.deleted.message', args: [message(code: 'roleLG.label', default: 'RoleLG'), roleLG.id])
		redirect action:"index", method:"GET"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'roleLG.label', default: 'RoleLG'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
