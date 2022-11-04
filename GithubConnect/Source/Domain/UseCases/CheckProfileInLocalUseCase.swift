import Foundation

class CheckProfileInLocalUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(profile: ProfileUser) -> Bool {
        return userRepository.isProfileInLocal(profile: profile)
    }
}
