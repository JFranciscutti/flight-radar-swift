//
//  HeaderView.swift
//  Flight Radar V1
//
//  Created by Joaquin Franciscutti on 11/11/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 48, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Joaquin Franciscutti")
                    .font(.subheadline)
                    .tint(.blue)
                
                Text("Radar App")
                    .font(.footnote)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    HeaderView()
}
