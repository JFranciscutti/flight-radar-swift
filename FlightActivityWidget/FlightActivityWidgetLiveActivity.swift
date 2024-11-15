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

struct FlightActivityWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightActivityWidgetAttributes.self) { context in
            VStack {
                HStack {
                    VStack {
                        Text(context.state.departure)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        
                        Text(context.state.departureCity).foregroundColor(Color.white)
                    }
                    
                    Image(systemName: "airplane.circle.fill")
                        .scaledToFill()
                        .padding(.horizontal)
                        .tint(Color.yellow)
                    
                    VStack {
                        Text(context.state.destination)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color.white)
                        
                        Text(context.state.destinationCity).foregroundColor(Color.white)
                    }
                }
                
                VStack {
                    HStack {
                        Text("Despegue \(formattedDepartureTime(context.state.departureTime))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)

                        Spacer()
                        Text("Llegada \(formattedArrivalTime(context.state.arrivalTime))")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.green)
                    }
                    
                    ProgressView(value: context.state.progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(Color.yellow)
                    
                    HStack {
                        Text("Salió hace \(formattedTimeElapsed(context.state.departureTime))hs")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)

                        Spacer()
                        Text("LLega en \(formattedTimeRemaining(context.state.timeRemaining)) hs")
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
                    Text(context.state.flightNumber)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                        .padding(.horizontal, 8.0)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack {
                        HStack {
                            VStack {
                                Text(context.state.departure)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Text(context.state.departureCity)
                            }
                            Image(systemName: "airplane.circle.fill")
                                .scaledToFill()
                                .padding(.horizontal)
                                .tint(Color.yellow)
                            VStack {
                                Text(context.state.destination)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                Text(context.state.destinationCity)
                            }
                        }
                        
                        VStack {
                            HStack {
                                Text("Despegue \(formattedDepartureTime(context.state.departureTime))")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("Llegada \(formattedArrivalTime(context.state.arrivalTime))")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            }
                            
                            ProgressView(value: context.state.progress)
                                .progressViewStyle(LinearProgressViewStyle())
                                .tint(Color.yellow)
                            
                            HStack {
                                Text("Salió hace \(formattedTimeElapsed(context.state.departureTime))hs")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                Spacer()
                                Text("Llega en \(formattedTimeRemaining(context.state.timeRemaining))hs")
                                    .font(.caption)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 8.0)
                    }
                }
            } compactLeading: {
                Text(context.state.flightNumber)
                    .fontWeight(.bold)
                    .foregroundColor(Color.yellow)
            } compactTrailing: {
                Text(formattedTimeRemaining(context.state.timeRemaining))
            } minimal: {
                Image(systemName: "airplane")
            }
            .widgetURL(URL(string: "http://www.example.com"))
            .keylineTint(Color.red)
        }
    }
    
    private func formattedTimeRemaining(_ time: TimeInterval) -> String {
        let minutes = Int(time / 60) % 60
        let hours = Int(time / 3600)
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
        let elapsed = Date().timeIntervalSince(departureTime)
        return formattedTimeRemaining(elapsed)
    }
}


extension FlightActivityWidgetAttributes {
    fileprivate static var preview: FlightActivityWidgetAttributes {
        FlightActivityWidgetAttributes(name: "Flight Preview")
    }
}

extension FlightActivityWidgetAttributes.ContentState {
    // Fictitious flight data for preview
    fileprivate static var sampleFlight: FlightActivityWidgetAttributes.ContentState {
        FlightActivityWidgetAttributes.ContentState(
            flightNumber: "AA123",
            departure: "JFK",
            departureCity: "New York",
            departureTime: Date().addingTimeInterval(-3600),
            destination: "LAX",
            destinationCity: "Los Angeles",
            arrivalTime: Date().addingTimeInterval(3600),
            timeRemaining: 2400
        )
    }
}


#Preview("Flight Notification", as: .content, using: FlightActivityWidgetAttributes.preview) {
   FlightActivityWidgetLiveActivity()
} contentStates: {
    FlightActivityWidgetAttributes.ContentState.sampleFlight
}
