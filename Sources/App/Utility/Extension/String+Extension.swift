//
//  String+Extension.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Foundation
import Vapor
import Crypto

extension String {
    
    func hashString(_ req: Request) throws -> String {
        return try req.make(BCryptDigest.self).hash(self)
    }
    
    func isAccount() -> (Bool, String) {
        if count < UserInfoConst.accountMinCount {
            return (false, "账号过于简短")
        }
        if count > UserInfoConst.accountMaxCount {
            return (false, "账号过长")
        }
        return (true, "账号符合要求")
    }
    
    func isPassword() -> (Bool, String) {
        if count < UserInfoConst.passwordMinCount {
            return (false, "密码过于简短")
        }
        if count > UserInfoConst.passwordMaxCount {
            return (false, "密码过长")
        }
        return (true, "密码合适")
    }
}
