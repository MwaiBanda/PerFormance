//
//  Live.swift
//  WPRK (iOS)
//
//  Created by Mwai Banda on 9/9/21.
//

import SwiftUI
import AVFoundation
import SwiftUI
import StoreKit



struct ContentWrapper<Content: View>: View {
    @State var showMenu = false
    @State var showAchievements = false

    var content: () -> (Content)
    init( @ViewBuilder content: @escaping () -> (Content)) {
        self.content = content
    }
    
    var body: some View {
        let drag = DragGesture().onEnded {
            if $0.translation.width < -100 {
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                    self.showMenu = false
                    
                }
            }
        }
        VStack {
            ZStack{
                withAnimation {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea(.all)
                        GeometryReader { geometry in
                                VStack{
                                    ZStack {
                                        LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                                            .ignoresSafeArea(.all)
                                        VStack(spacing: 0){
                                            content()
                                                .foregroundColor(.white)
                                        }
                                        .sheet(isPresented: $showAchievements) {
                                            Achievements()
                                        }
                                        VStack {
                                            NavBar(showMenu: $showMenu, showAcheivements: $showAchievements)
                                            
                                            Spacer()
                                        }
                                    }
                                }
                                .onAppear{
                                    do {
                                        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
                                    }
                                    catch {
                                        print("Setting category to AVAudioSessionCategoryPlayback failed.")
                                    }
                                }
                                
                                .frame(width: geometry.size.width)
                                .offset(x: self.showMenu ? geometry.size.width/1.45 : 0)
                                .shadow(color: Color.black.opacity(0.5), radius: 20, x: -5, y: 10)

                                
                                if self.showMenu {
                                    MenuView(showMenu: $showMenu)
                                        .animation(.easeInOut(duration: 0.35))
                                        .frame(width: geometry.size.width/1.45)
                                        .transition(.move(edge: .leading))
                                }
                            }
                    }
                    .gesture(drag)
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            self.showMenu = false
                            
                            let haptic = UIImpactFeedbackGenerator(style: .light)
                            haptic.impactOccurred()
                        }
                    }
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear(perform: {
            
        })
    }
}


//struct MenuWrapper_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuWrapper {
//            Text("Home")
//        }
//    }
//}
