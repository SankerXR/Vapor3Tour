//
//  UserRouteController.swift
//  App
//
//  Created by ASong on 2018/8/2.
//

import Vapor
import Fluent
import Crypto
import JWTMiddleware


final class UserRouteController: RouteCollection {
    
    func boot(router: Router) throws {
        
        let group = router.grouped("users")
        group.post(LoginUser.self, at: "register", use: registerHandle)
        
        group.post(LoginUser.self, at: "login", use: loginUserHandler)
//验证Token
//        group.grouped(JWTVerificationMiddleware()).post("changePassword", use: <#T##(Request) throws -> ResponseEncodable#>)
    }

}


extension UserRouteController {
    /// 登录逻辑
    func loginUserHandler(_ req: Request, user: LoginUser) -> Future<Response> {
        let first = LoginUser.query(on: req).filter(\.account == user.account).first()
        return first.flatMap({ (existingUser) in
            // 是否注册
            guard let existingUser = existingUser else {
                return try ResponseJSON<Empty>(status: .userNotExit).encode(for: req)
            }
            // 验证密码
            let digest = try req.make(BCryptDigest.self)
            guard try digest.verify(user.password, created: existingUser.password) else {
                return try ResponseJSON<Empty>(status: .passwordError).encode(for: req)
            }
            let signer = try req.make(JWTService.self);
            let jwt = try self.createSignedJWT(With: signer, user: existingUser)
            
            
            
            return try ResponseJSON<LoginResponse>(status: .success, message: "登录成功", data: LoginResponse(token: jwt)).encode(for: req)

        })

    }
    
    
    /// 注册逻辑
    func registerHandle(_ req: Request, newUser: LoginUser) -> Future<Response> {
        let futureFirst = LoginUser.query(on: req).filter(\.account == newUser.account).first()
        return futureFirst.flatMap { existingUser in
            guard  existingUser == nil else {
                return try ResponseJSON<LoginUser>(status: .userExit).encode(for: req)
            }
            if newUser.account.isAccount().0 == false {
                return try ResponseJSON<Empty>(status: .error, message: newUser.account.isAccount().1).encode(for: req)
            }
            if newUser.password.isPassword().0 == false {
                return try ResponseJSON<Empty>(status: .error, message: newUser.account.isPassword().1).encode(for: req)
            }
            
            let digest = try req.make(BCryptDigest.self)
            
            return try LoginUser(userId: UUID().uuidString, account: newUser.account, password: digest.hash(newUser.password)).save(on: req).flatMap({ (savedUser)  in
                
                let signer = try req.make(JWTService.self)
                
                //We sign a JWT
                let signedJWT = try self.createSignedJWT(With: signer, user: savedUser)
                
                return try ResponseJSON<LoginResponse>(status: .success, message: "注册并登录成功", data: LoginResponse(token: "Bearer \(signedJWT)")).encode(for: req)
            })
            
        }
    }
}

extension UserRouteController {
   private func createSignedJWT(With jwtService: JWTService, user: LoginUser) throws -> String {
        // here we create a payload for our JWT
        let payload1 = Payload(exp: 10000000000, iat: 100, account: user.account, id: user.id!)
        let signedJWT = try jwtService.sign(payload1)

        return signedJWT
    }
}

private struct LoginResponse: Content {
    var token: String
}
