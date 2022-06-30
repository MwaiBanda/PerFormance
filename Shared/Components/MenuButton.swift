//
//  MenuButton.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import SwiftUI

struct MenuButton: View {
    var title: String
    var icon: String
    var body: some View {
        
        HStack(alignment: .lastTextBaseline){
            Image(systemName: icon)
                .padding(.trailing, 5)
                .foregroundColor(.white)
            Text(title)
                .foregroundColor(.white)
            Spacer()
        }.padding()
        .background(Color(.black).opacity(0.25))
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton(title: "Menu Title", icon: "house")
    }
}
