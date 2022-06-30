//
//  Stats.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct Stats: View {
    var backEntry: () -> Void
    var body: some View {
        VStack {
        Text("Stats")
        }     .toolbar {
            HStack {
                Image(systemName: "chevron.compact.left")
                Text("Analytics")
                    .font(.title3)
                Spacer()
            }
            .foregroundColor(Color.gray)
            .padding([.leading, .bottom])
            .padding(.bottom, 15)
            .onTapGesture(perform: backEntry)
        }
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats(backEntry: {})
    }
}
