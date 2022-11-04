import Foundation

struct SearchUserResponseModel: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [SearchUserModel]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

typealias SearchUserModel = SearchUser
