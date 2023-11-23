//
//  Item.swift
//  Calculator
//
//  Created by Lincoln Edsall on 11/19/23.
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
