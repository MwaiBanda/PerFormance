//
//  WorkOut.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI
import HealthKit

struct WorkoutView: View {
    @EnvironmentObject var workoutManager: WorkoutManager
    var workoutTypes: [HKWorkoutActivityType] = [.cycling, .running, .walking]
    var body: some View {
            List(workoutTypes) { workoutType in
                NavigationLink(workoutType.name, destination: SessionPagingView(),
                               tag: workoutType, selection: $workoutManager.selectedWorkout)
                    .padding(EdgeInsets(top: 15, leading: 5, bottom: 15, trailing: 5))
            }
            .listStyle(.carousel)
            .onAppear(perform: {
                workoutManager.requestAuthorization()
            })
          
            
        
    }
}

extension HKWorkoutActivityType : Identifiable {
    public var id: UInt {
        rawValue
    }
    var name: String {
        switch self {
        case .running:
            return "Run"
        case .cycling:
            return "Bike"
        case .walking:
            return "Walk"
        default:
            return ""
        }
    }
}
struct WorkOut_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
