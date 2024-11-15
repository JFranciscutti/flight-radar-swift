//
//  FlightMapView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import SwiftUI
import MapKit

struct FlightMapView: View {
    @ObservedObject var flightsViewModel: FlightsViewModel
    @ObservedObject var liveActivityViewModel: LiveActivityViewModel
    
    var body: some View {
        ZStack {
            // Mapa de vuelos
            Map {
                ForEach(flightsViewModel.flights) { flight in
                    Annotation(flight.flightNumber, coordinate: flight.coordinate) {
                        Image(systemName: "airplane")
                            .onTapGesture {
                                flightsViewModel.selectFlight(flight: flight)
                            }
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            
            // Vista con información del vuelo seleccionado
            if flightsViewModel.selectedFlight != nil {
                VStack {
                    Spacer()
                    FlightDetailsView(flightsViewModel: flightsViewModel, liveActivityViewModel:liveActivityViewModel)
                    
                }
                .transition(.move(edge: .bottom))
                .animation(.easeInOut, value: flightsViewModel.selectedFlight)
            }
            
        }
    }
}

#Preview {
    @Previewable @State var selectedFlight: Flight? = mockedFlights.first
    @StateObject var flightsViewModel = FlightsViewModel()
    @StateObject var liveActivityViewModel = LiveActivityViewModel()
    
    FlightMapView(flightsViewModel: flightsViewModel, liveActivityViewModel: liveActivityViewModel)
}
