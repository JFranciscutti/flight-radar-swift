//
//  LiveActivityViewModel.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 10/11/2024.
//

import Foundation
import Combine
import CoreLocation
import ActivityKit
import SwiftUI

@MainActor // Garantiza que las actualizaciones sean seguras para la interfaz de usuario
class LiveActivityViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    private var activity: Activity<FlightActivityWidgetAttributes>? = nil
    private var timer: Timer?
    
    func startLiveActivity(flight: Flight) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities not enabled")
            return
        }
        
        // Detén cualquier actividad previa
        stopLiveActivity()
        
        let attributes = FlightActivityWidgetAttributes(name: "Flight \(flight.flightNumber)")
        let initialContentState = FlightActivityWidgetAttributes.ContentState(
            flightNumber: flight.flightNumber,
            departure: flight.departure,
            departureCity: flight.departureCity,
            departureTime: flight.departureTime,
            destination: flight.destination,
            destinationCity: flight.destinationCity,
            arrivalTime: flight.arrivalTime,
            timeRemaining: calculateTimeRemaining(timeElapsed: Date(), totalTime: flight.arrivalTime)
        )
        
        Task {
            do {
                activity = try Activity<FlightActivityWidgetAttributes>.request(
                    attributes: attributes,
                    contentState: initialContentState,
                    pushType: nil
                )
                // Inicia el temporizador para actualizar el estado dinámicamente
                startTimer(flight: flight)
                showAlert.toggle()
            } catch {
                print("Failed to start live activity: \(error)")
            }
        }
    }
    
    private func startTimer(flight: Flight) {
        // Programa actualizaciones cada minuto
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            Task {
                await self.updateLiveActivity(flight: flight)
            }
        }
    }
    
    private func stopLiveActivity() {
        timer?.invalidate()
        timer = nil
        
        // Termina la actividad en curso si existe
        Task {
            do {
                try await activity?.end(dismissalPolicy: .immediate)
            } catch {
                print("Failed to end live activity: \(error)")
            }
        }
        activity = nil
    }
    
    private func updateLiveActivity(flight: Flight) async {
        guard let activity = activity else { return }
        
        let updatedContentState = FlightActivityWidgetAttributes.ContentState(
            flightNumber: flight.flightNumber,
            departure: flight.departure,
            departureCity: flight.departureCity,
            departureTime: flight.departureTime,
            destination: flight.destination,
            destinationCity: flight.destinationCity,
            arrivalTime: flight.arrivalTime,
            timeRemaining: calculateTimeRemaining(timeElapsed: Date(), totalTime: flight.arrivalTime)
        )
        
        do {
            try await activity.update(using: updatedContentState)
        } catch {
            print("Failed to update live activity: \(error)")
        }
    }
    
    private func calculateTimeRemaining(timeElapsed: Date, totalTime: Date) -> TimeInterval {
        return max(totalTime.timeIntervalSince(timeElapsed), 0) // Asegura que no devuelva valores negativos
    }
}
