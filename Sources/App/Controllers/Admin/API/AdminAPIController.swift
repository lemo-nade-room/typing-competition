import Vapor

struct AdminAPIController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let api = routes.grouped("api")
        
        try api.register(collection: StudentController())
    }
}
