import Foundation

class GithubServices {
    static let shared = GithubServices()
    
    private init() {}
    
    private let API = APICaller.shared
    
    struct Constants {
        static let baseURL = "https://api.github.com"
    }
    
    func getSearchUser(request params: SearchUserRequestParams, completion: @escaping(Result<SearchUserResponseModel, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.searchUser.rawValue, completion: completion)
    }
    
    func getProfileUser(request params: ProfileUserRequestParams, completion: @escaping(Result<ProfileUserResponseModel, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileUser.rawValue, completion: completion)
    }
    
    func getFollowersUser(request params: FollowersUserRequestParams, completion: @escaping(Result<FollowUsersResponseModel, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileUser.rawValue, completion: completion)
    }
    
    func getFollowingsUser(request params: FollowingUserRequestParams, completion: @escaping(Result<FollowUsersResponseModel, Error>) -> Void) {
        return API.getRequest(request: params, baseURL: Constants.baseURL, endpoint: Endpoints.profileUser.rawValue, completion: completion)
    }
}
