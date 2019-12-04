//
//  TestViewController+ObserverSelectors.swift
//  AvaLoader
//
//  Created by Rost on 02.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension TestViewController {
    
    /// ---> Success observer selector <--- ///
    @objc func refreshProgressBar(_ sender: Notification) {
        if let info = sender.userInfo {
            if let data = info["data"] as? Data {
                progressBar.reloadProgress()
                
                showLoadedAvatar(data)
                
                nextAvaButton.isEnabled = true      // unlock button for load next avatar
            } else {
                let count = info["progress"] as! Float
                progressBar.progress = count
            }
        }
    }
    
    
    /// ---> Failed observer selector <--- ///
    @objc func loadImageDidFailed(_ sender: Notification) {
        nextAvaButton.isEnabled = true              // unlock button for load next avatar
        
        if let info = sender.userInfo {
            if let error = info["error"] as? String {
                let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
