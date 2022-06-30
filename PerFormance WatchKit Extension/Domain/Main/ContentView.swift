//
//  ContentView.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/22/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var selectTab = ""
    private var mainTabs = [
        Tab(name: "Mediate", icon: "mediation"),
        Tab(name: "Workout", icon: "workout"),
        Tab(name: "Statistics", icon: "analytics")
        
    ]
  
    var body: some View {
        ZStack {
            VStack(alignment: .leading){
                
                Text("PerFormance")
                    .fontWeight(.heavy)
                Text("Select an Option")
                    .lineLimit(nil)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(mainTabs, id: \.icon) { tab in
                                VStack {
                                    ZStack {
                                        Circle()
                                            .frame(width: 80, height: 80, alignment: .center)
                                            .foregroundColor(.gray)
                                        Image(tab.icon)
                                            .resizable()
                                            .frame(width: 55, height: 55, alignment: .center)
                                    }
                                    Text(tab.name)
                                        .fontWeight(.bold)
                                        .font(.subheadline)
                                }
                                .padding(tab.name == mainTabs[0].name ? 0 : 7)
                                .onTapGesture {
                                    selectTab = tab.name
                                }
                            }
                        
                    }
                }
            }

            if selectTab == mainTabs[0].name {
                Color.black.ignoresSafeArea(.all)
                Mediate(backEntry: backExecute)

            } else if selectTab == mainTabs[1].name {
                Color.black.ignoresSafeArea(.all)
                WorkoutView()
            } else if selectTab == mainTabs[2].name {
                Color.black.ignoresSafeArea(.all)
                Stats(backEntry: backExecute)
            }
        }
    }
    func backExecute() {
        selectTab = ""
    }
}
