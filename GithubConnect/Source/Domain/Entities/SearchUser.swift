import Foundation

struct SearchUser: Codable, Equatable {
    let login: String?
    let id: Int?
    let avatarURL, htmlURL, followersURL: String?
    let followingURL: String?
    let reposURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case reposURL = "repos_url"
    }
}
