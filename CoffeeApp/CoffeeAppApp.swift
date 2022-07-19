//
//  CoffeeAppApp.swift
//  CoffeeApp
//
//  Created by Mohammad Azam on 7/18/22.
//

import SwiftUI

@main
struct CoffeeAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView().environmentObject(Webservice())
            }
        }
    }
}
