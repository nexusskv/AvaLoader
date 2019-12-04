//
//  AvaLoader+Handler.swift
//  AvaLoader
//
//  Created by Rost on 02.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension AvaLoader {
    
    /// ---> Function handle received data <--- ///
    func handleData(_ data: Data) {
        buffer.append(data)
        
        progress = Float(buffer.length) / Float(expectedContentLength)

        if progress < 1.0 {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                
                NotificationCenter.default.post(name: successProgress,
                                                object: nil,
                                                userInfo: ["progress": strongSelf.progress])
            }
        } else {
            if let key = saveImageKey {
                let receivedData = buffer as Data
                
                DispatchQueue.global().async { [weak self] in
                    guard let strongSelf = self else { return }
                    
                    if let image = UIImage(data: receivedData) {
                        if let sized = image.circleImage {
                            if let data = sized.pngData() {
                                DispatchQueue.main.async {
                                    NotificationCenter.default.post(name: successProgress,
                                                                    object: nil,
                                                                    userInfo: ["data": data])
                                }
                                
                                AvaCache.shared.save(key, data: data)
                            } else {
                                strongSelf.passBackError("Failed to get png from data.")
                            }
                        } else {
                            strongSelf.passBackError("Failed to resize and round image.")
                        }
                    } else {
                        strongSelf.passBackError("Failed to make image from received image.")
                    }
                }
            } else {
                passBackError("Key for save image don't passed.")
            }
        }
    }
    
    
    /// ---> Function for handle received error <--- ///
    func handleError(_ error: Error?) {
        progress     = 0.0
        buffer       = NSMutableData()
        saveImageKey = nil
        
        if let result = error {
            passBackError(result.localizedDescription)
        }
    }
    
    
    /// ---> Function for pass back error message to view <--- ///
    func passBackError(_ value: String) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: failureProgress,
                                            object: nil,
                                            userInfo: ["error": value])
        }
    }
}
