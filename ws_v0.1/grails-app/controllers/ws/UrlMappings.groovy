package ws

class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }
		"/WS_Familiar"(resources:"WS_Familiar") {
			"/publisher"(controller:"publisher", method:"GET")
		}
        "/"(view:"/index")
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
