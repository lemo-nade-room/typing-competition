import Vapor
import Leaf
import Fluent

struct RecordController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let record = routes.grouped("record")
        record.get(use: index)
        record.post(use: self.record)
    }
    
    func index(req: Request) async throws -> View {
        let entryingStudents = try await req.entryingStudentsFetcher.fetch()
        return try await req.view.render("record", ["students": entryingStudents])
    }
    
    func record(req: Request) async throws -> View {
        let saveRecord = try req.content.decode(SaveRecord.self)
        try await saveRecord.save(db: req.db)
        return try await index(req: req)
    }
}
