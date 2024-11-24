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
struct FavoriteFlight: AppIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "FavoriteFlightIntent"

    static var title: LocalizedStringResource = "Vuelo Favorito"
    static var description = IntentDescription("Agrega un vuelo a favoritos")

    @Parameter(title: "Numero de vuelo")
    var flightNumber: String?

    static var parameterSummary: some ParameterSummary {
        Summary("Agregar vuelo \(\.$flightNumber) a favoritos")
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$flightNumber)) { flightNumber in
            DisplayRepresentation(
                title: "Agregar vuelo \(flightNumber!) a favoritos",
                subtitle: ""
            )
        }
    }

    static var suggestedInvocationPhrase: String {
        "Agregar vuelo a favoritos en Radar App"
    }   

   func perform() async throws -> some IntentResult & ProvidesDialog {
        guard let flightNumber = flightNumber else {
            throw FavoriteFlightError.flightNotFound
        }
        
        let userDefaults = UserDefaults(suiteName: "group.com.favorites.temp")
        let favoritesKey = "favoriteFlights"
        
        // Check if flight exists in mocked flights
        guard isFlightNumberInDataFlights(flightNumber) else {
            return .result(
                dialog: .responseNotFound(flightNumber: flightNumber)
            )
        }
        
        // Check if already in favorites
        if let savedData = userDefaults?.data(forKey: favoritesKey),
           let favoriteFlights = try? JSONDecoder().decode([Flight].self, from: savedData),
           favoriteFlights.contains(where: { $0.flightNumber == flightNumber }) {
            return .result(
                dialog: .responseAlreadyInFavorites(flightNumber: flightNumber)
            )
        }
        
        // Add to favorites
        guard let flightToAdd = mockedFlights.first(where: { $0.flightNumber == flightNumber }) else {
            return .result(
                dialog: .responseNotFound(flightNumber: flightNumber)
            )
        }
        
        var favoriteFlights: [Flight] = []
        if let savedData = userDefaults?.data(forKey: favoritesKey) {
            favoriteFlights = (try? JSONDecoder().decode([Flight].self, from: savedData)) ?? []
        }
        
        favoriteFlights.append(flightToAdd)
        
        guard let encodedData = try? JSONEncoder().encode(favoriteFlights),
              let defaults = userDefaults else {
            return .result(
                dialog: .responseFailure(flightNumber: flightNumber)
            )
        }
        
        defaults.set(encodedData, forKey: favoritesKey)
        
        return .result(
            dialog: .responseSuccess(flightNumber: flightNumber)
        )
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static func flightNumberParameterPrompt(flightNumber: String) -> Self {
        "Agrega el vuelo \(flightNumber) a favoritos en Radar App"
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

