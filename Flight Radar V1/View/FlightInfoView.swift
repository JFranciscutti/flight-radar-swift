import SwiftUI

struct FlightInfoView: View {
    let flight: Flight
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack {
                    Text(flight.departure)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(flight.departureCity)
                }
                
                Image(systemName: "airplane.circle.fill")
                    .scaledToFill()
                    .padding(.horizontal)
                    .foregroundColor(.yellow)
                
                VStack {
                    Text(flight.destination)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(flight.destinationCity)
                }
            }
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Salida")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flight.departureTime.formatted(date: .omitted, time: .shortened))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Llegada")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flight.arrivalTime.formatted(date: .omitted, time: .shortened))
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                Divider()
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Altitud")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flight.altitude)
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Velocidad")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(flight.speed)
                            .font(.headline)
                    }
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
        .background(Color(uiColor: .systemBackground))
    }
} 