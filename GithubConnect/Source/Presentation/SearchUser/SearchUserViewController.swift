import UIKit

final class SearchUserViewController: UIViewController {
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var searchUserTable: UITableView!
    
    private var tableData: [SearchUserModel] = []
    
    private let viewModel: SearchUserViewModel = SearchUserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        callToViewModelForUIUpdate()
    }
    
    private func callToViewModelForUIUpdate() {
        viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        tableData = viewModel.data
        DispatchQueue.main.async {
            self.searchUserTable.reloadData()
        }
    }
    
    private func configView() {
        configTableView()
        
        self.navigationController?.isNavigationBarHidden = true
        searchTextField.delegate = self
        searchView.layer.cornerRadius = 20
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        searchIcon.isUserInteractionEnabled = true
        searchIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configTableView() {
        searchUserTable.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
        searchUserTable.delegate = self
        searchUserTable.dataSource = self
    }
    
    private func configNavigatorButton() {
        let yourBackImage = UIImage(systemName: "arrow.backward")
        yourBackImage?.withTintColor(.white)
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if searchTextField.text?.count ?? 0 > 0 {
            searchIcon.image = UIImage(systemName: "magnifyingglass")
            searchTextField.text = ""
            tableData = []
            viewModel.callFuncToGetData("")
        }
    }
    
    func setSearchImage(_ textFieldCount: Int) {
        if textFieldCount == 0 {
            searchIcon.image = UIImage(systemName: "magnifyingglass")
        } else {
            searchIcon.image = UIImage(systemName: "xmark")
        }
    }
    
    @IBAction private func favoriteButtonClick(_ sender: UIButton) {
        let sb = UIStoryboard(name: "GithubConnect", bundle: nil)
        guard let favoritePageController = sb.instantiateViewController(identifier: "Favorite") as? FavoriteViewController else {
            return
        }
        self.navigationController?.pushViewController(favoritePageController, animated: true)
    }
    
}

extension SearchUserViewController: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
                   let range = Range(range, in: oldText) else {
                 return true
             }
        let newText = oldText.replacingCharacters(in: range, with: string)
        if newText.contains(" ") {
            searchTextField.text = ""
            return true
        }
        self.setSearchImage(newText.count)
        if newText.count > 0 {
            viewModel.callFuncToGetData(newText)
        } else {
            tableData = []
            DispatchQueue.main.async {
                self.searchUserTable.reloadData()
            }
        }
        return true
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell",
                                                              for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
        let user = UserTableCell(item: tableData[indexPath.row])
        cell.bindData(data: user, isHiddenShowDetailButton: false)
        return cell
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchUserTable.deselectRow(at: indexPath, animated: false)
        let sb = UIStoryboard(name: "GithubConnect", bundle: nil)
        guard let profilePageController = sb.instantiateViewController(identifier: "Profile") as? ProfileViewController else {
            return
        }
        if let login = self.tableData[indexPath.row].login {
            profilePageController.login = login
        }
        self.navigationController?.pushViewController(profilePageController, animated: true)
    }
}
