import Foundation
import Vapor
import Fluent

extension EntryRecord {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(EntryRecord.schema)
                .id()
                .field("student_id", .int, .required, .references("students", "id"))
                .field("entry_date", .datetime, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(EntryRecord.schema).delete()
        }
    }
}
