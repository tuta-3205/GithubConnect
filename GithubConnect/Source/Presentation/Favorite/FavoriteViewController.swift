import UIKit
import CoreData

final class FavoriteViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    
    private var tableData = [FollowUser]()
    private let viewModel: FavoriteViewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        callToViewModelForUIUpdate()
    }
    
    private func configView() {
        favoriteTableView.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callToViewModelForUIUpdate()
    }
    
    private func callToViewModelForUIUpdate() {
        viewModel.callFuncToGetData()
        viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        tableData = viewModel.favoritesData
        favoriteTableView.reloadData()
    }

    @IBAction private func backButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}


extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
        let user = UserTableCell(item: tableData[indexPath.row])
        cell.bindData(data: user, isHiddenShowDetailButton: false)
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
