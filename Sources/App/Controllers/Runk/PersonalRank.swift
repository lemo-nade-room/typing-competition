import Foundation
import Vapor
import Fluent

struct PersonalRank: Content {
    let info: String
    let score: String
    
    init(_ info: String, _ score: Int) {
        self.info = info
        self.score = String(score)
    }
    
    init() {
        self.info = ""
        self.score = ""
    }
}
