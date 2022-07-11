import Vapor
import Leaf
import Fluent

struct ChallengeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let challenge = routes.grouped("challenge")
        challenge.get(use: index)
        challenge.post(use: decide)
    }
    
    func index(req: Request) async throws -> View {
        let entryingStudents = try await req.entryingStudentsFetcher.fetch()
        return try await req.view.render("challenge", ["students": entryingStudents])
    }
    
    func decide(req: Request) async throws -> View {
        let challenge = try req.content.decode(ChallengeData.self)
        guard let student = try await Student.find(challenge.studentNumber, on: req.db) else {
            throw Abort(.badRequest)
        }
        let dailyCourses = try await student.$dailyChallengeCourses.get(on: req.db)
        guard dailyCourses.first(where: { $0.choseDate.japanese == Date().japanese }) == nil else {
            throw Abort(.badRequest)
        }
        try await challenge.save(on: req.db)
        return try await index(req: req)
    }
}
