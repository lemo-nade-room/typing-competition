import Vapor

struct RegisteredStudent: Content {
    
    let student: Student?
    let isRegistered: Bool
    
    private init() {
        student = nil
        isRegistered = false
    }
    
    static let notRegistered = RegisteredStudent()
    
    init(_ student: Student) {
        self.student = student
        isRegistered = true
    }
}
