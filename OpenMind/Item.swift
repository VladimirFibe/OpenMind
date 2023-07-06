//
//  Item.swift
//  OpenMind
//
//  Created by MacService on 7/6/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
