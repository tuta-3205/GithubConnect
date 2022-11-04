import Foundation
import CoreData

final class FavoriteViewModel: BaseViewModel {
    private var getFavoriteListUserUseCase: GetFavoriteListUserUseCase!
    
    private(set) var favoritesData : [FollowUser]! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override init() {
        super.init()
        self.getFavoriteListUserUseCase = GetFavoriteListUserUseCase()
    }
    
    func callFuncToGetData() {
        self.getFavoriteListUserUseCase.call { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            guard error == nil else {
                print("Could not fetch. \(String(describing: error))")
                return
            }
            var favorites : [FollowUser] = []
            for item in data {
                favorites.append(FollowUser(item: item))
            }
            self.favoritesData = favorites
            return
        }
    }
}
