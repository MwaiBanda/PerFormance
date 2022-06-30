//
//  Stats.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import SwiftUI

struct Stats: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
            Text("Statistics")
                    .fontWeight(.heavy)
                    .padding(.top)
                    .font(.title2)
                    Text("Keep Going & Keep Track of Your Progress")

                }
                Spacer()
            }
            Divider()
            Spacer()
            HStack {
                
            }
        }
        .padding(.top, 30)
        .padding(.leading)
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
