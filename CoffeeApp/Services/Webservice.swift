//
//  Webservice.swift
//  CoffeeApp
//
//  Created by Mohammad Azam on 7/18/22.
//

import Foundation

class Webservice: ObservableObject {
    
    @Published var coffeeOrders: [CoffeeOrder] = []
    
    func placeOrder(coffeeOrder: CoffeeOrder) async throws {
        
        // post a new order
        var request = URLRequest(url: URL(string: "https://island-bramble.glitch.me/orders")!)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(coffeeOrder)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, _) = try! await URLSession.shared.data(for: request)
        let savedOrderResponse = try JSONDecoder().decode(SavedOrderResponse.self, from: data)
        
        if savedOrderResponse.success {
            try await populateCoffeeOrders()
        }
    }
    
    func populateCoffeeOrders() async throws {
        
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://island-bramble.glitch.me/orders")!)
        
        Task { @MainActor in
            self.coffeeOrders = try JSONDecoder().decode([CoffeeOrder].self, from: data)
        }
    }
}
