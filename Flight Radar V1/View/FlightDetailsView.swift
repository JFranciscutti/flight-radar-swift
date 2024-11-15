//
//  SwiftUIView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import SwiftUI

struct FlightDetailsView: View {
    @ObservedObject var flightsViewModel: FlightsViewModel
    @ObservedObject var liveActivityViewModel: LiveActivityViewModel
        
    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            HStack(alignment: .center) {
                Image(systemName: flightsViewModel.isSelectedFlightFavorite() ? "star.fill" : "star").onTapGesture {
                    flightsViewModel.markAsFavorite()
                }
                Spacer()
                Image(systemName: "xmark").onTapGesture {
                    flightsViewModel.unSelectFlight()
                }
            }
            .padding(.all)
            Text("Flight: \(flightsViewModel.selectedFlight?.flightNumber ?? "N/A")")
                .font(.headline)
            Text("Altitude: \(flightsViewModel.selectedFlight?.altitude ?? "N/A")")
            Text("Speed: \(flightsViewModel.selectedFlight?.speed ?? "N/A")")
            Text("Departure: \(flightsViewModel.selectedFlight?.departure ?? "N/A")")
            Text("Arrival: \(flightsViewModel.selectedFlight?.destination ?? "N/A")")
            
            VStack {
                Button("Seguir vuelo en vivo") {
                        if let selectedFlight = flightsViewModel.selectedFlight {
                             liveActivityViewModel.startLiveActivity(flight: selectedFlight)
                        }
                    
                    
                }
                .padding(.top)
                .alert(isPresented: $liveActivityViewModel.showAlert) {
                    Alert(
                        title: Text("Live Activity Iniciada"),
                        message: Text("Ahora estás siguiendo el vuelo en vivo."),
                        dismissButton: .default(Text("OK"), action: {
                            flightsViewModel.unSelectFlight()
                        })
                    )
                }
            }
           
        }
        .frame(width: 250.0, height: 350.0)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

#Preview {
    @StateObject var flightsViewModel = FlightsViewModel()
    @StateObject var liveActivityViewModel = LiveActivityViewModel()
    
    FlightDetailsView(flightsViewModel: flightsViewModel, liveActivityViewModel: liveActivityViewModel)
}
