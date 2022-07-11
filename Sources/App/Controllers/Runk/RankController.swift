import Foundation
import Vapor
import Fluent

struct RankController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        routes.get(use: index)
    }
    
    func index(req: Request) async throws -> View {
        let rankData = try await RankingData.fetch(on: req.db)
        return try await req.view.render("index", rankData)
    }
}
