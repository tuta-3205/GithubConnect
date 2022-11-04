import Foundation

class SaveProfileToLocalUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(profile: ProfileUser) {
        userRepository.saveProfileToLocal(profile: profile)
    }
}
