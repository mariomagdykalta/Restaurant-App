//
//  Order.swift
//  Restaurant
//
//  Created by mario on 02/09/2024.
//
import Foundation

struct Order : Codable {
    var menuItems : [MenuItem]
    
    init(menuItems : [MenuItem] = []) {
        self.menuItems = menuItems
    } // end init
} // end Order
