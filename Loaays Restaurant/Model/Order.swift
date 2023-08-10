//
//  Order.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//

import Foundation



struct order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}

