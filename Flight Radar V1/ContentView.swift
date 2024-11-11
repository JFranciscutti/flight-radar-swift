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
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(Color.white)
                    .padding(.leading)
                    .frame(width: 50.0, height: 50.0)
                
                Spacer()
                Text("Flight Radar")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer()
                Image(systemName: "questionmark.circle")
                    .foregroundColor(Color.white)
                    .padding(.trailing)
                    .frame(width: 50.0, height: 50.0)
            }
            
            FlightMapView(flightsViewModel: flightsViewModel, liveActivityViewModel: liveActivityViewModel)
        }
        .background(Color(red: 0.183, green: 0.309, blue: 0.426))
    }
    
   
    
    
}

#Preview {
    ContentView()
}
