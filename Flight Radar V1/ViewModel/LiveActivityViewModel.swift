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

@MainActor
class LiveActivityViewModel: ObservableObject {
    @Published var showAlert: Bool = false
    @Published var activityIdentifier: String = ""
    
    func startParsingLiveActivity(flight: Flight) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            print("Live Activities not enabled")
            return
        }
        
        let attributes = FlightActivityWidgetAttributes(name: "Flight \(flight.flightNumber)", flightNumber: flight.flightNumber, departure: flight.departure, departureCity: flight.departureCity, departureTime: flight.departureTime, destination: flight.destination, destinationCity: flight.destinationCity, arrivalTime: flight.arrivalTime)
        
        do {
            activityIdentifier = try startLiveActivity(for: attributes)
            showAlert.toggle()
        } catch {
            print(error)
        }
        
    }
    
    private func startLiveActivity(for flight: FlightActivityWidgetAttributes) throws -> String {
        let initialState = FlightActivityWidgetAttributes.ContentState.updatedState(
            departureTime: flight.departureTime,
            arrivalTime: flight.arrivalTime
        )
        
        let activityContent = ActivityContent(state: initialState, staleDate: Date().addingTimeInterval(60))
    
        
        do {
            let activity = try Activity.request(
                attributes: flight,
                content: activityContent,
                pushType: nil
            )
            
            print("Requested a Live Activity with id \(activity.id)")
            
            return activity.id
            
        } catch {
            print("Failed to request a Live Activity: \(error.localizedDescription)")
            throw error
        }
    }
    
    func endLiveActivity(activityIdentifier: String) async {
        let activity = Activity<FlightActivityWidgetAttributes>.activities.first { $0.id == activityIdentifier }
        await activity?.end(nil)
    }
    
    
    func updateLiveActivity(activityIdentifier: String, flight: FlightActivityWidgetAttributes) async {
        print("Live Activity updating.")
        print(activityIdentifier)
        
        let updatedState = FlightActivityWidgetAttributes.ContentState.updatedState(
            departureTime: flight.departureTime,
            arrivalTime: flight.arrivalTime
        )
        
        let activity = Activity<FlightActivityWidgetAttributes>.activities.first { $0.id == activityIdentifier }
        
        let activityContent = ActivityContent(state: updatedState, staleDate: Date().addingTimeInterval(60))
        
        await activity?.update(activityContent)
        print("Live Activity updated.")
        
    }
}

