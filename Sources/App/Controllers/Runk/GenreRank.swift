import Foundation
import Vapor

struct GenreRank: Content {
    let first: PersonalRank
    let second: PersonalRank
    let third: PersonalRank
    
    init(scores: [ScoreRecord]) {
        switch scores.count {
        case 0:
            first = PersonalRank()
            second = PersonalRank()
            third = PersonalRank()
        case 1:
            first = PersonalRank(scores[0].student.nickname, scores[0].scorePrice)
            second = PersonalRank()
            third = PersonalRank()
        case 2:
            first = PersonalRank(scores[0].student.nickname, scores[0].scorePrice)
            second = PersonalRank(scores[1].student.nickname, scores[1].scorePrice)
            third = PersonalRank()
        default:
            first = PersonalRank(scores[0].student.nickname, scores[0].scorePrice)
            second = PersonalRank(scores[1].student.nickname, scores[1].scorePrice)
            third = PersonalRank(scores[2].student.nickname, scores[2].scorePrice)
        }
    }
}
