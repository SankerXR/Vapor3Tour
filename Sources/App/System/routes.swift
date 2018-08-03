import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    /// 注册路由
    let v1 = router.grouped("api", "v1")

    try v1.register(collection: UserRouteController())
}
