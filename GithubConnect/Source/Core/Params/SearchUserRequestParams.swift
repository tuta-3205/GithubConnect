import Foundation

struct SearchUserRequestParams: BaseRequestParams {
    let keyword: String
    
    public func toString() -> String {
        return "?q=\(keyword)+in:login"
    }
}
