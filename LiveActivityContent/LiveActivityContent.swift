//
//  LiveActivityContent.swift
//  LiveActivityContent
//
//  Created by Joaquin Franciscutti on 21/10/2024.
//

import WidgetKit
import SwiftUI

struct LiveActivityContent: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FlightAttributes.self) { context in
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color("Gray").gradient)
            }
        }
    }
}
