//
//  Achivements.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct Achievements: View {
    var streaks = ["streak1","streak2","streak3",]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
        Text("Achievements")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.vertical)
            Spacer()
            }
            Divider()
            Text("Streaks")
                .font(.title3)
                .fontWeight(.bold)
            Text("Collect badges for your hard work")
            Divider()
            ScrollView(.horizontal){
                Image(systemName: "")
                    .resizable()
            }
            Spacer()

        }
        .padding(.leading)
        .foregroundColor(.white)
    }
}

struct Achivements_Previews: PreviewProvider {
    static var previews: some View {
        Achievements()
    }
}
