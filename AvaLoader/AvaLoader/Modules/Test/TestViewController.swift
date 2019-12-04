//
//  TestViewController.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    @IBOutlet weak var avaImageView: UIImageView!
    @IBOutlet weak var nextAvaButton: UIButton!
    @IBOutlet weak var progressBar: AvaProgressBar!
    var nextIndex = 0
    
    
    /// ---> View life cycle <--- ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        addObservers()
    }
    
    deinit {
        removeObservers()
    }
}

