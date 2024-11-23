//
//  Flight_Radar_V1App.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 07/10/2024.
//

import SwiftUI
import AppIntents
import Intents

@main
struct Flight_Radar_V1App: App {
    
    init() {
        donateIntent()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    
    
    
    func donateIntent() {
        let intent = FavoriteFlightIntent()
        intent.suggestedInvocationPhrase = "Agregar vuelo a favoritos"
        intent.flightNumber = "AA123"
        
        let interaction = INInteraction(intent: intent, response: nil)
        
        interaction.donate() {(error) in
            
            if error != nil {
                if let error = error as NSError? {
                    print("Interaction donated failed with error: \(error.description)")
                } else {
                    print("Successful donation")
                }
            }
        }
    }
}
