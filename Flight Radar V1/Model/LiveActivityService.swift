//
//  LiveActivityService.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 26/11/2024.
//

import Foundation
import ActivityKit

protocol LiveActivityServiceProtocol {
    func startActivity(for flight: Flight) throws -> String
    func endActivity(identifier: String) async
    func updateActivity(identifier: String, flight: Flight) async
}

class LiveActivityService: LiveActivityServiceProtocol {
    func startActivity(for flight: Flight) throws -> String {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            throw LiveActivityError.activitiesNotEnabled
        }
        
        let attributes = FlightActivityWidgetAttributes(
            name: "Flight \(flight.flightNumber)",
            flightNumber: flight.flightNumber,
            departure: flight.departure,
            departureCity: flight.departureCity,
            departureTime: flight.departureTime,
            destination: flight.destination,
            destinationCity: flight.destinationCity,
            arrivalTime: flight.arrivalTime
        )
        
        let initialState = FlightActivityWidgetAttributes.ContentState.updatedState(
            departureTime: flight.departureTime,
            arrivalTime: flight.arrivalTime
        )
        
        let activityContent = ActivityContent(
            state: initialState,
            staleDate: Date().addingTimeInterval(60)
        )
        
        do {
            let activity = try Activity.request(
                attributes: attributes,
                content: activityContent,
                pushType: nil
            )
            return activity.id
        } catch {
            throw LiveActivityError.startingError(error)
        }
    }
    
    func endActivity(identifier: String) async {
        let activity = Activity<FlightActivityWidgetAttributes>.activities.first { $0.id == identifier }
        await activity?.end(nil)
    }
    
    func updateActivity(identifier: String, flight: Flight) async {
        let activity = Activity<FlightActivityWidgetAttributes>.activities.first { $0.id == identifier }
        
        let updatedState = FlightActivityWidgetAttributes.ContentState.updatedState(
            departureTime: flight.departureTime,
            arrivalTime: flight.arrivalTime
        )
        
        let activityContent = ActivityContent(
            state: updatedState,
            staleDate: Date().addingTimeInterval(60)
        )
        
        await activity?.update(activityContent)
    }
}

enum LiveActivityError: LocalizedError {
    case activitiesNotEnabled
    case startingError(Error)
    
    var errorDescription: String? {
        switch self {
        case .activitiesNotEnabled:
            return "Live Activities are not enabled"
        case .startingError(let error):
            return "Failed to start Live Activity: \(error.localizedDescription)"
        }
    }
}
