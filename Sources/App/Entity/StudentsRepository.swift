import Foundation
import Vapor
import Fluent
import FluentSQL

struct StudentsRepository {
    let db: Database
}

extension Request {
    var entryingStudentsFetcher: EntryingStudentsFetchable { StudentsRepository(db: db) }
}

extension StudentsRepository: EntryingStudentsFetchable {
    func fetch() async throws -> [Student] {
        guard let sql = db as? SQLDatabase else {
            fatalError("SQL Databaseを使用してください")
        }
        return try await sql.raw(
            """
            SELECT STUDENT.*
              FROM students as STUDENT
             INNER JOIN entry_records ENTRY ON STUDENT.id = ENTRY.student_id
              LEFT OUTER JOIN exit_records EXIT ON STUDENT.id = EXIT.student_id
             GROUP BY STUDENT.id
            HAVING COUNT(EXIT) = 0
                OR MAX(ENTRY.entry_date) > MAX(EXIT.exit_date)
             ORDER BY STUDENT.id
            """
        ).all(decoding: Student.self)
    }
}
