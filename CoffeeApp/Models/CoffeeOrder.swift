//
//  Coffee.swift
//  CoffeeApp
//
//  Created by Mohammad Azam on 7/18/22.
//

import Foundation

enum CoffeeSize: String, Codable, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
}

struct CoffeeOrder: Codable, Identifiable {
    
    let name: String
    let coffeeName: String
    let total: Double
    let size: CoffeeSize
    
    var id: UUID { return UUID() }
}
