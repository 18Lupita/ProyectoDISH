package ws

/**
 * @file BootStrap.groovy
 * @version 0.1
 * @author Guadalupe Martinez Vazquez
 * @date   24-abril-2019
 * @description Generar los datos iniciales en la base de datos.
 */

class BootStrap {
    //dbm-generate-gorm-changelog changelog.groovy and then ran dbm-update
    def init = { servletContext ->
		boolean flag;
        try {
            flag = true;
            println RoleLG.count().toString()
        }
        catch (Exception e) {
            flag = false;
        }
		if (flag){
			if (RoleLG.count()<1){
				/******roles*******/
				//Los roles siempre deben comenzar con ROLE_
				def programerRole = new RoleLG('Programador', 'ROLE_PROGRAMMER').save(failOnError: true, flush: true)
				def adminRole = new RoleLG('Administrador', 'ROLE_ADMIN').save(failOnError: true, flush: true)
				def visorRole = new RoleLG('Visor', 'ROLE_VISOR').save(failOnError: true, flush: true)
				/*******users********/
				def user0 = new UserLG('programador', 'C3yc@2208', 'Programador del sistema').save(failOnError: true, flush: true)
				def user1 = new UserLG('admin', 'admin', 'Administrador del sistema').save(failOnError: true, flush: true)
				def user2 = new UserLG('visor', 'visor', 'Visor del sistema').save(failOnError: true, flush: true)
				/*********** asignamos los roles a los users********/
				if (user0) UserLGRoleLG.create user0, programerRole, true
				if (user1) UserLGRoleLG.create user1, adminRole, true
				if (user2) UserLGRoleLG.create user2, visorRole, true
			}
		}
    }
    def destroy = {
    }
}
