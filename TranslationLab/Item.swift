//
//  Item.swift
//  TranslationLab
//
//  Created by Aries on 2025/1/16.
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
