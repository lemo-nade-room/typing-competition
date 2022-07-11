import Vapor
import Leaf
import Fluent

struct RoomController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let room = routes.grouped("room")
        room.get(use: index)
        room.post(use: entry)
        room.delete(":studentNumber", use: exit)
    }
    
    func index(req: Request) async throws -> View {
        let entryingStudents = try await req.entryingStudentsFetcher.fetch()
        return try await req.view.render("entry", ["students": entryingStudents])
    }
    
    func entry(req: Request) async throws -> View {
        let entryStudent = try req.content.decode(Student.self)
        
        let student = try await savedStudent(entryStudent, db: req.db)
        
        try await student.entry(db: req.db)
        return try await index(req: req)
    }
    
    func exit(req: Request) async throws -> View {
        guard let student = try await Student.find(req.parameters.get("studentNumber", as: Int.self), on: req.db) else {
            return try await index(req: req)
        }
        try await student.exit(db: req.db)
        return try await index(req: req)
    }
    
    func savedStudent(_ student: Student, db: Database) async throws -> Student {
        guard let findedStudent = try await Student.find(student.id, on: db) else {
            try await student.create(on: db)
            return student
        }
        return findedStudent
    }
    
}
