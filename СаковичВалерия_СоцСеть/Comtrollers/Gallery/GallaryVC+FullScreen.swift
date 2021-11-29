//
//  GallaryVC+FullScreen.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 14.11.21.
//

import UIKit

extension GalleryViewController {
    
    func showFullScreenImage(image: UIImage) {
        if fullScreenImageView == nil {
            fullScreenImageView = UIView(frame: self.view.safeAreaLayoutGuide.layoutFrame)
        }
        fullScreenImageView!.backgroundColor = UIColor.systemGray5
        self.view.addSubview(fullScreenImageView!)
        
        let tapRecongnizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        fullScreenImageView?.addGestureRecognizer(tapRecongnizer)
        
        let imageView = UIImageView(image: image)
        fullScreenImageView?.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: fullScreenImageView!.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: fullScreenImageView!.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: fullScreenImageView!.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: fullScreenImageView!.widthAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        
    }
    
    
    @objc func onTap() {
        guard let fullScreenImageView = self.fullScreenImageView else { return }
        fullScreenImageView.removeFromSuperview()
    }
}
