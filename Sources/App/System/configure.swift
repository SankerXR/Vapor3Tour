import FluentMySQL
import Vapor
import VaporRequestStorage
import JWTMiddleware
/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentMySQLProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    /// middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    let mysql =  MySQLDatabase(config: MySQLDatabaseConfig.loadSQLConfig(env))

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    ///JWT
    try services.register(StorageProvider())
    
    /// Adding the JWTProvider for us to validate JWTs
    try services.register(JWTProvider { _ , pem  in
        guard let pem = pem else { throw Abort(.internalServerError, reason: "Could not find environment variable 'JWT_SECRET'", identifier: "missingEnvVar") }
        let headers = JWTHeader(alg: "RS256", crit: ["exp", "aud"], kid: "user_manager_kid")
        return try RSAService(pem: pem, header: headers, type: .private, algorithm: .sha512)
    })
    
    
    
    
    /// Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: LoginUser.self, database: .mysql)
    migrations.add(model: UserInfo.self, database: .mysql)
    services.register(migrations)

}
