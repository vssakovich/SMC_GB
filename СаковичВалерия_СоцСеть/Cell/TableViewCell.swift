//
//  TableViewCell.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 21.10.21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var titleLableView: UILabel!
    
    var completion: ((Friend) -> Void)?
    var friend: Friend?
    
    override func prepareForReuse() {
        avatarImageView.image = nil
        titleLableView.text = nil
    }
    
    func configureForFriend(friend: Friend, completion: ((Friend) -> Void)?) {
        self.completion = completion
        self.friend = friend
        avatarImageView.image = friend.avatar
        titleLableView.text = friend.name
    }
    
    func configureForGroup(group: Group) {
        avatarImageView.image = group.avatar
        titleLableView.text = group.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.borderWidth = CGFloat(4)
        avatarImageView.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func pressAvatarButton(_ sender: Any) {
        
        let scale = CGFloat(7)
        let frame = avatarImageView.frame
        
        UIView.animate(withDuration: 2,
                       animations: { [weak self] in
                        guard let self = self else { return }
                        self.avatarImageView.frame = CGRect(x: self.avatarImageView.frame.origin.x - scale / 2, y: self.avatarImageView.frame.origin.y - scale / 2, width: self.avatarImageView.frame.width + scale, height: self.avatarImageView.frame.height + scale) },
                       completion: { isSuccessfull in
                        UIView.animate(withDuration: 2,
                                       delay: 0,
                                       usingSpringWithDamping: 0.3,
                                       initialSpringVelocity: 0.7,
                                       options: []) { [weak self] in
                            self?.avatarImageView.frame = frame
                        } completion: { [weak self] isAllSuccessfully in
                            guard let self = self else { return }
                            if isAllSuccessfully,
                               let friend = self.friend {
                                self.completion?(friend)
                            }
                        }
                       }
        )
    }
}
