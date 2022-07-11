import Fluent

extension Student {
    func isEntrying(db: Database) async throws -> Bool {
        guard let lastEntryDate = try await self.$entryRecords.query(on: db).max(\.$entryDate) else {
            return false
        }
        guard let lastExitDate = try await self.$exitRecords.query(on: db).max(\.$exitDate) else {
            return true
        }
        return lastEntryDate > lastExitDate
    }
    
    var isEntrying: Bool {
        guard let lastEntryDate = entryRecords.max(by: { $0.entryDate < $1.entryDate })?.entryDate else {
            return false
        }
        guard let lastExitDate = exitRecords.max(by: { $0.exitDate < $1.exitDate })?.exitDate else {
            return true
        }
        return lastEntryDate > lastExitDate
    }
    
    func entry(db: Database) async throws {
        if try await isEntrying(db: db) { return }
        guard let id = id else { return }
        try await self.$entryRecords.create(EntryRecord(studentNumber: id), on: db)
    }
    
    func exit(db: Database) async throws {
        if !(try await isEntrying(db: db)) { return }
        guard let id = id else { return }
        try await self.$exitRecords.create(ExitRecord(studentNumber: id), on: db)
    }
}
