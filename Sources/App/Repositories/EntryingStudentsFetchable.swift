import Foundation

protocol EntryingStudentsFetchable {
    func fetch() async throws -> [Student]
}
