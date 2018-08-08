//
//  SQLConfig.swift
//  App
//
//  Created by ASong on 2018/8/6.
//

import FluentMySQL

extension MySQLDatabaseConfig {
    static func loadSQLConfig(_ env: Environment) -> MySQLDatabaseConfig {
        
        let database = env.isRelease ? "VaporDB" : "VaporDebugDB"
        
        var hostname = "127.0.0.1"
        var username = "root"
        var password = ""
        
        var port = 3306
        
        #if os(Linux)
        let manager = FileManager.default
        let path = "/home/ubuntu/base.json"
        if let data = manager.contents(atPath: path) {
            
            struct Base: Content {
                var hostname: String
                var username: String
                var password: String
                var port: Int
            }
            
            if let base = try? JSONDecoder().decode(Base.self, from: data) {
                print(base.username,"\n\n")
                hostname = base.hostname
                username = base.username
                password = base.password
                port = base.port
            }else {
                PrintLogger().warning("数据库配置读取失败： 目录 \(path) 不存在！")
            }
        }
        #endif
        
        PrintLogger().info("启动数据库\(database)")
        
        #if os(Linux)
        return MySQLDatabaseConfig(hostname: hostname,
                                        port: port,
                                        username: username,
                                        database: database,
                                        password:password)
        #else
        return MySQLDatabaseConfig(hostname: hostname, port: port, username: username, password: password, database: database)
        #endif
        
        
    }
    
}
