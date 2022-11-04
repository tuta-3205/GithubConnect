import Foundation

struct FollowersUserRequestParams: BaseRequestParams {
    let login: String
    
    public func toString() -> String {
        return "/\(login)/followers"
    }
}
