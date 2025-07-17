//
//  Item.swift
//  ReelDeel
//
//  Created by kumara.c on 17/07/25.
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
