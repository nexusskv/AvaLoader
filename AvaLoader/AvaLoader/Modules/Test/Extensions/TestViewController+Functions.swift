//
//  TestViewController+Functions.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension TestViewController {
    
    /// ---> UI customizations <--- ///
    func setupUI() {
        progressBar.gradientColors           = [UIColor.green.cgColor, UIColor.blue.cgColor]    // Set a 2 gradient colors
        progressBar.makeProgress()
        
        nextAvaButton.layer.cornerRadius    = 5
        nextAvaButton.layer.borderWidth     = 1
        nextAvaButton.layer.borderColor     = UIColor.black.cgColor
        
        avaImageView.layer.cornerRadius     = avaImageView.bounds.width / 2.0
        avaImageView.layer.maskedCorners    = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        let firstKey = testImages[0]
        if !firstKey.isEmpty {
            _ = showSavedAvatar(firstKey)
        }
    }
}
