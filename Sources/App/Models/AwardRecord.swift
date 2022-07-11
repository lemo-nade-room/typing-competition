import Fluent
import Vapor
import Foundation

final class AwardRecord: Model, Content {
    static let schema = "award_records"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "student_id")
    var studentNumber: Int
    
    @Field(key: "ranking_type")
    var rankingType: String
    
    @Field(key: "course")
    var course: String
    
    @Field(key: "award_date")
    var awardDate: Date
    
    @Parent(key: "student_id")
    var student: Student

    init() { }

    init(id: UUID? = nil, studentNumber: Int, rankingType: String, course: String, awardDate: Date = Date()) {
        self.id = id
        self.studentNumber = studentNumber
        self.rankingType = rankingType
        self.course = course
        self.awardDate = awardDate
    }
}
