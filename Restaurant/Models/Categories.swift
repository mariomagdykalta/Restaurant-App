//
//  IntermediaryModels.swift
//  Restaurant
//
//  Created by mario on 02/09/2024.
//
import Foundation

struct Categories: Codable {
    let categories: [String]
} // end struct Categories

struct PreparationTime: Codable {
    let prepTime: Int
    
    enum CodeingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    } // end enum

} // end struct PreparationTime
