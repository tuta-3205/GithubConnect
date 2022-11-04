import Foundation

struct UserTableCell: Codable {
    let login: String?
    let avatarURL: String?
    let htmlURL: String?
    
    init(item: FollowUser) {
        self.login = item.login
        self.avatarURL = item.avatarURL
        self.htmlURL = item.htmlURL
    }
    
    init(item: ProfileUser) {
        self.login = item.login
        self.avatarURL = item.avatarURL
        self.htmlURL = item.htmlURL
    }
    
    init(item: SearchUser) {
        self.login = item.login
        self.avatarURL = item.avatarURL
        self.htmlURL = item.htmlURL
    }
}
