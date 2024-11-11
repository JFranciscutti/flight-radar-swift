//
//  Flight.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import Foundation
import CoreLocation

struct Flight: Identifiable, Equatable {
    static func == (lhs: Flight, rhs: Flight) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var flightNumber: String
    var departure: String
    var departureCity: String
    var departureTime: Date
    var destination: String
    var destinationCity: String
    var arrivalTime: Date
    let coordinate: CLLocationCoordinate2D
    let altitude: String
    let speed: String
}

struct FlightData: Decodable {
    let flightNumber: String
    let departure: AirportData
    let arrival: AirportData
    let aircraft: AircraftData?
    let speed: SpeedData?
    
    struct AirportData: Decodable {
        let iataCode: String
        let city: String
        let dateTime: String
    }

    struct AircraftData: Decodable {
        let altitude: String
    }
    
    struct SpeedData: Decodable {
        let horizontalSpeed: String
    }
}


// Extension to initialize a Flight from FlightData
extension Flight {
    init(from flightData: FlightData) {
        self.flightNumber = flightData.flightNumber
        self.departure = flightData.departure.iataCode
        self.departureCity = flightData.departure.city
        self.departureTime = ISO8601DateFormatter().date(from: flightData.departure.dateTime) ?? Date()
        self.destination = flightData.arrival.iataCode
        self.destinationCity = flightData.arrival.city
        self.arrivalTime = ISO8601DateFormatter().date(from: flightData.arrival.dateTime) ?? Date()
        self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0) // Ajustar según los datos de latitud/longitud si están disponibles
        self.altitude = flightData.aircraft?.altitude ?? "N/A"
        self.speed = flightData.speed?.horizontalSpeed ?? "N/A"
    }
}
