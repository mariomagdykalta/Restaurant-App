//
//  MenuItem.swift
//  Restaurant
//
//  Created by mario on 02/09/2024.
//
import Foundation

struct MenuItem: Codable {
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
} // end struct MenuItem


struct MenuItems: Codable {
    let items: [MenuItem]
} // end struct MenuItems




