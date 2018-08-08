//
//  UserInfo.swift
//  App
//
//  Created by ASong on 2018/8/3.
//

import Foundation
import Vapor
struct UserInfo: BaseSQLModel {
    var id: Int?
    
    var userId: String
    
    var age: Int?
    var sex: Int?
    var nickName: String?
    var phone: String?
    var birthday: String?
    var location: String?
    var picName: String?
    
    init(userId: String) {
        self.userId = userId
    }
    
    
}

extension UserInfo {
    mutating func updateInfo(with user: UserInfoParam) -> UserInfo {
        if let age = user.age {
            self.age = age
        }
        if let sex = user.sex {
            self.sex = sex
        }
        if let nickName = user.nickName {
            self.nickName = nickName
        }
        if let phone = user.phone {
            self.phone = phone
        }
        if let birthday = user.birthday {
            self.birthday = birthday
        }
        if let location = user.location {
            self.location = location
        }
        if let picName = user.picName {
            self.picName = picName
        }
        return self
    }
}


struct UserInfoParam: Content {
    var age: Int?
    var sex: Int?
    var nickName: String?
    var phone: String?
    var birthday: String?
    var location: String?
    var picName: String?
    
    init(userInfo: UserInfo) {
        self.age = userInfo.age ?? 0
        self.sex = userInfo.sex ?? 0
        self.nickName = userInfo.nickName ?? ""
        self.phone = userInfo.phone ?? ""
        self.birthday = userInfo.birthday ?? ""
        self.location = userInfo.location ?? ""
        self.picName = userInfo.picName ?? ""
    }
}
