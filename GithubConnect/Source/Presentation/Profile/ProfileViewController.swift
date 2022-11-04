import UIKit

enum ProfileViewStatus {
    case followers
    case following
}

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var nameAndAddressLabel: UILabel!
    @IBOutlet private weak var skillLabel: UILabel!
    @IBOutlet private weak var countFollowersLabel: UILabel!
    @IBOutlet private weak var countFollowingLabel: UILabel!
    @IBOutlet private weak var countRepositoryLabel: UILabel!
    @IBOutlet private weak var countView: UIView!
    @IBOutlet private weak var followersButton: UIButton!
    @IBOutlet private weak var followingButton: UIButton!
    @IBOutlet private weak var followTable: UITableView!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    var viewStatus: ProfileViewStatus = .followers
    var profile: ProfileUserModel?
    var login: String?
    
    var followers: [FollowUserModel] = []
    var following: [FollowUserModel] = []
    var tableData: [FollowUserModel] = []
    
    private let viewModel: ProfileUserViewModel = ProfileUserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        callToViewModelForUIUpdate()
    }
    
    private func configView() {
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
        countView.layer.cornerRadius = 20
        followersButton.clipsToBounds = true
        followersButton.layer.cornerRadius = 15
        followersButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        followingButton.clipsToBounds = true
        followingButton.layer.cornerRadius = 15
        followingButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        configTable()
        configStatus()
    }
    
    private func configTable() {
        followTable.register(UINib(nibName: "UserInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "UserInfoTableViewCell")
        followTable.dataSource = self
        followTable.delegate = self
    }
    
    private func configFavorite() {
        if let profile = profile {
            if viewModel.callFuncToCheckProfile(profile) {
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    private func configStatus() {
        if viewStatus == .followers {
            followersButton.backgroundColor = .white
            followersButton.tintColor = .systemBrown
            followingButton.backgroundColor = .systemBrown
            followingButton.tintColor = .white
            tableData = followers
        } else {
            followingButton.backgroundColor = .white
            followingButton.tintColor = .systemBrown
            followersButton.backgroundColor = .systemBrown
            followersButton.tintColor = .white
            tableData = following
        }
    }
    
    private func reloadUserUI() {
        avatarImage.loadFrom(URLAddress: profile?.avatarURL ?? "")
        nameAndAddressLabel.text = profile?.name ?? ""
        if nameAndAddressLabel.text != nil  && profile?.company != nil {
            nameAndAddressLabel.text = nameAndAddressLabel.text ?? "" + " * "
        }
        nameAndAddressLabel.text = nameAndAddressLabel.text ?? "" + (profile?.company ?? "")
        skillLabel.text = profile?.bio
        countFollowersLabel.text = String(profile?.followers ?? 0)
        countFollowingLabel.text = String(profile?.following ?? 0)
        countRepositoryLabel.text = String(profile?.publicRepos ?? 0)
    }
    
    private func callToViewModelForUIUpdate() {
        if let login = login {
            viewModel.callFuncToGetProfileData(login)
        }
        viewModel.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        if profile != viewModel.profileData {
            profile = viewModel.profileData
            reloadUserUI()
            if let login = login {
                viewModel.callFuncToGetFollowersData(login)
                viewModel.callFuncToGetFollowingData(login)
            }
            configFavorite()
        }
        
        if followers != viewModel.followersData {
            followers = viewModel.followersData
            configStatus()
            DispatchQueue.main.async {
                self.followTable.reloadData()
            }
        }
        
        if following != viewModel.followingData {
            following = viewModel.followingData
        }
    }
    

    
    
    @IBAction func backButtonClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func followersButtonClick(_ sender: UIButton) {
        if viewStatus != .followers {
            viewStatus = .followers
            configStatus()
            DispatchQueue.main.async {
                self.followTable.reloadData()
            }
        }
    }
    
    @IBAction func followingButtonClick(_ sender: UIButton) {
        if viewStatus != .following {
            viewStatus = .following
            configStatus()
            DispatchQueue.main.async {
                self.followTable.reloadData()
            }
        }
    }
    
    
    @IBAction func favoriteButtonClick(_ sender: Any) {
        if let profile = profile {
            viewModel.callFuncToSaveProfile(profile)
            configFavorite()
        }
       
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
        
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoTableViewCell", for: indexPath) as? UserInfoTableViewCell else {
            return UITableViewCell()
        }
        let user = UserTableCell(item: tableData[indexPath.row])
        cell.bindData(data: user, isHiddenShowDetailButton: true)
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {}
