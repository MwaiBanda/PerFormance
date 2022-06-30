//
//  NavBar.swift
//  PerFormance
//
//  Created by Mwai Banda on 12/16/20.
//  

import SwiftUI


struct NavBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showMenu: Bool
    @Binding var showAcheivements: Bool

  
    var body: some View {
            HStack()  {
                Button {
                    showMenu.toggle()
                } label: {

                Image(systemName: showMenu ? "xmark.circle" : "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color(.white))
                }
                Spacer()
                Button {
                    showAcheivements = true
                } label: {
                
                Image(systemName: "checkerboard.shield")
                    .resizable()
                    .frame(width: 30, height: 35)
                    .foregroundColor(Color(.white))
                }
            }
            .padding(.horizontal)

            }
        }
    


struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(showMenu: .constant(false), showAcheivements: .constant(false))
    }
}

