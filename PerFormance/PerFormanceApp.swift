//
//  PerFormanceApp.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/22/21.
//

import SwiftUI
import FirebaseCore

@main
struct PerFormanceApp: App {
    init () {
        FirebaseApp.configure()
    }
    @StateObject private var session = Session()
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(session)
        }
    }
}
