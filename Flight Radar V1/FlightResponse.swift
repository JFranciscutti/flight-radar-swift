//
//  FlightResponse.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 10/11/2024.
//

import Foundation

struct FlightsResponse: Decodable {
    let data: [FlightData]
}
