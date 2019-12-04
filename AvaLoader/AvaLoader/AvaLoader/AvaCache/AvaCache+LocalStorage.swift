//
//  AvaCache+LocalStorage.swift
//  AvaLoader
//
//  Created by Rost on 01.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation


extension AvaCache {
    
    /// ---> Function for load cache from documents folder <--- ///
    func loadLocalCache() {
        let file: FileHandle? = FileHandle(forReadingAtPath: getCachePath().path)

        if let cache = file {
            let data = cache.readDataToEndOfFile()
            cache.closeFile()
            
            do {
                if let images = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String: Data] {
                    imageCache = images
                    print("Count of cached images:", imageCache.values.count)
                }
            } catch {
                print("Couldn't read cache images file.")
            }
        } else {
            print("Cache images file is empty.")
        }
    }
    
    
    /// ---> Function for save cache into documents folder <--- ///
    func saveLocalCache() {
        if imageCache.values.count > 0 {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: imageCache, requiringSecureCoding: false)
                try data.write(to: getCachePath())
            } catch {
                print("Couldn't write file for cache of images.")
            }
        }
    }
    
    
    /// ---> Function for get path to cache <--- ///
    func getCachePath() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fullPath = paths[0].appendingPathComponent("imagesCache.plist")

        return fullPath
    }
}
