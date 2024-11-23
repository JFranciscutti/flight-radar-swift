//
//  File.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 10/11/2024.
//

import Foundation
import Combine
import CoreLocation

class FlightsViewModel: ObservableObject {
    @Published var flights: [Flight] = []
    @Published var favoriteFlights: [Flight] = [] {
        didSet {
            saveFavorites()
        }
    }
    @Published var selectedFlight: Flight? = nil
    @Published var currentFlight: Flight? = nil
    
    private let favoritesKey = "favoriteFlights"
    private let userDefaults = UserDefaults(suiteName: "group.com.favorites.temp")
       
    
    init() {
        flights = mockedFlights
        loadFavorites()
        //startFetchingLiveFlights()
    }
    
    func markAsFavorite () {
        guard let selectedFlight = selectedFlight else { return }
        
        if favoriteFlights.contains(where: { $0.id == selectedFlight.id }) {
            favoriteFlights.removeAll(where: { $0.id == selectedFlight.id })
        } else {
            favoriteFlights.append(selectedFlight)
        }
        
    }
    
    func markAsCurrent (id: UUID) {
        currentFlight = flights.first(where: { $0.id == id })
    }
    
    func selectFlight (flight: Flight) {
        selectedFlight = flight
    }
    
    func unSelectFlight () {
        selectedFlight = nil
    }
    
    func isSelectedFlightFavorite () -> Bool {
        if (selectedFlight == nil) {
            return false
        }
        else {
            return favoriteFlights.contains(selectedFlight!)
        }
    }
    
    func removeFavorite(at offsets: IndexSet) {
        favoriteFlights.remove(atOffsets: offsets)
    }
    
    func refetchLocalData() {
        loadFavorites()
    }
    
    private func saveFavorites() {
           do {
               let encodedData = try JSONEncoder().encode(favoriteFlights)
               userDefaults?.set(encodedData, forKey: favoritesKey)
           } catch {
               print("Error saving favorites: \(error.localizedDescription)")
           }
       }
    
    private func loadFavorites() {
            guard let savedData = userDefaults?.data(forKey: favoritesKey) else { return }
            do {
                favoriteFlights = try JSONDecoder().decode([Flight].self, from: savedData)
            } catch {
                print("Error loading favorites: \(error.localizedDescription)")
            }
        }
    
    private func getAccessToken(completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://test.api.amadeus.com/v1/security/oauth2/token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyParameters = [
            "grant_type": "client_credentials",
            "client_id": "YOUR_API_KEY",
            "client_secret": "YOUR_API_SECRET"
        ]
        
        request.httpBody = bodyParameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let accessToken = json["access_token"] as? String {
                completion(accessToken)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    private func getLiveFlights(accessToken: String, completion: @escaping ([Flight]?) -> Void) {
        //        let url = URL(string: "https://test.api.amadeus.com/v2/schedule/flights")!
        //        var request = URLRequest(url: url)
        //        request.httpMethod = "GET"
        //        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        //
        //        let task = URLSession.shared.dataTask(with: request) { data, _, error in
        //            guard let data = data, error == nil else {
        //                completion(nil)
        //                return
        //            }
        //
        //            do {
        //                let flightsResponse = try JSONDecoder().decode(FlightsResponse.self, from: data)
        //                completion(flightsResponse.flights)
        //            } catch {
        //                completion(nil)
        //            }
        //        }
        //        task.resume()
    }
    
    private func startFetchingLiveFlights() {
        Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            self.fetchLiveFlights()
        }
    }
    
    private func fetchLiveFlights() {
        //        getAccessToken { accessToken in
        //            guard let accessToken = accessToken else { return }
        //            self.getLiveFlights(accessToken: accessToken) { flightDataList in
        //                guard let flightDataList = flightDataList else { return }
        //                DispatchQueue.main.async {
        //                    self.flights = flightDataList.map { Flight(from: $0) }
        //                }
        //            }
        //        }
    }
}
