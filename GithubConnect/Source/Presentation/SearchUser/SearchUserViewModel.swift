import Foundation

final class SearchUserViewModel: BaseViewModel {
    private var getSearchUserUseCase: GetSearchUserUseCase!
    
    private(set) var data : [SearchUser]! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    override init() {
        super.init()
        self.getSearchUserUseCase = GetSearchUserUseCase()
        callFuncToGetData(nil)
    }
    
    func callFuncToGetData(_ q: String?) {
        self.getSearchUserUseCase.call(params: SearchUserRequestParams(keyword: q ?? "")) { [weak self] (data, error) -> (Void) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                self.data = data.items
            }
        }
    }
}
