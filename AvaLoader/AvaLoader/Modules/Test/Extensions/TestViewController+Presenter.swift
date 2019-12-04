//
//  TestViewController+Presenter.swift
//  AvaLoader
//
//  Created by Rost on 02.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension TestViewController {
    
    /// ---> Presenter for cached avatars <--- ///
    func showSavedAvatar(_ key: String) -> Bool {
        if let data = AvaCache.shared.fetch(key) {
            showLoadedAvatar(data)
            
            return true
        }
        
        return false
    }
    
    
    /// ---> Presenter for data of avatars <--- ///
    func showLoadedAvatar(_ data: Data) {
        let transition              = CATransition()
        transition.duration         = 0.8
        transition.timingFunction   = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type             = .fade
        
        if let image = UIImage(data: data) {
            avaImageView.image = image
        }
        
        avaImageView.layer.add(transition, forKey: nil)
    }
}
