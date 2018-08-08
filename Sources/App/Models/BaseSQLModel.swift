//
//  BaseSQLModel.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Vapor
import FluentMySQL


public typealias BaseSQLModel = MySQLModel & Migration & Content

