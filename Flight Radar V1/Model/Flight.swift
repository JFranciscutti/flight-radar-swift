//
//  Flight.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import Foundation
import CoreLocation

struct Flight: Identifiable, Equatable, Codable {
    static func == (lhs: Flight, rhs: Flight) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: UUID
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

    enum CodingKeys: String, CodingKey {
        case id, flightNumber, departure, departureCity, departureTime, destination, destinationCity, arrivalTime, coordinate, altitude, speed
    }
    
    enum CoordinateKeys: String, CodingKey {
        case latitude, longitude
    }
    
    init(
           id: UUID = UUID(),
           flightNumber: String,
           departure: String,
           departureCity: String,
           departureTime: Date,
           destination: String,
           destinationCity: String,
           arrivalTime: Date,
           coordinate: CLLocationCoordinate2D,
           altitude: String,
           speed: String
       ) {
           self.id = id
           self.flightNumber = flightNumber
           self.departure = departure
           self.departureCity = departureCity
           self.departureTime = departureTime
           self.destination = destination
           self.destinationCity = destinationCity
           self.arrivalTime = arrivalTime
           self.coordinate = coordinate
           self.altitude = altitude
           self.speed = speed
       }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        flightNumber = try container.decode(String.self, forKey: .flightNumber)
        departure = try container.decode(String.self, forKey: .departure)
        departureCity = try container.decode(String.self, forKey: .departureCity)
        departureTime = try container.decode(Date.self, forKey: .departureTime)
        destination = try container.decode(String.self, forKey: .destination)
        destinationCity = try container.decode(String.self, forKey: .destinationCity)
        arrivalTime = try container.decode(Date.self, forKey: .arrivalTime)
        altitude = try container.decode(String.self, forKey: .altitude)
        speed = try container.decode(String.self, forKey: .speed)
        
        let coordinateContainer = try container.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinate)
        let latitude = try coordinateContainer.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try coordinateContainer.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(flightNumber, forKey: .flightNumber)
        try container.encode(departure, forKey: .departure)
        try container.encode(departureCity, forKey: .departureCity)
        try container.encode(departureTime, forKey: .departureTime)
        try container.encode(destination, forKey: .destination)
        try container.encode(destinationCity, forKey: .destinationCity)
        try container.encode(arrivalTime, forKey: .arrivalTime)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(speed, forKey: .speed)
        
        var coordinateContainer = container.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinate)
        try coordinateContainer.encode(coordinate.latitude, forKey: .latitude)
        try coordinateContainer.encode(coordinate.longitude, forKey: .longitude)
    }
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
        self.id = UUID()
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
