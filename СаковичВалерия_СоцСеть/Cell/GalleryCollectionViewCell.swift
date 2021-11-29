//
//  GalleryCollectionViewCell.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 26.10.21.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCounter: UILabel!
    
    var likeEnable = false
    var likeCount = 0
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        likeEnable = false
        likeCount = 0
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
    }
    
    func configure(photo: UIImage) {
        photoImageView.image = photo
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func pressLikeButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        if likeEnable {
            likeCounter.layer.topAnimation(duration: 0.7)
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCount -= 1
            likeCounter.text = String(likeCount)
        } else {
            likeCounter.layer.bottomAnimation(duration: 0.7)
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCount += 1
            likeCounter.text = String(likeCount)
        }
        likeEnable = !likeEnable
    }
    
}
extension CALayer {
    
    func bottomAnimation(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        self.add(animation, forKey: nil)
    }
    
    func topAnimation(duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.duration = duration
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromBottom
        self.add(animation, forKey: nil)
    }
}
