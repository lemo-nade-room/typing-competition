import Foundation
import Vapor
import Fluent

final class ExitRecord: Model, Content {
    static let schema = "exit_records"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "student_id")
    var studentNumber: Int
    
    @Field(key: "exit_date")
    var exitDate: Date
    
    @Parent(key: "student_id")
    var student: Student

    init() { }

    init(id: UUID? = nil, studentNumber: Int, exitDate: Date = Date()) {
        self.id = id
        self.studentNumber = studentNumber
        self.exitDate = exitDate
    }

}
