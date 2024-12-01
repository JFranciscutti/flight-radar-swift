//
//  FavoriteFlight.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 24/11/2024.
//

import Foundation
import AppIntents

enum FavoriteFlightError: LocalizedError {
    case flightNotFound
    case alreadyInFavorites
    case savingError
    
    var errorDescription: String {
        switch self {
        case .flightNotFound:
            return "El vuelo no fue encontrado"
        case .alreadyInFavorites:
            return "El vuelo ya está en favoritos"
        case .savingError:
            return "No se pudo guardar el vuelo en favoritos"
        }
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct FavoriteFlight: AppIntent {
    static var title: LocalizedStringResource = "Agregar vuelo a favoritos"
    static var description: IntentDescription = IntentDescription(
        "Agrega un vuelo a tu lista de favoritos",
        categoryName: "Vuelos"
    )
    
    @Parameter(title: "Número de vuelo", description: "El número del vuelo a agregar")
    var flightNumber: String?
    
    private let flightService: FlightServiceProtocol = FlightService()
    
    static var parameterSummary: some ParameterSummary {
        Summary("Agregar \(\.$flightNumber) a favoritos")
    }
    
    static var suggestedInvocationPhrase: String {
        "Agrega el vuelo a favoritos"
    }
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        guard let flightNumber = flightNumber?.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() else {
            throw FavoriteFlightError.flightNotFound
        }
        
        // Check if flight exists in mocked flights
        guard let flightToAdd = mockedFlights.first(where: { $0.flightNumber == flightNumber }) else {
            return .result(
                dialog: .responseNotFound(flightNumber: flightNumber)
            )
        }
        
        do {
            // Check if already in favorites
            if flightService.isFlightInFavorites(flightToAdd) {
                return .result(
                    dialog: .responseAlreadyInFavorites(flightNumber: flightNumber)
                )
            }
            
            // Load current favorites
            var favorites = try flightService.loadFavorites()
            
            // Add new flight
            favorites.append(flightToAdd)
            
            // Save updated favorites
            try flightService.saveFavorites(favorites)
            
            return .result(
                dialog: .responseSuccess(flightNumber: flightNumber)
            )
        } catch {
            return .result(
                dialog: .responseFailure(flightNumber: flightNumber)
            )
        }
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static func flightNumberParameterPrompt(flightNumber: String) -> Self {
        "Sigue el vuelo \(flightNumber)"
    }
    static var flightNumberParameterEmpty: Self {
        "El numero de vuelo no puede ser vacio"
    }
    static func responseSuccess(flightNumber: String) -> Self {
        "El vuelo \(flightNumber) fue agregado a favoritos"
    }
    static func responseFailure(flightNumber: String) -> Self {
        "No se pudo agregar el vuelo \(flightNumber) a favoritos"
    }
    static func responseAlreadyInFavorites(flightNumber: String) -> Self {
        "El vuelo \(flightNumber) ya está en favoritos"
    }
    static func responseNotFound(flightNumber: String) -> Self {
        "El vuelo \(flightNumber) no ha sido encontrado"
    }
}

