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

class LiveActivityViewModel: ObservableObject {
    
    @State private var activity: Activity<FlightActivityWidgetAttributes>? = nil
    @Published var showAlert: Bool = false

    func startLiveActivity(flight: Flight) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities not enabled")
            return
        }
        
        if (activity != nil) {
            activity = nil
        }
                
        let attributes = FlightActivityWidgetAttributes(name: "Flight \(flight.flightNumber)")
        let contentState = FlightActivityWidgetAttributes.ContentState(
            flightNumber: flight.flightNumber,
            departure: flight.departure,
            departureCity: flight.departureCity,
            departureTime: flight.departureTime,
            destination: flight.destination,
            destinationCity: flight.destinationCity,
            arrivalTime: flight.arrivalTime,
            timeRemaining: calculateTimeRemaining(timeElapsed: flight.departureTime, totalTime: flight.arrivalTime)
        )
        
        activity = try? Activity<FlightActivityWidgetAttributes>.request(attributes: attributes, contentState: contentState, pushType: nil)
        
        toggleShowAlert()
    }
    
    private func calculateTimeRemaining(timeElapsed: Date, totalTime: Date) -> TimeInterval {
        return totalTime.timeIntervalSince(timeElapsed)
    }
    
    func toggleShowAlert () {
        showAlert = !showAlert
    }

}

