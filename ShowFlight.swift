//
//  ShowFlight.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 26/11/2024.
//

import Foundation
import AppIntents
import SwiftUI

struct ShowFlightIntent: AppIntent, ShowsSnippetView {
    var value: Never?
    
    static var title: LocalizedStringResource = "Mostrar información de vuelo"
    static var description: IntentDescription = IntentDescription(
        "Muestra la información detallada de un vuelo",
        categoryName: "Vuelos"
    )
    
    @Parameter(title: "Número de vuelo", description: "El número del vuelo a mostrar")
    var flightNumber: String?
    
    private let flightService: FlightServiceProtocol = FlightService()
    
    static var parameterSummary: some ParameterSummary {
        Summary("Mostrar información de \(\.$flightNumber)")
    }
    
    static var suggestedInvocationPhrase: String {
        "Muestra el vuelo"
    }
    
   func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
    guard let flightNumber = flightNumber?.trimmingCharacters(in: .whitespacesAndNewlines).uppercased() else {
        throw ShowFlightError.flightNotFound
    }
    
    guard let flight = mockedFlights.first(where: { $0.flightNumber == flightNumber }) else {
        return .result(
            dialog: .responseNotFound(flightNumber: flightNumber),
            view: AnyView(EmptyView())
        )
    }
    
    return .result(
            dialog: .responseSuccess(flightNumber: flightNumber),
            view: AnyView(FlightInfoView(flight: flight))
        )
    }
}

enum ShowFlightError: LocalizedError {
    case flightNotFound
    
    var errorDescription: String {
        switch self {
        case .flightNotFound:
            return "El vuelo no fue encontrado"
        }
    }
}

fileprivate extension IntentDialog {
    static func responseSuccess(flightNumber: String) -> Self {
        "Mostrando información del vuelo \(flightNumber)"
    }
    static func responseNotFound(flightNumber: String) -> Self {
        "No se encontró el vuelo \(flightNumber)"
    }
} 
