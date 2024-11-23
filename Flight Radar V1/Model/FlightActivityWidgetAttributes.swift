// FlightActivityWidgetAttributes.swift

import Foundation
import ActivityKit


struct FlightActivityWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var timeRemaining: String
        var progress: Double
    }
    
    var name: String
    var flightNumber: String
    var departure: String
    var departureCity: String
    var departureTime: Date
    var destination: String
    var destinationCity: String
    var arrivalTime: Date
}

extension FlightActivityWidgetAttributes.ContentState {
    static func updatedState(departureTime: Date, arrivalTime: Date) -> FlightActivityWidgetAttributes.ContentState {
        let currentTime = Date()
        let totalDuration = arrivalTime.timeIntervalSince(departureTime)
        let elapsedTime = currentTime.timeIntervalSince(departureTime)
        
        // Calcula el progreso
        let progress = min(max(elapsedTime / totalDuration, 0), 1)
        
        // Calcula el tiempo restante
        let remainingTime = max(arrivalTime.timeIntervalSince(currentTime), 0)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        let timeRemainingString = formatter.string(from: remainingTime) ?? "0m"
        
        print("Progress: \(progress)")
        
        print("Time Remaining: \(timeRemainingString)")
        
        return FlightActivityWidgetAttributes.ContentState(timeRemaining: timeRemainingString, progress: progress)
    }
}
