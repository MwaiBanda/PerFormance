//
//  SummaryMetrricView.swift
//  PerFormance WatchKit Extension
//
//  Created by Mwai Banda on 10/24/21.
//

import SwiftUI

struct SummaryView: View {
    @State private var durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                SummaryMetricView(
                    title: "Total Time",
                    value: durationFormatter.string(from: 30 * 60 + 15) ?? ""
                )
                .accentColor(Color.blue)
                SummaryMetricView(
                    title: "Total Distance",
                    value: Measurement(value: 1625, unit: UnitLength.meters)
                        .formatted(.measurement(width: .abbreviated, usage: .road))
                )
                .accentColor(Color.yellow)
                SummaryMetricView(
                    title: "Total Energy",
                    value: Measurement(value: 1625, unit: UnitLength.meters)
                        .formatted(.measurement(width: .abbreviated, usage: .road))
                )
                .accentColor(Color.green)
                SummaryMetricView(
                    title: "Total Energy",
                    value: Measurement(value: 1625, unit: UnitLength.meters)
                        .formatted(.measurement(width: .abbreviated, usage: .road))
                )
                .accentColor(Color.green)
                SummaryMetricView(
                    title: "Avg Heart Rate",
                    value:  143.formatted(.number.precision(.fractionLength(0)))  + "bpm"
                )
                .accentColor(Color.yellow)
                
                Button("Done"){
                    
                }
            }
            .scenePadding()
            }
        .navigationTitle("Summary")
        .navigationBarTitleDisplayMode(.inline)
        }
    }

struct SummaryMetricView: View {
    var title: String
    var value: String
    var body: some View {
        Text(title)
        Text(value)
            .font(
                .system(.title2, design: .rounded)
                    .lowercaseSmallCaps()
            )
            .foregroundColor(.accentColor)
        Divider()

    }
}

struct SummaryMetrricView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryMetricView(title: "", value: "")
    }
}
