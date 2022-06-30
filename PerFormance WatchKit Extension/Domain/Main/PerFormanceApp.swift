//
//  PerFormanceApp.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/22/21.
//

import SwiftUI

@main
struct PerFormanceApp: App {
    @StateObject var workoutManager = WorkoutManager()
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView { 
                WorkoutView()
            }
            .sheet(isPresented: $workoutManager.isShowingSummary) {
                SummaryView()
            }
            .environmentObject(workoutManager)

        }
    }
}
