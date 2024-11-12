// FlightActivityWidgetAttributes.swift

import Foundation
import ActivityKit


struct FlightActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var flightNumber: String
        var departure: String
        var departureCity: String
        var departureTime: Date
        var destination: String
        var destinationCity: String
        var arrivalTime: Date
        var timeRemaining: TimeInterval
        var progress: Double {
            // Calcula el tiempo total del vuelo
            let totalTime = arrivalTime.timeIntervalSince(departureTime)
            
            // Evita divisiones por cero en caso de un tiempo total muy pequeño
            guard totalTime > 0 else { return 1.0 }
            
            // Calcula el progreso basado en el tiempo restante
            return 1.0 - (timeRemaining / totalTime)
        }
    }

    var name: String
}

