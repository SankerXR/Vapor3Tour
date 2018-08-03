//
//  LoginUser.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Vapor

struct LoginUser: BaseSQLModel {
    var id: Int?
    
    var userId: String?
    private(set) var account: String
    var password: String
    
    init(userId: String, account: String, password: String) {
        self.userId = userId
        self.account = account
        self.password = password
    }
    
}


