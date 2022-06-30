//
//  Wellness.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import SwiftUI

struct Wellness: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
            Text("Streaks")
                    .fontWeight(.heavy)
                    .padding(.top)
                    .font(.title2)
                    Text("Keep Going To Unlock More Rewards")

                }
                Spacer()
            }
            Divider()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<7) { i in
                        ZStack {
                    Circle()
                        .frame(width: 45, height: 45, alignment: .center)
                        .foregroundColor(.white)
                            Text("\(i + 1)")
                                .foregroundColor(.black)
                        }
                        .padding(.leading, (i == 0 ? 0 : 10))
                    }
                }.padding(.vertical)
            }
            Divider()
            
            Text("Mediate")
                    .fontWeight(.heavy)
                    .padding(.top)
                    .font(.title2)
            Text("Stay Some Time To Mediate")
            Divider()
                .padding(.bottom)

            VStack {
                HStack {
                    VStack(alignment: .leading) {
                Text("Mediation Minutes")
                    .fontWeight(.heavy)
                    .padding(.top)
                    .font(.title2)
                    .lineLimit(1)
                        Text("Anytime")
                            .foregroundColor(.gray)

                        }.padding(.leading)
                    
                   
                    Spacer()
                    

                }
                .foregroundColor(.black)
                Divider()
                    .padding(.bottom)
                HStack {
                    Spacer()
                    VStack {
                    Text("5")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)

                        Text("Progress")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)

                    }
                    .foregroundColor(.orange)
                    Spacer()
                    VStack {
                    Text("15")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)

                    Text("Goal")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.semibold)

                    }
                    .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical)
                .foregroundColor(.black)
                Spacer()
                Button("Mediate") {
                    let haptic = UINotificationFeedbackGenerator()
                    haptic.notificationOccurred(.success)
                }.frame(maxWidth: screenBounds.width - 60, maxHeight: 45)
                .background(Color.black)
                .cornerRadius(10)
                .padding(.bottom)

                Divider()
                
                HStack {
                VStack(alignment: .leading) {
                Text("Take Some Time to Mediate")
                Text("To Clear Your Thoughts & Refresh Your Mind")
                }.foregroundColor(.gray)
                .padding(.vertical)
                .font(.subheadline)
                    Spacer()
                }.padding(.leading)
            }
            .frame(maxWidth: screenBounds.width - 30, maxHeight: 350)
            .background(Color.white)
            .cornerRadius(10)
            Spacer()
        }
        .padding(.top, 30)
        .padding(.leading)
    }
}

extension View {
    var screenBounds: CGRect {
        return UIScreen.main.bounds
    }
}
struct Wellness_Previews: PreviewProvider {
    static var previews: some View {
        Wellness()
    }
}
