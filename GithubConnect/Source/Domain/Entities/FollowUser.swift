import Foundation
import CoreData

struct FollowUser: Codable, Equatable {
    let login: String?
    let avatarURL: String?
    let htmlURL: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
    
    init(item: NSManagedObject) {
        self.login = item.value(forKey: "login") as? String
        self.avatarURL = item.value(forKey: "avatar_url") as? String
        self.htmlURL = item.value(forKey: "html_url") as? String
    }
}
