//
//  ContentView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 07/10/2024.
//

import SwiftUI
import CoreLocation
import ActivityKit
import Foundation

struct ContentView: View {
    @StateObject private var flightsViewModel: FlightsViewModel
    @StateObject private var liveActivityViewModel: LiveActivityViewModel
    
    @State private var showMenu = false
    @State private var selectedTab = 0

    init(
        flightService: FlightServiceProtocol = FlightService(),
        liveActivityService: LiveActivityServiceProtocol = LiveActivityService()
    ) {
        _flightsViewModel = StateObject(wrappedValue: FlightsViewModel(flightService: flightService))
        _liveActivityViewModel = StateObject(wrappedValue: LiveActivityViewModel(liveActivityService: liveActivityService))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        FlightMapView(flightsViewModel: flightsViewModel, liveActivityViewModel: liveActivityViewModel)
                    }
                    .toolbar(.hidden, for: .tabBar)
                    .tag(0)
                    
                    FavoritesView(flightsViewModel: flightsViewModel).tag(1)
                    
                    HelpAndFAQView().tag(2)
                }
                
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .toolbarBackground(Color(red: 0.18, green: 0.309, blue: 0.426),
                               for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMenu.toggle()
                    }, label: {
                        Image(systemName: "line.3.horizontal")
                    })
                }
            }
            
        }
        
        
    }
    
}

#Preview {
    ContentView()
}
