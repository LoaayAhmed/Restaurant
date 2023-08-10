//
//  PrepTime.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//

import Foundation




struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
