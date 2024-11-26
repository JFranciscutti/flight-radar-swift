//
//  LiveActivityService.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 26/11/2024.
//


import Foundation
import CoreLocation

protocol FlightServiceProtocol {
    func fetchLiveFlights() async throws -> [Flight]
    func saveFavorites(_ flights: [Flight]) throws
    func loadFavorites() throws -> [Flight]
    func isFlightInFavorites(_ flight: Flight) -> Bool
}

class FlightService: FlightServiceProtocol {
    private let userDefaults: UserDefaults
    private let favoritesKey = "favoriteFlights"
    
    init(userDefaults: UserDefaults = UserDefaults(suiteName: "group.com.favorites.temp")!) {
        self.userDefaults = userDefaults
    }
    
    func fetchLiveFlights() async throws -> [Flight] {
        // For now, return mocked flights
        return mockedFlights
    }
    
    func saveFavorites(_ flights: [Flight]) throws {
        do {
            let encodedData = try JSONEncoder().encode(flights)
            userDefaults.set(encodedData, forKey: favoritesKey)
        } catch {
            throw FlightServiceError.savingError
        }
    }
    
    func loadFavorites() throws -> [Flight] {
        guard let savedData = userDefaults.data(forKey: favoritesKey) else {
            return []
        }
        
        do {
            return try JSONDecoder().decode([Flight].self, from: savedData)
        } catch {
            throw FlightServiceError.loadingError
        }
    }
    
    func isFlightInFavorites(_ flight: Flight) -> Bool {
        do {
            let favorites = try loadFavorites()
            return favorites.contains(where: { $0.id == flight.id })
        } catch {
            return false
        }
    }
}

enum FlightServiceError: LocalizedError {
    case savingError
    case loadingError
    
    var errorDescription: String? {
        switch self {
        case .savingError:
            return "Error saving favorites"
        case .loadingError:
            return "Error loading favorites"
        }
    }
}
