import Foundation

class GetFollowingUsersUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(params: FollowingUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void) {
        userRepository.getFollowingUser(params: params, completion: completion)
    }
}
