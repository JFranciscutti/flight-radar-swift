//
//  IntentHandler.swift
//  FavoriteFlightExtension
//
//  Created by Joaquin Franciscutti on 22/11/2024.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is FavoriteFlightIntent else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        return FavoriteFlightHandler()
    }
    
}

class FavoriteFlightHandler: NSObject, FavoriteFlightIntentHandling {
    private let favoritesKey = "favoriteFlights"
    private let userDefaults = UserDefaults(suiteName: "group.com.favorites.temp")
   
    
    func handle(intent: FavoriteFlightIntent, completion: @escaping (FavoriteFlightIntentResponse) -> Void) {
        if let number = intent.flightNumber {
            // Check if flight doesn't exist in mocked flights
            if !isFlightNumberInDataFlights(number) {
                completion(FavoriteFlightIntentResponse.failure(flightNumber: number))
                return
            }
            
            // Check if flight is already in favorites
            if isFlightInFavorites(number) {
                completion(FavoriteFlightIntentResponse.alreadyInFavorites(flightNumber: number))
                return
            }
            
            // If we reach here, the flight exists and is not in favorites
            markAsFavorite(flightNumber: number)
            completion(FavoriteFlightIntentResponse.success(flightNumber: number))
        }
    }
    
    
    func resolveFlightNumber(for intent: FavoriteFlightIntent, with completion: @escaping (FavoriteFlightFlightNumberResolutionResult) -> Void) {
        guard let number = intent.flightNumber else {
            completion(FavoriteFlightFlightNumberResolutionResult.needsValue())
            return
        }
        
        completion(FavoriteFlightFlightNumberResolutionResult.success(with: number))
    }

    
    private func markAsFavorite(flightNumber: String) {
           // Find the flight in mocked flights
           guard let flightToAdd = mockedFlights.first(where: { $0.flightNumber == flightNumber }) else { return }
           
           print(flightToAdd.flightNumber)
           
           // Load existing favorites
           var favoriteFlights: [Flight] = []
           if let savedData = userDefaults?.data(forKey: favoritesKey) {
               favoriteFlights = (try? JSONDecoder().decode([Flight].self, from: savedData)) ?? []
           }
           
           // Add flight if not already in favorites
           if !isFlightInFavorites(flightNumber) {
               print("Adding flight to favorites")
               favoriteFlights.append(flightToAdd)
               
               // Save updated favorites
               if let encodedData = try? JSONEncoder().encode(favoriteFlights) {
                   userDefaults?.set(encodedData, forKey: favoritesKey)
               }
           } else {
               print("Flight already in favorites")
           }
       }
       
       private func isFlightInFavorites(_ flightNumber: String) -> Bool {
           guard let savedData = userDefaults?.data(forKey: favoritesKey),
                 let favoriteFlights = try? JSONDecoder().decode([Flight].self, from: savedData) else {
               return false
           }
           
           return favoriteFlights.contains { $0.flightNumber == flightNumber }
       }
    
}
