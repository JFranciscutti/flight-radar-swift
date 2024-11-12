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
    @StateObject var flightsViewModel = FlightsViewModel()
    @StateObject var liveActivityViewModel = LiveActivityViewModel()
    @State private var showMenu = false
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    VStack {
                        FlightMapView(flightsViewModel: flightsViewModel, liveActivityViewModel: liveActivityViewModel)
                    }
                    .ignoresSafeArea(edges: .bottom)
                    .tag(0)
                    
                    Text("Favoritos").tag(1)
                    
                    Text("Ayuda").tag(2)
                }
                
                SideMenuView(isShowing: $showMenu, selectedTab: $selectedTab)
            }
            .toolbar(showMenu ? .hidden : .visible, for: .navigationBar)
            .toolbarBackground(Color(red: 0.18, green: 0.309, blue: 0.426),
                               for: .navigationBar)
            .navigationTitle("Radar de vuelos")
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
