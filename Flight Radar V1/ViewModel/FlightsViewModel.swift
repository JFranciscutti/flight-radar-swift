//
//  FlightsViewModel.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 10/11/2024.
//

import Foundation
import Combine
import CoreLocation

@MainActor
class FlightsViewModel: ObservableObject {
    @Published private(set) var flights: [Flight] = []
    @Published private(set) var favoriteFlights: [Flight] = []
    @Published var selectedFlight: Flight?
    
    private let flightService: FlightServiceProtocol
    
    init(flightService: FlightServiceProtocol = FlightService()) {
        self.flightService = flightService
        Task {
            await loadInitialData()
        }
    }
    
    private func loadInitialData() async {
        do {
            flights = try await flightService.fetchLiveFlights()
            favoriteFlights = try flightService.loadFavorites()
        } catch {
            print("Error loading initial data: \(error.localizedDescription)")
        }
    }
    
    func markAsFavorite() {
        guard let selectedFlight = selectedFlight else { return }
        
        if favoriteFlights.contains(where: { $0.id == selectedFlight.id }) {
            favoriteFlights.removeAll(where: { $0.id == selectedFlight.id })
        } else {
            favoriteFlights.append(selectedFlight)
        }
        
        do {
            try flightService.saveFavorites(favoriteFlights)
        } catch {
            print("Error saving favorites: \(error.localizedDescription)")
        }
    }
    
    func selectFlight(flight: Flight) {
        selectedFlight = flight
    }
    
    func unSelectFlight() {
        selectedFlight = nil
    }
    
    func isSelectedFlightFavorite() -> Bool {
        guard let selectedFlight = selectedFlight else { return false }
        return flightService.isFlightInFavorites(selectedFlight)
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favoriteFlights.remove(atOffsets: offsets)
        do {
            try flightService.saveFavorites(favoriteFlights)
        } catch {
            print("Error removing favorite: \(error.localizedDescription)")
        }
    }
    
    func refetchLocalData() {
        do {
            favoriteFlights = try flightService.loadFavorites()
        } catch {
            print("Error refetching data: \(error.localizedDescription)")
        }
    }
}
