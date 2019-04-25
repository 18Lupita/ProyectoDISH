package ws

import grails.test.mixin.*
import spock.lang.*

@TestFor(FamiliarController)
@Mock(Familiar)
class FamiliarControllerSpec extends Specification {

    def populateValidParams(params) {
        assert params != null

        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
        assert false, "TODO: Provide a populateValidParams() implementation for this generated test suite"
    }

    void "Test the index action returns the correct model"() {

        when:"The index action is executed"
            controller.index()

        then:"The model is correct"
            !model.familiarList
            model.familiarCount == 0
    }

    void "Test the create action returns the correct model"() {
        when:"The create action is executed"
            controller.create()

        then:"The model is correctly created"
            model.familiar!= null
    }

    void "Test the save action correctly persists an instance"() {

        when:"The save action is executed with an invalid instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'POST'
            def familiar = new Familiar()
            familiar.validate()
            controller.save(familiar)

        then:"The create view is rendered again with the correct model"
            model.familiar!= null
            view == 'create'

        when:"The save action is executed with a valid instance"
            response.reset()
            populateValidParams(params)
            familiar = new Familiar(params)

            controller.save(familiar)

        then:"A redirect is issued to the show action"
            response.redirectedUrl == '/familiar/show/1'
            controller.flash.message != null
            Familiar.count() == 1
    }

    void "Test that the show action returns the correct model"() {
        when:"The show action is executed with a null domain"
            controller.show(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the show action"
            populateValidParams(params)
            def familiar = new Familiar(params)
            controller.show(familiar)

        then:"A model is populated containing the domain instance"
            model.familiar == familiar
    }

    void "Test that the edit action returns the correct model"() {
        when:"The edit action is executed with a null domain"
            controller.edit(null)

        then:"A 404 error is returned"
            response.status == 404

        when:"A domain instance is passed to the edit action"
            populateValidParams(params)
            def familiar = new Familiar(params)
            controller.edit(familiar)

        then:"A model is populated containing the domain instance"
            model.familiar == familiar
    }

    void "Test the update action performs an update on a valid domain instance"() {
        when:"Update is called for a domain instance that doesn't exist"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'PUT'
            controller.update(null)

        then:"A 404 error is returned"
            response.redirectedUrl == '/familiar/index'
            flash.message != null

        when:"An invalid domain instance is passed to the update action"
            response.reset()
            def familiar = new Familiar()
            familiar.validate()
            controller.update(familiar)

        then:"The edit view is rendered again with the invalid instance"
            view == 'edit'
            model.familiar == familiar

        when:"A valid domain instance is passed to the update action"
            response.reset()
            populateValidParams(params)
            familiar = new Familiar(params).save(flush: true)
            controller.update(familiar)

        then:"A redirect is issued to the show action"
            familiar != null
            response.redirectedUrl == "/familiar/show/$familiar.id"
            flash.message != null
    }

    void "Test that the delete action deletes an instance if it exists"() {
        when:"The delete action is called for a null instance"
            request.contentType = FORM_CONTENT_TYPE
            request.method = 'DELETE'
            controller.delete(null)

        then:"A 404 is returned"
            response.redirectedUrl == '/familiar/index'
            flash.message != null

        when:"A domain instance is created"
            response.reset()
            populateValidParams(params)
            def familiar = new Familiar(params).save(flush: true)

        then:"It exists"
            Familiar.count() == 1

        when:"The domain instance is passed to the delete action"
            controller.delete(familiar)

        then:"The instance is deleted"
            Familiar.count() == 0
            response.redirectedUrl == '/familiar/index'
            flash.message != null
    }
}
