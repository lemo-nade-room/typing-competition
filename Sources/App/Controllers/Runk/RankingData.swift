import Vapor
import Fluent
import Foundation

struct RankingData: Content {
    let comprehensive: GenreRank
    let high: GenreRank
    let middle: GenreRank
    let low: GenreRank
    
    static func fetch(on: Database) async throws -> Self {
        let allScores = try await ScoreRecord.query(on: on)
            .with(\.$student) { $0.with(\.$dailyChallengeCourses) }
            .sort(\.$scorePrice, .descending)
            .all()
        let comprehensive = comprehensive(allScores: allScores)
        let high = Self.courseDaily(allScores: allScores, course: "高級", day: "2022/7/12")
        let middle = Self.courseDaily(allScores: allScores, course: "お勧め", day: "2022/7/12")
        let low = Self.courseDaily(allScores: allScores, course: "お手軽", day: "2022/7/12")
        return RankingData(comprehensive: comprehensive, high: high, middle: middle, low: low)
    }
    
    static func comprehensive(allScores: [ScoreRecord]) -> GenreRank {
        return GenreRank(scores: uniqueStudentScores(scores: allScores))
    }
    
    static func courseDaily(allScores: [ScoreRecord], course: String, day: String) -> GenreRank {
        let decideScores = allScores.filter { score in
            guard score.course == course else { return false }
            guard let dailyCourse = score.student.dailyChallengeCourses.first(where: { $0.choseDate.japanese == day }) else {
                return false
            }
            return dailyCourse.chosenCourse == course
        }
        let uniqueScores = uniqueStudentScores(scores: decideScores)
        let onDayCourseScores = uniqueScores
            .filter { score in
                return score.madeDate.japanese == day
            }
        return GenreRank(scores: onDayCourseScores)
    }
    
    static func uniqueStudentScores(scores: [ScoreRecord]) -> [ScoreRecord] {
        var scoreRecords = [ScoreRecord]()
        scores.forEach { score in
            if scoreRecords.contains(where: { $0.student == score.student }) { return }
            scoreRecords.append(score)
        }
        return scoreRecords
    }
}

extension Date {
    var japanese: String {
        return Date(timeInterval: 60 * 60 * 9, since: self).formatted(date: .numeric, time: .omitted)
    }
}
