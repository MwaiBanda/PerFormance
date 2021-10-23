//
//  PerFormanceApp.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/22/21.
//

import SwiftUI

@main
struct PerFormanceApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
