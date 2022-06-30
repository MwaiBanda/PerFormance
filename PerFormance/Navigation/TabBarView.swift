//
//  TabView.swift
//  PerFormance
//
//  Created by Mwai Banda on 12/24/20.
//

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = "figure.wave"
    @State var xAxis: CGFloat = 0
    var tabs = [
        "brain.head.profile",
        "figure.wave",
        "calendar.badge.plus"
    ]
    @Namespace var animation
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
            TabView {
                Group {
                    if self.selectedTab == tabs[0] {
                        NavigationView {
                            ContentWrapper {
                              Wellness()
                            }
                        }.accentColor( .black)
                        .navigationViewStyle(StackNavigationViewStyle())
                    } else if self.selectedTab == tabs[1]{
                        NavigationView {
                            ContentWrapper {
                            FormView()
                            }
                        }.navigationViewStyle(StackNavigationViewStyle())
                        
                    } else if self.selectedTab == tabs[2] {
                        NavigationView {
                            ContentWrapper {
                            Stats()
                            }
                        }.navigationViewStyle(StackNavigationViewStyle())
                    } 
                }
            }
            
            HStack(spacing: 0){
                ForEach(tabs, id: \.self){ image in
                    GeometryReader { reader in
                        Button(action: {
                            withAnimation(.spring()){
                                selectedTab = image
                               
                                xAxis = reader.frame(in: .global).minX
                                
                            }
                        }) {
                            Image(systemName: image)
                                .font(.title2)
                                .frame(width: 25, height:25)
                                .foregroundColor(selectedTab == image ? Color(.black) : Color(.gray))
                                .padding(selectedTab == image ? 15 : 0)
                                .background(Color(.white).opacity( selectedTab == image ? 1 : 0).clipShape(Circle()))
                                .shadow(color: Color(.systemGray6).opacity(0.15), radius: 20, x: 0, y: 10)

                                .matchedGeometryEffect(id: image, in: animation)
                                .offset(x: selectedTab == image ? (reader.frame(in: .global).minX - reader.frame(in: .global).midX) : 0,y: selectedTab == image ? -50 : 0)
                        }
                        .onAppear(perform: {
                            if image == tabs[1] {
                                xAxis = reader.frame(in: .global).minX
                            }
                        })
                    }
                    .frame(width: 25, height:25)

                    if image != tabs.last{ Spacer(minLength: 0)}
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(Color(.white).clipShape(CustomShape(xAxis: xAxis)).cornerRadius(11))
            .shadow(color: Color.black.opacity(0.25), radius: 20, x: 0, y: 10)
            .padding(.horizontal)
            .padding(.vertical)
            .padding(.bottom,  10)



        }
        .background(LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea(.all))
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}


struct CustomShape: Shape  {
    var xAxis: CGFloat
    var animatableData: CGFloat {
        get { xAxis }
        set { xAxis = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let center = xAxis
            
            path.move(to: CGPoint(x: center - 50, y: 0))
            
            let to1 = CGPoint(x: center, y: 35)
            let control1 = CGPoint(x: center - 25, y: 0)
            let control2 = CGPoint(x: center - 25, y: 35)
            
            let to2 = CGPoint(x: center + 50, y: 0)
            let control3 = CGPoint(x: center + 25, y: 35)
            let control4 = CGPoint(x: center + 25, y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            path.addCurve(to: to2, control1: control3, control2: control4)

        }
    }
}
