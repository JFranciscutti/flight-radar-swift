//
//  FlightActivityWidgetLiveActivity.swift
//  FlightActivityWidget
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import ActivityKit
import WidgetKit
import SwiftUI
import Foundation

@main
struct FlightActivityWidgetLiveActivity: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightActivityWidgetAttributes.self) { context in
            VStack {
                HStack {
                    VStack {
                        Text(context.attributes.departure)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text(context.attributes.departureCity).foregroundColor(Color.white)
                    }
                    
                    Image(systemName: "airplane.circle.fill")
                        .scaledToFill()
                        .padding(.horizontal)
                        .tint(Color.yellow)
                    
                    VStack {
                        Text(context.attributes.destination)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                        
                        Text(context.attributes.destinationCity).foregroundColor(Color.white)
                    }
                }
                
                VStack {
                    HStack {
                        Text("Despegue \(formattedDepartureTime(context.attributes.departureTime))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        Text("Llegada \(formattedArrivalTime(context.attributes.arrivalTime))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    }
                    
                    ProgressView(value: context.state.progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(Color.yellow)
                    
                    HStack {
                        Text("Salió hace \(formattedTimeElapsed(context.attributes.departureTime))hs")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        Text("Llega en \(formattedTimeRemaining(context.attributes.arrivalTime))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8.0)
            }
            .padding()
            .background(Color(red: 0.224, green: 0.224, blue: 0.224))
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Text(context.attributes.flightNumber)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .padding(.horizontal, 8.0)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        HStack {
                            VStack {
                                Text(context.attributes.departure)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Text(context.attributes.departureCity)
                            }
                            Image(systemName: "airplane.circle.fill")
                                .scaledToFill()
                                .padding(.horizontal)
                                .tint(Color.yellow)
                            VStack {
                                Text(context.attributes.destination)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Text(context.attributes.destinationCity)
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Despegue \(formattedDepartureTime(context.attributes.departureTime))")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("Llegada \(formattedArrivalTime(context.attributes.arrivalTime))")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            }
                            
                            ProgressView(value: calculateProgress(departureTime: context.attributes.departureTime,
                                                                  arrivalTime: context.attributes.arrivalTime))
                            .progressViewStyle(LinearProgressViewStyle())
                            .tint(Color.yellow)
                            
                            HStack {
                                Text("Salió hace \(formattedTimeElapsed(context.attributes.departureTime))hs")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("Llega en \(formattedTimeRemaining(context.attributes.arrivalTime))")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8.0)
                    }
                }
            } compactLeading: {
                Text(context.attributes.flightNumber)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
            } compactTrailing: {
                Text("\(formattedTimeRemaining(context.attributes.arrivalTime))")
            } minimal: {
                Image(systemName: "airplane")
            }
            .widgetURL(URL(string: "http://www.example.com"))
            .keylineTint(Color.red)
        }
    }
    
    private func formattedTimeRemaining(_ arrivalTime: Date) -> String {
        let timeRemaining = max(arrivalTime.timeIntervalSinceNow, 0)
        let minutes = Int(timeRemaining / 60) % 60
        let hours = Int(timeRemaining / 3600)
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    private func formattedDepartureTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formattedArrivalTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formattedTimeElapsed(_ departureTime: Date) -> String {
        let elapsed = max(Date().timeIntervalSince(departureTime), 0) // Asegura que no sea negativo
        let minutes = Int(elapsed / 60) % 60
        let hours = Int(elapsed / 3600)
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    
    private func calculateProgress(departureTime: Date, arrivalTime: Date) -> Double {
        let totalDuration = arrivalTime.timeIntervalSince(departureTime)
        let elapsed = Date().timeIntervalSince(departureTime)
        return max(min(elapsed / totalDuration, 1.0), 0.0) // Progreso entre 0.0 y 1.0
    }
}
