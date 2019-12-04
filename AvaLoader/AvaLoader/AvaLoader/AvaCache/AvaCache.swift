//
//  AvaCache.swift
//  AvaLoader
//
//  Created by Rost on 01.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit





class AvaCache: NSObject {
    let cacheKeySeparator   = "$#$"         // Set separator between time stamp and path of image
    let cacheLimit          = 10            // Set limit for store data of images here
    
    var imageCache = [String: Data]()       // Dictionary for store data of images
    
    static var shared: AvaCache = {
        let instance = AvaCache()

        return instance
    }()
    
    /// ---> Private constructor for singleton <--- ///
    private override init() {}
    
    
    /// ---> Function for save received data to cache of data <--- ///
    func save(_ name: String?, data: Data?) {
        guard let title = name, let content = data else {
            print("Title for image or data is nil.")
            return
        }

        let timeStamp = Int64(Date().timeIntervalSince1970 * 1000)
        let key = "\(timeStamp)" + cacheKeySeparator + title
        
        guard let _ = fetch(key) else {
            if imageCache.values.count >= cacheLimit {
                removeOldImage()
            }
            
            imageCache[key] = content
            return
        }
    }
    
    
    /// ---> Function for fetch data from cache <--- ///
    func fetch(_ value: String) -> Data? {
        let allKeys = imageCache.keys

        let resultKeys = allKeys.filter { $0.contains(value) }
        if let key = resultKeys.first {
            if let data = imageCache[key] {
                return data
            }
        }
       
        return nil
    }
    
    
    /// ---> Function for remove oldest data from cache <--- ///
    func removeOldImage() {
        let allKeys = imageCache.keys
        let sortedKeys = allKeys.sorted { $0.lowercased() < $1.lowercased() }
        if let key = sortedKeys.first {
            imageCache.removeValue(forKey: key)
        }
    }

    
    /// ---> Function for get count of objects in cache <--- ///
    func getTotalObjects() -> Int {
        print(imageCache.keys)
        return imageCache.values.count
    }
}
