//
//  GalleryViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 26.10.21.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let reuserIndetifierGalleryCell = "reuserIndetifierGalleryCell"
    
    var photos = [UIImage]()
    
    var fullScreenImageView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GalleryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuserIndetifierGalleryCell)
    }
}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuserIndetifierGalleryCell, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(photo: self.photos[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showFullScreenImage(image: self.photos[indexPath.item])
    }

}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let blankSpace = CGFloat(8)
        let cellsInLineCount = CGFloat(3)
        let cellWidth = collectionViewWidth / cellsInLineCount - blankSpace
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
