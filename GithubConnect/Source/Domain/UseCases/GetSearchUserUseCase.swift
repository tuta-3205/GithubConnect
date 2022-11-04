import Foundation

class GetSearchUserUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(params: SearchUserRequestParams, completion: @escaping (SearchUserResponseModel?, Error?) -> Void) {
        userRepository.getSearchUser(params: params, completion: completion)
    }
}
