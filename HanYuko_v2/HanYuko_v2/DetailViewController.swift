//
//  DetailViewController.swift
//  HanYuko_v2
//
//  Created by Jacob Pernell on 9/28/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    let backButtonImg = UIImage(named: "backArrow")
    
    var detailImage = UIImage()
    var detailText: String?
    
    @IBOutlet weak var detailViewImage: UIImageView!
    @IBOutlet weak var detailViewDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = detailText
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImg
        self.navigationController?.navigationBar.backItem?.title = ""
        
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Constants.normalTitleFont!,
            NSAttributedString.Key.foregroundColor: Constants.titleColor
        ]
        
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        detailViewImage.image = detailImage
        detailViewDescription.text = detailText
        
    }
}
