import Vapor
import Leaf

struct AdminController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let admin = routes.grouped("admin")
        admin.get(use: index)
        admin.post(use: login)
        
        let auth = admin.grouped(AuthMiddleware())
        
        try auth.register(collection: AdminAPIController())
        try auth.register(collection: RoomController())
        try auth.register(collection: RecordController())
        try auth.register(collection: ChallengeController())
    }
    
    func index(req: Request) async throws -> View {
        return try await req.view.render("admin")
    }
    
    func login(req: Request) async throws -> View {
        let loginRequest = try req.content.decode(LoginContent.self)
        guard loginRequest.isMatch() else { throw Abort(.unauthorized) }
        req.session.data["auth"] = "logined"
        return try await req.view.render("logined")
    }
}

struct LoginContent: Content {
    let password: String
    
    func isMatch() -> Bool { password == "nitnc-shikkobu"}
}

struct AuthMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder) async throws -> Response {
        guard request.session.data["auth"] == "logined" else { throw Abort(.unauthorized) }
        return try await next.respond(to: request)
    }
}
