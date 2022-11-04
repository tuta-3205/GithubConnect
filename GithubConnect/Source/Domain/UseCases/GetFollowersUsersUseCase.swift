import Foundation

class GetFollowersUsersUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(params: FollowersUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void) {
        userRepository.getFollowersUser(params: params, completion: completion)
    }
}
