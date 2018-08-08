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
    

    var createdAt: Date?
    
    
    
    init(account: String, password: String) {
        self.account = account
        self.password = password
        self.userId = UUID().uuidString
        self.createdAt = Date() 
    }
    
}


