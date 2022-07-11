import Vapor
import Fluent

struct ChallengeData: Content {
    
    let studentNumber: Int
    let course: String
    
    func save(on: Database) async throws {
        try await DailyChallengeCourse(studentNumber: studentNumber, chosenCourse: course).save(on: on)
    }
}
