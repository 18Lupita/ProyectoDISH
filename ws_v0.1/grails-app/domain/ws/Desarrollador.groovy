package ws
/**
 * @file Desarrollador.groovy
 * @version 0.1
 * @author Guadalupe Martinez Vazquez
 * @date   24-abril-2019
 * @description Clase Desarrollador.
 */
class Desarrollador {

	String	id
    String	nombre
    String	telefono
    String	domicilio
    Boolean	isManager
    UserLG	id_Autor
	boolean enabled = Boolean.TRUE
	
    static constraints = {
		id				(nullable:true)
		nombre			(nullable:false)
		telefono		(nullable:true)
		domicilio		(nullable:true, widget: 'textarea')
		isManager		(nullable:false)
        id_Autor		(nullable:true, widget:'display')
    }

    static mapping = {
		sort nombre: "asc"
		table 'DESARROLLADORES'
		version false
		id column: "ID", generator : 'uuid'
        id_Autor column:'id_autor'
        isManager column:'ismanager', sqlType: 'bool'
    }

    String toString() {
        return nombre 
    }
}
