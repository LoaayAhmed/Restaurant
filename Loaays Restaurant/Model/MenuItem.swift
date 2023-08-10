//
//  MenuItem.swift
//  Loaays Restaurant
//
//  Created by user203868 on 8/5/23.
//


import Foundation



// MARK: - Item
struct MenuItem: Codable {
    let category: String
    let id: Int
    let imageURL: URL
    let name, description: String
    let price: Double

    enum CodingKeys: String, CodingKey {
        case category, id
        case imageURL = "image_url"
        case name, description, price
    }
    
    
    
    static var defaultItem = MenuItem(category: "unknown", id: 1, imageURL: URL(string: "image_url")!, name: "unknown", description: "desc", price: 0.0)}

struct MenuItems: Codable {
    let items: [MenuItem]
}
