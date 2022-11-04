import Foundation

struct ProfileUser: Codable, Equatable {
    let login: String?
    let avatarURL: String?
    let htmlURL: String?
    let name: String?
    let company: String?
    let bio: String?
    let followers: Int?
    let following: Int?
    let publicRepos: Int?
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case name
        case company
        case bio
        case followers
        case following
        case publicRepos = "public_repos"
    }
}
