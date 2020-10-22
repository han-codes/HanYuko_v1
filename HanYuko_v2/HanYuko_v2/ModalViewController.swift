//
//  ModalViewController.swift
//  HanYuko_v2
//
//  Created by Jacob Pernell on 10/13/20.
//  Copyright © 2020 Jacob Pernell. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var modalImageView: UIImageView!
    
    var modalImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalImageView.image = modalImage
    }
    
    @IBAction func modalClose(_ sender: UIButton) {
        self.modalTransitionStyle = .coverVertical
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
