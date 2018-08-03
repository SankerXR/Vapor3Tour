//
//  BaseSQLModel.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Vapor
import FluentSQLite


public typealias BaseSQLModel = SQLiteModel & Migration & Content


//protocol SuperMode: BaseSQLModel {
//    static var entity: String { get }
//
//    static var createdAtKey: TimestampKey? { get }
//    static var updatedAtKey: TimestampKey? { get }
//    static var deletedAtKey: TimestampKey? { get }
//
//    var createdAt: Date? { get set }
//    var updatedAt: Date? { get set }
//    var deletedAt: Date? { get set }
//
//}
//
//extension SuperMode {
//
//    static var entity: String { return self.name + "s" }
//
//    static var createdAtKey: TimestampKey? { return \Self.createdAt }
//    static var updatedAtKey: TimestampKey? { return \Self.updatedAt }
//    static var deletedAtKey: TimestampKey? { return \Self.deletedAt }
//}
