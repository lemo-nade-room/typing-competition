import Foundation
import Vapor
import Fluent

extension Student {
    struct Migration: AsyncMigration {
        func prepare(on database: Database) async throws {
            try await database.schema(Student.schema)
                .field("id", .int, .identifier(auto: false))
                .field("grade", .int, .required)
                .field("course_of_study", .string, .required)
                .field("name", .string, .required)
                .field("nickname", .string, .required)
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema(Student.schema).delete()
        }
    }
}
