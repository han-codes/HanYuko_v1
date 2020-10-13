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
    @IBOutlet weak var gradientBg: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title and back button
        title = detailText
        self.navigationController?.navigationBar.backIndicatorImage = backButtonImg
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImg

        // gradient bg
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientBg.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.cornerRadius = 20
        gradientBg.layer.insertSublayer(gradientLayer, at: 0)

        // title attributes
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: Constants.normalTitleFont!,
            NSAttributedString.Key.foregroundColor: Constants.titleColor
        ]
        navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        
        // set image and description
        detailViewImage.image = detailImage
        detailViewDescription.text = detailText
        
        // bring z-depth of description to front
        detailViewDescription.bringSubviewToFront(view)
        
    }
}
