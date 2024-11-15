//
//  FlightsMock.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import Foundation
import CoreLocation

let mockedFlights: [Flight] = [
    Flight(
        flightNumber: "AA123",
           departure: "JFK",
           departureCity: "New York",
           departureTime: Date().addingTimeInterval(-3600),
           destination: "LAX",
           destinationCity: "Los Angeles",
           arrivalTime: Date().addingTimeInterval(4200),
           coordinate: CLLocationCoordinate2D(latitude: -38.9754, longitude: 150.12),
           altitude: "35,000 ft",
           speed: "550 mph"
    ),
    
    Flight(flightNumber: "NZ5817",
           departure: "LAX",
           departureCity: "Los Angeles",
           departureTime: Date().addingTimeInterval(-4500),
           destination: "SYD",
           destinationCity: "Sydney",
           arrivalTime: Date().addingTimeInterval(10800),
           coordinate: CLLocationCoordinate2D(latitude: -41.3403, longitude: 174.806),
           altitude: "34,000 ft",
           speed: "540 mph"
    ),
    
    Flight(flightNumber: "SU5617",
           departure: "SVO",
           departureCity: "Moscow",
           departureTime: Date().addingTimeInterval(-3000),
           destination: "LHR",
           destinationCity: "London",
           arrivalTime: Date().addingTimeInterval(3600),
           coordinate: CLLocationCoordinate2D(latitude: 50.8808, longitude: 149.046),
           altitude: "36,000 ft",
           speed: "560 mph"
    ),
    
    Flight(flightNumber: "B77L",
           departure: "ATL",
           departureCity: "Atlanta",
           departureTime: Date().addingTimeInterval(-7200),
           destination: "CDG",
           destinationCity: "Paris",
           arrivalTime: Date().addingTimeInterval(5400),
           coordinate: CLLocationCoordinate2D(latitude: 34.847, longitude: 68.9363),
           altitude: "39,000 ft",
           speed: "590 mph"
    ),
    
    Flight(flightNumber: "A319",
           departure: "MIA",
           departureCity: "Miami",
           departureTime: Date().addingTimeInterval(-1800),
           destination: "CUN",
           destinationCity: "Cancun",
           arrivalTime: Date().addingTimeInterval(5400),
           coordinate: CLLocationCoordinate2D(latitude: 58.2105, longitude: 39.582),
           altitude: "32,000 ft",
           speed: "520 mph"
    ),

    Flight(flightNumber: "AF007",
           departure: "JFK",
           departureCity: "New York",
           departureTime: Date().addingTimeInterval(-3600),
           destination: "CDG",
           destinationCity: "Paris",
           arrivalTime: Date().addingTimeInterval(25200),
           coordinate: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
           altitude: "33,000 ft",
           speed: "530 mph"
    ),
    
    Flight(flightNumber: "QF12",
           departure: "SYD",
           departureCity: "Sydney",
           departureTime: Date().addingTimeInterval(-14400),
           destination: "LAX",
           destinationCity: "Los Angeles",
           arrivalTime: Date().addingTimeInterval(10800),
           coordinate: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
           altitude: "38,000 ft",
           speed: "580 mph"
    ),
    
    Flight(flightNumber: "LH401",
           departure: "JFK",
           departureCity: "New York",
           departureTime: Date().addingTimeInterval(-3600),
           destination: "FRA",
           destinationCity: "Frankfurt",
           arrivalTime: Date().addingTimeInterval(28800),
           coordinate: CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050),
           altitude: "37,000 ft",
           speed: "570 mph"
    ),
    
    Flight(flightNumber: "EK216",
           departure: "LAX",
           departureCity: "Los Angeles",
           departureTime: Date().addingTimeInterval(-5400),
           destination: "DXB",
           destinationCity: "Dubai",
           arrivalTime: Date().addingTimeInterval(32400),
           coordinate: CLLocationCoordinate2D(latitude: 25.2048, longitude: 55.2708),
           altitude: "40,000 ft",
           speed: "600 mph"
    ),
    
    Flight(flightNumber: "BA283",
           departure: "LHR",
           departureCity: "London",
           departureTime: Date().addingTimeInterval(-7200),
           destination: "LAX",
           destinationCity: "Los Angeles",
           arrivalTime: Date().addingTimeInterval(36000),
           coordinate: CLLocationCoordinate2D(latitude: 51.4700, longitude: -0.4543),
           altitude: "36,000 ft",
           speed: "560 mph"
    )
]
