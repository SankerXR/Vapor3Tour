//
//  ResponseJSON.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Vapor


struct Empty: Content {}

/// 请求结果构造器
struct ResponseJSON<T: Content>: Content {
    private var status: ResponseStatus
    private var message: String
    private var data: T?
    
    
    init(status: ResponseStatus = .success) {
        self.status = status
        self.message = status.desc
        self.data = nil
    }
    
    init(data: T) {
        self.status = .success
        self.message = status.desc
        self.data = data
    }
    
    init(status: ResponseStatus = .success, message: String = ResponseStatus.success.desc) {
        self.status = status
        self.message = message
        self.data = nil
    }
    
    init(status: ResponseStatus = .success, message: String = ResponseStatus.success.desc, data: T?) {
        self.status = status
        self.message = message
        self.data = data
    }
    
    
}

enum ResponseStatus: Int, Content {
    case success = 0
    case error = 1
    case missParams = 3
    case token = 4
    case unknow = 10
    case userExit = 20
    case userNotExit = 21
    case passwordError = 22
    
    var desc: String {
        switch self {
        case .success: return "请求成功"
        case .error: return "请求失败"
        case .missParams: return "缺少参数"
        case .token: return "登录态失效，请重新登录"
        case .unknow: return "未知错误"
        case .userExit: return "用户已存在"
        case .userNotExit: return "用户不存在"
        case .passwordError: return "密码错误"
        }
    }
    
}
