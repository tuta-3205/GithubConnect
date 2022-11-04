import Foundation
import CoreData

class GetFavoriteListUserUseCase {
    private let userRepository: UserRepository = UserRepositoryImpl()
    
    func call(completion: @escaping ([NSManagedObject], Error?) -> (Void)) {
        return userRepository.getListProfile(completion: completion)
    }
}
