package ws

import static org.springframework.http.HttpStatus.*
import org.springframework.transaction.TransactionStatus
import grails.transaction.*
import org.hibernate.SessionFactory;

@Transactional(readOnly = true)
class ProyectoController {
    SessionFactory sessionFactory;

    //Identificación de la sesion del usuario
    def springSecurityService;
    
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
		if (!session.getAttribute("controller_active").equals("Proyecto")){
			session.setAttribute("controller_active", "Proyecto");
			session.setAttribute("proyecto_search_rows", 10);
			session.setAttribute("proyecto_search_word", "");
			session.setAttribute("proyecto_search_offset", 0);
		}
		
        //Recuperación de la pagina en que se encuentra
        if (params.offset){
			
        }else if (session.getAttribute("proyecto_search_offset")){
			params.offset = session.getAttribute("proyecto_search_offset");
        } else {
			params.offset = 0;
        }
		//Recuperación de limite maximo de registros visibles
		if (params.search_rows) {
			if (params.search_rows != session.getAttribute("proyecto_search_rows")) params.offset = 0;
			params.max = params.search_rows.toInteger();
        } else if (session.getAttribute("proyecto_search_rows")){
			params.max = session.getAttribute("proyecto_search_rows").toInteger();
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
			if (params.search_word != session.getAttribute("proyecto_search_word")) params.offset = 0;
        } else if (session.getAttribute("proyecto_search_word")){
			params.search_word = session.getAttribute("proyecto_search_word");
        }

        
        def itemsList = Proyecto.createCriteria().list (params) {
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
            if ( !params.sort ){
                order("nombre","asc");
            }
        }
        
        session.setAttribute("proyecto_search_rows", params.search_rows);
        session.setAttribute("proyecto_search_word", params.search_word);
        session.setAttribute("proyecto_search_offset", params.offset);
        
        render(view:'index', model: [proyectoList:itemsList, proyectoCount: itemsList.totalCount])
        //respond itemsList, model:[proyectoCount: itemsList.totalCount]
    }

    def show(Proyecto proyecto, Integer offset) {
        if (!session.getAttribute("proyecto_show").equals(proyecto.id.toString())){
            session.setAttribute("proyecto_show", proyecto.id.toString());
            session.setAttribute("desarrollador_search_offset", 0);
        }
        
        if (params.offset){
            session.setAttribute("desarrollador_search_offset", offset);
        }else{
            if (!session.getAttribute("desarrollador_search_offset")){
                session.setAttribute("desarrollador_search_offset", 0);
            }
            params.offset=session.getAttribute("desarrollador_search_offset");
            params.max=10;
        }
        
        def orderField = "nombre"
        if (params.sort) {
            orderField = params.sort
        }
        def orderMethod = "asc"
        if (params.order) {
            orderMethod = params.order
        }
        
        respond proyecto
        
    }

    def create() {
        Proyecto proyecto = new Proyecto(params)
        if (springSecurityService.principal)
            proyecto.id_Autor = UserLG.findById(springSecurityService.principal.id);
        respond proyecto, model:[desarrolladoresList:Desarrollador.list()]
    }

    @Transactional
    def save(Proyecto proyecto) {
        if (proyecto == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (proyecto.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond proyecto.errors, view:'create', model:[desarrolladoresList:Desarrollador.list()]
            return
        }
		
		/*
		int id = 0;
        if (Proyecto.createCriteria().get {projections {max "id"}} as Integer != null){
           id = Proyecto.createCriteria().get {projections {max "id"}} as int
        }
        id++
         proyecto.id = id
        */
        
        // Recupera el id del autor
		if (springSecurityService.principal)
			proyecto.id_Autor = UserLG.findById(springSecurityService.principal.id);
		
        proyecto.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyecto.nombre])
                redirect proyecto
                //redirect action:"index", method:"GET"
            }
            '*' { respond proyecto, [status: CREATED] }
        }
    }

    def edit(Proyecto proyecto) {
        respond proyecto, model:[desarrolladoresList:Desarrollador.list()]
    }

    @Transactional
    def update(Proyecto proyecto) {
        if (proyecto == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (proyecto.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond proyecto.errors, view:'edit', model:[desarrolladoresList:Desarrollador.list()]
            return
        }

        //Borrar las bebidas no existentes en el expediente
        if (proyecto.desarrolladores != null){
            String desarrolladores = proyecto.desarrolladores.id.toString().replace("[","'").replace("]","'").replace(", ","','");
            String query = "DELETE FROM proyectos_desarrolladores WHERE proyecto_desarrolladores_id='${proyecto.id}' AND desarrollador_id NOT IN (${desarrolladores})";
            Integer rowsEffected = sessionFactory.getCurrentSession().createSQLQuery(query).executeUpdate();
        }

        proyecto.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyecto.nombre])
                //redirect proyecto
                redirect action:"index", method:"GET"
            }
            '*'{ respond proyecto, [status: OK] }
        }
    }

    @Transactional
    def delete(Proyecto proyecto) {

        if (proyecto == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        //proyecto.delete flush:true
        if (Desarrollador.findAll("from Desarrollador as items where items.proyecto.id = '"+proyecto.id+"'").toList().size() > 0){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'proyecto.label', default: 'Linea'), proyecto.nombre])
        }else{
            proyecto.delete flush:true
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'proyecto.label', default: 'Linea'), proyecto.nombre])
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyecto.nombre])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    
    @Transactional
    def remove(Proyecto proyecto) {

        if (proyecto == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        //proyecto.delete flush:true
        if (Desarrollador.findAll("from Desarrollador as items where items.proyecto.id = '"+proyecto.id+"'").toList().size() > 0){
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'proyecto.label', default: 'Linea'), proyecto.nombre])
        }else{
            proyecto.delete flush:true
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'proyecto.label', default: 'Linea'), proyecto.nombre])
        }

		flash.message = message(code: 'default.deleted.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), proyecto.nombre])
		redirect action:"index", method:"GET"
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'proyecto.label', default: 'Proyecto'), params.nombre])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
