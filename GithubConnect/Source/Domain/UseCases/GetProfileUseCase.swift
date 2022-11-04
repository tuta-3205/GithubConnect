import Foundation

class GetProfileUserUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(params: ProfileUserRequestParams, completion: @escaping (ProfileUserResponseModel?, Error?) -> Void) {
        userRepository.getProfileUser(params: params, completion: completion)
    }
}
