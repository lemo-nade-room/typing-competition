import Fluent
import Vapor
import Foundation

final class DailyChallengeCourse: Model, Content {
    static let schema = "daily_challenge_courses"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "student_id")
    var studentNumber: Int
    
    @Field(key: "chosen_course")
    var chosenCourse: String
    
    @Field(key: "chose_date")
    var choseDate: Date
    
    @Parent(key: "student_id")
    var student: Student

    init() { }

    init(id: UUID? = nil, studentNumber: Int, chosenCourse: String, choseDate: Date = Date()) {
        self.id = id
        self.studentNumber = studentNumber
        self.chosenCourse = chosenCourse
        self.choseDate = choseDate
    }
}
