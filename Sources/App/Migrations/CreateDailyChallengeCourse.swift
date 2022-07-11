import Foundation
import Vapor
import Fluent

extension DailyChallengeCourse {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(DailyChallengeCourse.schema)
                .id()
                .field("student_id", .int, .required, .references("students", "id"))
                .field("chosen_course", .string, .required)
                .field("chose_date", .date, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(DailyChallengeCourse.schema).delete()
        }
    }
}
