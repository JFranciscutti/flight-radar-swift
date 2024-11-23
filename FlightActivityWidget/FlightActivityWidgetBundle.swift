//
//  FlightActivityWidgetBundle.swift
//  FlightActivityWidget
//
//  Created by Joaquin Franciscutti on 23/10/2024.
//

import WidgetKit
import SwiftUI

struct FlightActivityWidgetBundle: WidgetBundle {
    var body: some Widget {
        FlightActivityWidget()
        FlightActivityWidgetControl()
        FlightActivityWidgetLiveActivity()
    }
}
