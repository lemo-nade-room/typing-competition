import Foundation
import Vapor
import Fluent

extension ExitRecord {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(ExitRecord.schema)
                .id()
                .field("student_id", .int, .required, .references("students", "id"))
                .field("exit_date", .datetime, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(ExitRecord.schema).delete()
        }
    }
}
