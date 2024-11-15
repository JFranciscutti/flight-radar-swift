//
//  FavoritesView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 15/11/2024.
//

import SwiftUI
import CoreLocation

struct FavoritesView: View {
    @ObservedObject var flightsViewModel: FlightsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if flightsViewModel.favoriteFlights.isEmpty {
                    Text("No tienes vuelos favoritos.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(flightsViewModel.favoriteFlights) { flight in
                                FlightRowView(flight: flight)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        if let index = flightsViewModel.favoriteFlights.firstIndex(where: { $0.id == flight.id }) {
                                            flightsViewModel.removeFavorite(at: IndexSet(integer: index))
                                        }
                                    } label: {
                                        Text("Eliminar")
                                    }
                                }
                        }
                       
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("Vuelos Favoritos")
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        flightsViewModel.removeFavorite(at: offsets)
       }
}

struct FlightRowView: View {
    let flight: Flight
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Vuelo:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(flight.flightNumber)
                    .font(.subheadline)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Salida:")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(flight.departureCity) (\(flight.departure))")
                        .font(.caption)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Destino:")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text("\(flight.destinationCity) (\(flight.destination))")
                        .font(.caption)
                }
            }
            
            HStack {
                Text("Hora de Salida:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text(flight.departureTime, style: .time)
            }
            
            HStack {
                Text("Hora de Llegada:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text(flight.arrivalTime, style: .time)
            }
            
            HStack {
                Text("Altitud:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text("\(flight.altitude) pies")
                Spacer()
                Text("Velocidad:")
                    .font(.caption)
                    .fontWeight(.bold)
                Text("\(flight.speed) km/h")
            }
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 3)
    }
}

