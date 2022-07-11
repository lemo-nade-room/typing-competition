import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "typing_database",
        tlsConfiguration: .none
    ), as: .psql)

    app.migrations.add(CreateTodo())
    app.migrations.add(Student.Migration())
    app.migrations.add(EntryRecord.Migration())
    app.migrations.add(ExitRecord.Migration())
    app.migrations.add(ScoreRecord.Migration())
    app.migrations.add(DailyChallengeCourse.Migration())
    app.migrations.add(AwardRecord.Migration())

    app.views.use(.leaf)

    app.middleware.use(app.sessions.middleware)
    

    // register routes
    try routes(app)
}
