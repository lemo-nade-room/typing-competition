import Vapor
import Fluent

protocol RankFetchable {
    func fetchComprehensive() async throws -> [Student]
    func fetchDailyHighRank(day: Date) async throws -> [Student]
    func fetchDailyMiddleRank(day: Date) async throws -> [Student]
    func fetchDailyLowRank(day: Date) async throws -> [Student]
}
