//
//  LoadingUIViewController.swift
//  СаковичВалерия_СоцСеть
//
//  Created by Валерия Сакович on 8.11.21.
//

import UIKit

class LoadingUIViewController: UIViewController {
    
    @IBOutlet weak var loadingCloudView: LoadingCloudView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingCloudView.animateCloud()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


