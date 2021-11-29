//
//  PhotoSwipeViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 13.11.21.
//

import UIKit

class PhotoSwipeViewController: UIViewController {
    
    
    @IBOutlet weak var photoSwipeView: PhotoSwipeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = [UIImage(named: "Alice")!, UIImage(named: "Alice2")!, UIImage(named: "Alice3")!]
        photoSwipeView.setImages(images: images)
    }
    

}
