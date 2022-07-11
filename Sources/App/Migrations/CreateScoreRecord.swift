import Foundation
import Vapor
import Fluent

extension ScoreRecord {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(ScoreRecord.schema)
                .id()
                .field("student_id", .int, .required, .references("students", "id"))
                .field("course", .string, .required)
                .field("score_price", .int, .required)
                .field("made_date", .datetime, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(ScoreRecord.schema).delete()
        }
    }
}
