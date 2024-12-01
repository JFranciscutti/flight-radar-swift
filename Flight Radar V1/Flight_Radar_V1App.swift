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
        configureAndDonateSiriIntent()
    }
    
    var body: some Scene {
          WindowGroup {
              ContentView()
          }
      }
    
    private func configureAndDonateSiriIntent() {
        Task {
        // Donate favorite flight intent
        let favoriteIntent = FavoriteFlight()
        favoriteIntent.flightNumber = "AA123"
        _ = try? await favoriteIntent.donate()
        
        // Donate show flight intent
        let showFlightIntent = ShowFlightIntent()
        showFlightIntent.flightNumber = "AA123"
        _ = try? await showFlightIntent.donate()
        
        // Update shortcuts
            RadarAppShortcuts.updateAppShortcutParameters()
        }
    }
}

struct RadarAppShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        
            AppShortcut(
                intent: FavoriteFlight(),
                phrases: [
                "Agregar vuelo a favoritos en \(.applicationName)",
                "Guardar vuelo en \(.applicationName)",
                "Añadir vuelo a \(.applicationName)"
            ],
            shortTitle: "Agregar vuelo a favoritos",
            systemImageName: "star.fill"
        )
        
        AppShortcut(
            intent: ShowFlightIntent(),
            phrases: [
                "Muestra el vuelo en \(.applicationName)",
                "Ver vuelo en \(.applicationName)",
                "Mostrar vuelo en \(.applicationName)"
            ],
            shortTitle: "Mostrar vuelo",
            systemImageName: "airplane"
        )
        
        
    }
    
}
