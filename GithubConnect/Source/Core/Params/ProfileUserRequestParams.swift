import Foundation

struct ProfileUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)"
    }
}

