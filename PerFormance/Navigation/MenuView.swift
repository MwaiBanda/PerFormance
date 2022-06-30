//
//  MenuView.swift
//  PerFormance
//
//  Created by Mwai Banda on 9/9/21.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var session : Session
    @Binding var showMenu: Bool
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea(.all)

            VStack(spacing: 20) {
                Image("PerFormance")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.9)
                MenuButton(title: "Wellness", icon: "brain.head.profile")
                    .onTapGesture {
                        
                    }
                MenuButton(title: "Form Evaluation", icon:  "figure.wave")
                    .onTapGesture {
                        
                    }
                MenuButton(title: "Statistics", icon: "calendar.badge.plus")
                    .onTapGesture {
                        
                    }
                MenuButton(title: "Achievements", icon: "checkerboard.shield")
                    .onTapGesture {
                        
                    }
                MenuButton(title: "Logout", icon: "arrowshape.turn.up.left.2.circle")
                    .onTapGesture {
                        session.LogOut() 
                        let haptic = UINotificationFeedbackGenerator()
                        haptic.notificationOccurred(.success)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showMenu = false
                        }
                    }
                    .padding(.bottom)
                Spacer()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(showMenu: .constant(true)) 
    }
}
