//
//  Mediate.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct Mediate: View {
    var backEntry: () -> Void

    var body: some View {
        VStack {
        Text("Mediate")
        }  .toolbar {
            HStack {
                Image(systemName: "chevron.compact.left")
                Text("Mediate")
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

struct Mediate_Previews: PreviewProvider {
    static var previews: some View {
        Mediate(backEntry: {})
    }
}
