import Foundation

struct FollowingUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)/following"
    }
}
