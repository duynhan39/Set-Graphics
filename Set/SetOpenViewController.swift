//
//  SetOpenViewController.swift
//  Set
//
//  Created by Cao Trong Duy Nhan on 6/20/19.
//  Copyright © 2019 Nhan Cao. All rights reserved.
//

import UIKit

class SetOpenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        frameView.layer.borderWidth = 5
        frameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) // Black color
    }
    
    @IBOutlet weak var frameView: UIView!
}
