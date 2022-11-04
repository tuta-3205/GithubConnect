import Foundation

final class ProfileUserViewModel: BaseViewModel {
    private var getProfileUserUseCase: GetProfileUserUseCase!
    private var getFollowersUsersUseCase: GetFollowersUsersUseCase!
    private var getFollowingUsersUseCase: GetFollowingUsersUseCase!
    private var saveProfileToLocalUseCase: SaveProfileToLocalUseCase!
    private var checkProfileInLocalUseCase: CheckProfileInLocalUseCase!
    
    private(set) var profileData : ProfileUser? {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var followersData : [FollowUser] = [] {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var followingData : [FollowUser] = [] {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override init() {
        super.init()
        self.getProfileUserUseCase = GetProfileUserUseCase()
        self.getFollowersUsersUseCase = GetFollowersUsersUseCase()
        self.getFollowingUsersUseCase = GetFollowingUsersUseCase()
        self.saveProfileToLocalUseCase = SaveProfileToLocalUseCase()
        self.checkProfileInLocalUseCase = CheckProfileInLocalUseCase()
    }
    
    func callFuncToGetProfileData(_ login: String) {
        self.getProfileUserUseCase.call(params: ProfileUserRequestParams(login: login)) { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                self.profileData = data
            }
        }
    }
    
    func callFuncToGetFollowersData(_ login: String) {
        self.getFollowersUsersUseCase.call(params: FollowersUserRequestParams(login: login)) { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                self.followersData = data
            }
        }
    }
    
    func callFuncToGetFollowingData(_ login: String) {
        self.getFollowingUsersUseCase.call(params: FollowingUserRequestParams(login: login)) { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                self.followingData = data
            }
        }
    }
    
    func callFuncToSaveProfile(_ profile: ProfileUser) {
        self.saveProfileToLocalUseCase.call(profile: profile)
    }
    
    func callFuncToCheckProfile(_ profile: ProfileUser) -> Bool {
        return self.checkProfileInLocalUseCase.call(profile: profile)
    }
}
