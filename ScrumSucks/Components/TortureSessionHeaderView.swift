//
//  MeetingHeaderView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct TortureSessionHeaderView: View {
    let supplice: DailyMadness
    let secondsElapsed: Int
    let secondsRemaining: Int
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            Text(supplice.excuse)
                .font(.title)
        }
        ProgressView(value: progress)
            .accentColor(supplice.uglyColor.accentColor)
        HStack {
            VStack(alignment: .leading) {
                Text("Seconds Elapsed")
                    .font(.caption)
                Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Seconds Remaining")
                    .font(.caption)
                Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
            }
        }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Time remaining")
            .accessibilityValue("\(minutesRemaining) fucking minutes")
            .padding([.top, .horizontal])
    }
}

#Preview {
    var data = DailyMadness.sampleData[2]
    return TortureSessionHeaderView(supplice: data, secondsElapsed: 1360, secondsRemaining: 14400)
        .previewLayout(.sizeThatFits)
        .background(data.uglyColor.mainColor)
    
}
