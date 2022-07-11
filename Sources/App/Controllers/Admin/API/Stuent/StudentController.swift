import Foundation
import Vapor
import Fluent

struct StudentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let student = routes.grouped("student")
        student.get(":studentNumber", use: registered)
    }
    
    func registered(req: Request) async throws -> RegisteredStudent {
        guard let student = try await Student.find(req.parameters.get("studentNumber", as: Int.self), on: req.db) else {
            return .notRegistered
        }
        return RegisteredStudent(student)
    }
}
