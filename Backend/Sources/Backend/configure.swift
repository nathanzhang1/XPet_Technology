import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor
import Foundation

public func configure(_ app: Application) async throws {
    // Serve files from /Public folder if needed
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Configure PostgreSQL database
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "xpet_admin",
        password: Environment.get("DATABASE_PASSWORD") ?? "xpetdatabase",
        database: Environment.get("DATABASE_NAME") ?? "xpetdb",
        tls: .disable  // Use `.prefer(try .init(...))` if using a remote database that requires TLS
    )), as: .psql)

    // Add your own migration
    app.migrations.add(CreateUser())

    // Register routes
    try routes(app)
}
