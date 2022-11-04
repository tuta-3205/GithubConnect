import Foundation
import CoreData

final class UserRepositoryImpl: UserRepository {
    
    private let network = GithubServices.shared
    private let local = LocalDataManager.shared
    
    func getSearchUser(params: SearchUserRequestParams, completion: @escaping (SearchUserResponseModel?, Error?) -> Void) {
        network.getSearchUser(request: params) { result in
            switch result {
            case .success(let model):
                completion(model, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    func getProfileUser(params: ProfileUserRequestParams, completion: @escaping (ProfileUserResponseModel?, Error?) -> Void) {
        network.getProfileUser(request: params){ result in
            switch result {
            case .success(let model):
                completion(model, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    func getFollowersUser(params: FollowersUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void) {
        network.getFollowersUser(request: params) { result in
            switch result {
            case .success(let model):
                completion(model, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    func getFollowingUser(params: FollowingUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void) {
        network.getFollowingsUser(request: params) { result in
            switch result {
            case .success(let model):
                completion(model, nil)
                break
            case .failure(let error):
                completion(nil, error)
                break
            }
        }
    }
    
    func saveProfileToLocal(profile: ProfileUserModel?) {
        if let login = profile?.login {
            if local.isProfileInData(login) {
                local.deleteProfile(profile!)
            } else {
                local.saveProfile(profile!)
            }
        }
    }
    
    func isProfileInLocal(profile: ProfileUserModel?) -> Bool{
        if let login = profile?.login {
            return local.isProfileInData(login)
        }
        return false
    }
    
    func getListProfile(completion: @escaping ([NSManagedObject], Error?) -> (Void)) {
        return local.getFavoriteUserList { items, error in 
            guard error == nil else {
                print("Could not fetch. \(String(describing: error))")
                completion([], error)
                return
            }
            
            completion(items, nil)
        }
    }
}
