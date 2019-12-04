//
//  TestViewController+Actions.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension TestViewController {
        
    /// ---> Next button action <--- ///
    @IBAction func nextAvaButtonTapped(_ sender: UIButton) {
        sender.isEnabled = false    // lock button for load one image at one time

        if nextIndex < testImages.count {
            avaImageView.image = UIImage(named: "ava_holder")
            
            let keyPath = testImages[nextIndex]
            
            let isShowedLocal = showSavedAvatar(keyPath)
            
            if !isShowedLocal {
                AvaLoader.shared.loadAvatar(keyPath,
                                            size: avaImageView.bounds.size)
            } else {
                nextAvaButton.isEnabled = true              // unlock button for load next avatar
            }
            
            nextIndex += 1
        } else {
            nextIndex = 0                                   // set start index for next loop
            nextAvaButtonTapped(nextAvaButton)
        }
    }
}
