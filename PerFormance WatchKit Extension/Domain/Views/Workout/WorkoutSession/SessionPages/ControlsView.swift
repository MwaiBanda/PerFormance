//
//  ControlsView.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct ControlsView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var body: some View {
        HStack {
            VStack {
                Button {
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }.tint(.red)
                .font(.title2)
                
                Text("Stop")

            }
            VStack {
                Button {
                    workoutManager.toggle()
                } label: {
                    Image(systemName: workoutManager.isRunning ? "pause" : "play")
                }.tint(.red)
                .font(.title2)
                
                Text(workoutManager.isRunning ? "Pause" : "Resume")

            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}
