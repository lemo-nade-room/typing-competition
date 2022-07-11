import Vapor
import Fluent

struct SaveRecord: Content {
    let studentNumber: Int
    let course: String
    let scorePrice: Int
    
    func save(db: Database) async throws {
        try await ScoreRecord(studentNumber: studentNumber, course: course, scorePrice: scorePrice).save(on: db)
    }
}
