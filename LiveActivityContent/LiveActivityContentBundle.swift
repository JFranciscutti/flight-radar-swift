//
//  LiveActivityContentBundle.swift
//  LiveActivityContent
//
//  Created by Joaquin Franciscutti on 21/10/2024.
//

import WidgetKit
import SwiftUI

@main
struct LiveActivityContentBundle: WidgetBundle {
    var body: some Widget {
        LiveActivityContent()
        LiveActivityContentControl()
        LiveActivityContentLiveActivity()
    }
}
