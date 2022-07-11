import Foundation
import Vapor
import Fluent

final class Student: Model, Content {
    static let schema = "students"
    
    
    @ID(custom: "id")
    var id: Int?
    
    @Field(key: "grade")
    var grade: Int
    
    @Field(key: "course_of_study")
    var courseOfStudy: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "nickname")
    var nickname: String
    
    @Children(for: \.$student)
    var entryRecords: [EntryRecord]
    
    @Children(for: \.$student)
    var exitRecords: [ExitRecord]
    
    @Children(for: \.$student)
    var dailyChallengeCourses: [DailyChallengeCourse]
    
    @Children(for: \.$student)
    var scoreRecords: [ScoreRecord]
    
    @Children(for: \.$student)
    var awardRecords: [AwardRecord]
    
    init() { }

    init(id: Int? = nil, grade: Int, courseOfStudy: String, name: String, nickname: String) {
        self.id = id
        self.grade = grade
        self.courseOfStudy = courseOfStudy
        self.name = name
        self.nickname = nickname
    }

}


extension Student: Equatable {
    static func == (left: Student, right: Student) -> Bool{
        return left.id == right.id
    }
}
