//
//  AvaLoader.swift
//  AvaLoader
//
//  Created by Rost on 30.11.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


class AvaLoader: NSObject {    
    var buffer: NSMutableData = NSMutableData()
    var session: URLSession?
    var dataTask: URLSessionDataTask?
    var expectedContentLength = 0
    var progress: Float       = 0.0
    var saveImageKey: String!
    var saveImageSize: CGSize!
    
    static var shared: AvaLoader = {
        let instance = AvaLoader()
        return instance
    }()

    /// ---> Private constructor for singleton <--- ///
    private override init() {}
        
    
    /// ---> Function for download images <--- ///
    func loadAvatar(_ path: String, size: CGSize) {
        progress = 0.0
        dataTask?.cancel()

        let link = testApi + "/" + path + "?" + compressParam
        
        guard let url = URL(string: link) else {
            print("Link for image is invalid!")
            return
        }
        
        saveImageKey  = path
        saveImageSize = size
        
        session = URLSession(configuration: URLSessionConfiguration.default,
                             delegate:      self,
                             delegateQueue: OperationQueue.current)
        
        dataTask = session?.dataTask(with: URLRequest(url: url))
        dataTask?.resume()
    }
}
