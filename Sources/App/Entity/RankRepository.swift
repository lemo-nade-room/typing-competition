import Foundation
import Vapor
import Fluent
import FluentSQL

struct RankRepository {
    let db: Database
}

extension Request {
    var rankFetcher: RankFetchable { RankRepository(db: db) }
}

extension RankRepository: RankFetchable {
    func fetchComprehensive() async throws -> [Student] {
        guard let sql = db as? SQLDatabase else {
            fatalError("SQL Databaseを使用してください")
        }
        return try await sql.raw(
            """
            SELECT s.*
              FROM score_records
             INNER JOIN students s on s.id = score_records.student_id
             GROUP BY s.id
             ORDER BY MAX(score_price) DESC
            """
        ).all(decoding: Student.self)
    }
    
    func fetchDailyHighRank(day: Date) async throws -> [Student] {
        return try await fetchCourseDailyRank(course: "高級", day: day)
    }
    
    func fetchDailyMiddleRank(day: Date) async throws -> [Student] {
        return try await fetchCourseDailyRank(course: "お勧め", day: day)
    }
    func fetchDailyLowRank(day: Date) async throws -> [Student] {
        return try await fetchCourseDailyRank(course: "お手軽", day: day)
    }
    
    private func fetchCourseDailyRank(course: String, day: Date) async throws -> [Student] {
        guard let sql = db as? SQLDatabase else {
            fatalError("SQL Databaseを使用してください")
        }
        return try await sql.raw(
            """
            SELECT s.*
              FROM score_records
             INNER JOIN students s on s.id = score_records.student_id
             WHERE course = '\(raw: course)'
               AND TO_CHAR(made_date, 'MM/DD/YYYY') = '\(raw: day.formatted(date: .numeric, time: .omitted))'
             GROUP BY s.id
             ORDER BY MAX(score_price) DESC;
            """
        ).all(decoding: Student.self)
    }
}
