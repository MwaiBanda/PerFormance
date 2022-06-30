//
//  ElaspedTimeView.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct ElapsedTimeView: View {
    var elapsedTime: TimeInterval = 0
    var showSubSeconds: Bool = true
    @State private var timeFormatter = ElapsedTimeFormatter()
    var body: some View {
        Text(NSNumber(value: elapsedTime),
             formatter: timeFormatter
        )
        .fontWeight(.semibold)
        .onChange(of: showSubSeconds) {
            timeFormatter.showSubSeconds = $0
        }
    }
}
class ElapsedTimeFormatter: Formatter {
    let componentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var showSubSeconds = true
    
    override func string(for value: Any?) -> String? {
        guard let time = value as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentsFormatter.string(from: time) else {
            return nil
        }
        
        if showSubSeconds {
            let hundredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
            let decimalSeparator = Locale.current.decimalSeparator ?? "."
            return String(format: "%@%@%0.2d", formattedString, decimalSeparator, hundredths)
        }
        
        return formattedString
    }
}
struct ElaspedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
