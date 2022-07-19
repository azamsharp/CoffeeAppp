//
//  AddCoffeeOrderView.swift
//  CoffeeApp
//
//  Created by Mohammad Azam on 7/18/22.
//

import SwiftUI

struct AddCoffeeOrderView: View {
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var total: String = ""
    @State private var selectedCoffee: CoffeeSize = .medium
    
    @EnvironmentObject private var webservice: Webservice
    @Environment(\.dismiss) var dismiss
    
    @State private var errorMessage: String = ""
    
    // client side validation 
    var isValid: Bool {
        return !name.isEmpty && !coffeeName.isEmpty && !total.isEmpty
    }
    
    private func placeOrder() {
        
        // place order
        let order = CoffeeOrder(name: name, coffeeName: coffeeName, total: Double(total) ?? 0.0, size: selectedCoffee)
        Task {
            try? await webservice.placeOrder(coffeeOrder: order)
            dismiss()
        }
    }
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Coffee name", text: $coffeeName)
            Picker("Coffee Size", selection: $selectedCoffee) {
                ForEach(CoffeeSize.allCases, id: \.self) { coffeeSize in
                    Text(coffeeSize.rawValue).tag(selectedCoffee.rawValue)
                }
            }.pickerStyle(.segmented)
            
            TextField("Total", text: $total)
            
            Button {
                
                if(isValid) {
                    placeOrder()
                } else {
                    // show message to the user
                    errorMessage = "Unable to place an order!"
                }
                
            } label: {
                Text("Place Order")
                    .frame(maxWidth: .infinity)
            }
            
            Text(errorMessage)
        }
    }
}

struct AddCoffeeOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoffeeOrderView()
    }
}
