import UIKit
import CoreData

class UserInfoTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var gitHubLinkLabel: UILabel!
    @IBOutlet private weak var nameUserLabel: UILabel!
    @IBOutlet private weak var avatarUserImageView: UIImageView!
    @IBOutlet private weak var cellUIView: UIView!
    @IBOutlet private weak var showDetailButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        avatarUserImageView.layer.cornerRadius = avatarUserImageView.frame.height / 2
        avatarUserImageView.clipsToBounds = true
        cellUIView.dropShadow(color: .black, offSet: .zero, radius: 3)
        selectionStyle = .none
    }
    
    func bindData(data: UserTableCell, isHiddenShowDetailButton: Bool) {
        if let avatarURL = data.avatarURL {
            avatarUserImageView.loadFrom(URLAddress: avatarURL)
        }
        
        if (isHiddenShowDetailButton) {
            showDetailButton.isHidden = true
        }
        nameUserLabel.text = data.login
        gitHubLinkLabel.text = data.htmlURL
    }
}


