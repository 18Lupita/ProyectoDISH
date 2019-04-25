package ws
/**
 * @file Proyecto.groovy
 * @version 0.1
 * @author Guadalupe Martinez Vazquez
 * @date   24-abril-2019
 * @description Clase Proyecto.
 */
class Proyecto {

	String	id
    String	nombre
    String	descripcion
    Desarrollador	projectManager
    Date    dateCreated
    Date    lastUpdated
    String	status
    String  observacion
    UserLG	id_Autor
	boolean enabled = Boolean.TRUE

    static hasMany = [desarrolladores: Desarrollador]
	
    static constraints = {
		id				(nullable:true)
		nombre			(nullable:false)
		descripcion		(nullable:true, widget: 'textarea')
		projectManager  (nullable:true)
		dateCreated	    (widget:'display')
		lastUpdated		(widget:'display')
		status			(nullable:false, inList: ["Nuevo", "En proceso", "Terminado"])
        observacion     (nullable:true, widget: 'textarea')
        id_Autor		(nullable:true, widget:'display')
        desarrolladores (nullable:true, display: false, widget:'hidden')
    }

    static mapping = {
		sort nombre: "asc"
		table 'PROYECTOS'
		version false
		id column: "ID", generator : 'uuid'
        id_Autor column:'id_autor'
    }

    String toString() {
        return nombre 
    }
}
