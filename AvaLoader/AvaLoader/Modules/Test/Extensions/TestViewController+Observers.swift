//
//  TestViewController+Observers.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension TestViewController {
    
    /// ---> Constructor for observers <--- ///
    func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(refreshProgressBar),
                                               name: successProgress,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(loadImageDidFailed),
                                               name: failureProgress,
                                               object: nil)
    }
    
    
    /// ---> Destructor for observers <--- ///
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
