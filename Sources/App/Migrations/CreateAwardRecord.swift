import Foundation
import Vapor
import Fluent

extension AwardRecord {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(AwardRecord.schema)
                .id()
                .field("student_id", .int, .required, .references("students", "id"))
                .field("ranking_type", .int, .required)
                .field("course", .string, .required)
                .field("award_date", .datetime, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(AwardRecord.schema).delete()
        }
    }
}
