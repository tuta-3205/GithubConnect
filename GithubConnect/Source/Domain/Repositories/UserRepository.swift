import Foundation
import CoreData

protocol UserRepository {
    func getSearchUser(params: SearchUserRequestParams, completion: @escaping (SearchUserResponseModel?, Error?) -> Void)
    
    func getProfileUser(params: ProfileUserRequestParams, completion: @escaping (ProfileUserResponseModel?, Error?) -> Void)

    func getFollowersUser(params: FollowersUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void)
    
    func getFollowingUser(params: FollowingUserRequestParams, completion: @escaping (FollowUsersResponseModel?, Error?) -> Void)
    
    func saveProfileToLocal(profile: ProfileUserModel?)
    
    func isProfileInLocal(profile: ProfileUserModel?) -> Bool
    
    func getListProfile(completion: @escaping ([NSManagedObject], Error?) -> (Void))
}
