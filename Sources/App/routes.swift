import Fluent
import Vapor

func routes(_ app: Application) throws {

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    try app.register(collection: AdminController())
    try app.register(collection: RankController())

    try app.register(collection: TodoController())
}
