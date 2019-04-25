package ws

import static org.springframework.http.HttpStatus.*
import org.springframework.transaction.TransactionStatus
import grails.transaction.*

@Transactional(readOnly = true)
class DesarrolladorController {
    //Identificación de la sesion del usuario
    def springSecurityService;
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		if (!session.getAttribute("controller_active").equals("Desarrollador")){
			session.setAttribute("controller_active", "Desarrollador");
			session.setAttribute("desarrollador_search_rows", 10);
			session.setAttribute("desarrollador_search_word", "");
			session.setAttribute("desarrollador_search_offset", 0);
		}
		
        //Recuperación de la pagina en que se encuentra
        if (params.offset){
			
        }else if (session.getAttribute("desarrollador_search_offset")){
			params.offset = session.getAttribute("desarrollador_search_offset");
        } else {
			params.offset = 0;
        }
		//Recuperación de limite maximo de registros visibles
		if (params.search_rows) {
			if (params.search_rows != session.getAttribute("desarrollador_search_rows")) params.offset = 0;
			params.max = params.search_rows.toInteger();
        } else if (session.getAttribute("desarrollador_search_rows")){
			params.max = session.getAttribute("desarrollador_search_rows").toInteger();
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
			if (params.search_word != session.getAttribute("desarrollador_search_word")) params.offset = 0;
        } else if (session.getAttribute("desarrollador_search_word")){
			params.search_word = session.getAttribute("desarrollador_search_word");
        }
        
        def itemsList = Desarrollador.createCriteria().list (params) {
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
        
        session.setAttribute("desarrollador_search_rows", params.search_rows);
        session.setAttribute("desarrollador_search_word", params.search_word);
        session.setAttribute("desarrollador_search_offset", params.offset);
        
        respond itemsList, model:[desarrolladorCount: itemsList.totalCount]
    }

    def show(Desarrollador desarrollador) {
        respond desarrollador
    }

    def create() {
        respond new Desarrollador(params)
    }

    @Transactional
    def save(Desarrollador desarrollador) {
        if (desarrollador == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (desarrollador.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond desarrollador.errors, view:'create'
            return
        }
		
		/*
		int id = 0;
        if (Desarrollador.createCriteria().get {projections {max "id"}} as Integer != null){
           id = Desarrollador.createCriteria().get {projections {max "id"}} as int
        }
        id++
         desarrollador.id = id
        */
        
        // Recupera el id del autor
		if (springSecurityService.principal)
			desarrollador.id_Autor = UserLG.findById(springSecurityService.principal.id);
		
        desarrollador.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'desarrollador.label', default: 'Desarrollador'), desarrollador.nombre])
                //redirect desarrollador
                redirect action:"index", method:"GET"
            }
            '*' { respond desarrollador, [status: CREATED] }
        }
    }

    def edit(Desarrollador desarrollador) {
        respond desarrollador
    }

    @Transactional
    def update(Desarrollador desarrollador) {
        if (desarrollador == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (desarrollador.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond desarrollador.errors, view:'edit'
            return
        }

        desarrollador.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'desarrollador.label', default: 'Desarrollador'), desarrollador.nombre])
                //redirect desarrollador
                redirect action:"index", method:"GET"
            }
            '*'{ respond desarrollador, [status: OK] }
        }
    }

    @Transactional
    def delete(Desarrollador desarrollador) {

        if (desarrollador == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        desarrollador.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'desarrollador.label', default: 'Desarrollador'), desarrollador.nombre])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    @Transactional
    def remove(Desarrollador desarrollador) {

        if (desarrollador == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        desarrollador.delete flush:true

		flash.message = message(code: 'default.deleted.message', args: [message(code: 'desarrollador.label', default: 'Desarrollador'), desarrollador.nombre])
		redirect action:"index", method:"GET"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'desarrollador.label', default: 'Desarrollador'), params.nombre])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
