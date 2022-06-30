//
//  ContentView.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/22/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: Session
    var body: some View {
        ZStack {
           
                TabBarView()
            if session.currentUser == nil {
                Login()
                     .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
