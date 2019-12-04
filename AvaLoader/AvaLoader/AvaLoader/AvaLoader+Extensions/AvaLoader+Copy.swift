//
//  AvaLoader+Copy.swift
//  AvaLoader
//
//  Created by Rost on 01.12.2019.
//  Copyright © 2019 Rost Gress. All rights reserved.
//

import Foundation
import UIKit


extension AvaLoader: NSCopying {

    /// ---> Copy function for singleton <--- ///
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
