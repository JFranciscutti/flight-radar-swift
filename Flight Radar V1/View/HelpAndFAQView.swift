//
//  HelpAndFAQView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 15/11/2024.
//

import SwiftUI

struct HelpAndFAQView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Ayuda").font(.headline)) {
                    Text("¿Cómo agregar un vuelo a favoritos?")
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Text("1. Selecciona un vuelo desde la lista.\n2. Presiona el icono de estrella para agregarlo a tus favoritos.")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Text("¿Cómo seguir un vuelo en tiempo real?")
                        .font(.subheadline)
                        .padding(.vertical, 4)
                    Text("1. Selecciona un vuelo de la lista.\n2. Presiona el botón 'Seguir vuelo en vivo' para activar la Live Activity.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Preguntas Frecuentes").font(.headline)) {
                    NavigationLink(destination: FAQDetailView(question: "¿Qué datos sobre vuelos puedo ver?", answer: "Puedes ver información como el número de vuelo, ciudad de salida, ciudad de llegada, altitud, velocidad y tiempo estimado de llegada.")) {
                        Text("¿Qué datos sobre vuelos puedo ver?")
                    }
                    
                    NavigationLink(destination: FAQDetailView(question: "¿Cómo puedo ver vuelos en el mapa?", answer: "Dirígete a la vista principal y selecciona 'Ver mapa' para visualizar todos los vuelos en tiempo real.")) {
                        Text("¿Cómo puedo ver vuelos en el mapa?")
                    }
                    
                    NavigationLink(destination: FAQDetailView(question: "¿Puedo usar esta app sin conexión a internet?", answer: "No. Necesitas una conexión a internet para obtener información actualizada sobre los vuelos.")) {
                        Text("¿Puedo usar esta app sin conexión a internet?")
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Ayuda y FAQ")
        }
    }
}

struct FAQDetailView: View {
    let question: String
    let answer: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question)
                .font(.headline)
                .padding(.bottom, 8)
            
            Text(answer)
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detalles")
    }
}

#Preview {
    HelpAndFAQView()
}
