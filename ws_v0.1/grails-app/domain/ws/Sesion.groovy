package ws

/**
 * @file Sesion.groovy
 * @version 0.1
 * @author Guadalupe Martinez Vazquez
 * @date   24-abril-2019
 * @description Clase Sesion.
 */

import javax.persistence.CascadeType;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Query;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull

class Sesion {

    //Atributos de la tabla
    int		id
    String	user_id
    String	sesion_no
    String	fingreso

    //Validaciones
    static constraints = {
        id(nullable:false)
        user_id(nullable:false)
        sesion_no(nullable:false)
        fingreso(nullable:false)
    }

    //Vinculación con la tabla de la BD
    static mapping = {
        table 'SESION'
        version false
        //columns {
            id column: "ID", generator: "assigned"
            user_id column:'USER_ID'
            sesion_no column:'SESION_NO'
            fingreso column:'FINGRESO'
        //}
    }
}
