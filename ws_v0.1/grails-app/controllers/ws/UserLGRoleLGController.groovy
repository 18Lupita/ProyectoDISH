package ws

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserLGRoleLGController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UserLGRoleLG.list(params), model:[userLGRoleLGCount: UserLGRoleLG.count()]
    }

    def show(UserLGRoleLG userLGRoleLG) {
        respond userLGRoleLG
    }

    def create() {
        respond new UserLGRoleLG(params)
    }

    @Transactional
    def save(UserLGRoleLG userLGRoleLG) {
        if (userLGRoleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userLGRoleLG.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userLGRoleLG.errors, view:'create'
            return
        }

        userLGRoleLG.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'userLGRoleLG.label', default: 'UserLGRoleLG'), userLGRoleLG.id])
                redirect userLGRoleLG
            }
            '*' { respond userLGRoleLG, [status: CREATED] }
        }
    }

    def edit(UserLGRoleLG userLGRoleLG) {
        respond userLGRoleLG
    }

    @Transactional
    def update(UserLGRoleLG userLGRoleLG) {
        if (userLGRoleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (userLGRoleLG.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond userLGRoleLG.errors, view:'edit'
            return
        }

        userLGRoleLG.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'userLGRoleLG.label', default: 'UserLGRoleLG'), userLGRoleLG.id])
                redirect userLGRoleLG
            }
            '*'{ respond userLGRoleLG, [status: OK] }
        }
    }

    @Transactional
    def delete(UserLGRoleLG userLGRoleLG) {

        if (userLGRoleLG == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        userLGRoleLG.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'userLGRoleLG.label', default: 'UserLGRoleLG'), userLGRoleLG.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'userLGRoleLG.label', default: 'UserLGRoleLG'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
