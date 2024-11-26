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
    @Published private(set) var activityIdentifier: String = ""
    
    private let liveActivityService: LiveActivityServiceProtocol
    
    init(liveActivityService: LiveActivityServiceProtocol = LiveActivityService()) {
        self.liveActivityService = liveActivityService
    }
    
    func startParsingLiveActivity(flight: Flight) {
        do {
            activityIdentifier = try liveActivityService.startActivity(for: flight)
            showAlert = true
        } catch {
            print("Error starting live activity: \(error.localizedDescription)")
        }
    }
    
    func endLiveActivity() async {
        await liveActivityService.endActivity(identifier: activityIdentifier)
    }
    
    func updateLiveActivity(flight: Flight) async {
        await liveActivityService.updateActivity(identifier: activityIdentifier, flight: flight)
    }
}

