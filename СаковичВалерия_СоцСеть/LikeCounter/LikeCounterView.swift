//
//  LikeConterView.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 28.10.21.
//

import UIKit

protocol LikeCounterProtocol: AnyObject {
    func likeCounterIncrement(counter: Int)
    func likeCounterDecrement(counter: Int)
}

@IBDesignable class LikeCounterView: UIView {

    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeCounter: UILabel!
    
    var likeEnable = false
    @IBInspectable var likeCount: Int = 0
    
    weak var delegate: LikeCounterProtocol?
    
    private var view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikeCounterView", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return UIView()}
        return view
    }
    
    private func setup() {
        view = loadFromNib()
        guard let view = view else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        likeCounter.text = String(likeCount)
    }
    
    @IBAction func pressLikeButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if likeEnable {
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            likeCount -= 1
            likeCounter.text = String(likeCount)
            delegate?.likeCounterDecrement(counter: likeCount)
        } else {
            button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeCount += 1
            likeCounter.text = String(likeCount)
            delegate?.likeCounterIncrement(counter: likeCount)
        }
        likeEnable = !likeEnable
    }
}
