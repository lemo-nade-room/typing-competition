import Foundation
import Vapor
import Fluent

final class EntryRecord: Model, Content {
    static let schema = "entry_records"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "student_id")
    var studentNumber: Int
    
    @Field(key: "entry_date")
    var entryDate: Date
    
    @Parent(key: "student_id")
    var student: Student

    init() { }

    init(id: UUID? = nil, studentNumber: Int, entryDate: Date = Date()) {
        self.id = id
        self.studentNumber = studentNumber
        self.entryDate = entryDate
    }

}
