import Foundation
import Vapor
import Fluent

final class ScoreRecord: Model, Content {
    static let schema = "score_records"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "student_id")
    var studentNumber: Int
    
    @Field(key: "course")
    var course: String
    
    @Field(key: "score_price")
    var scorePrice: Int
    
    @Field(key: "made_date")
    var madeDate: Date
    
    @Parent(key: "student_id")
    var student: Student

    init() { }

    init(id: UUID? = nil, studentNumber: Int, course: String, scorePrice: Int, madeDate: Date = Date()) {
        self.id = id
        self.studentNumber = studentNumber
        self.course = course
        self.scorePrice = scorePrice
        self.madeDate = madeDate
    }

}
