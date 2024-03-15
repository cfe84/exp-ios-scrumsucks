//
//  TortureTimerView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-14.
//

import SwiftUI

struct TortureTimerView: View {
    let victims: [TortureTimer.Torturer]
    let uglyColor: UglyColor
    let diameter = 24.0
    private var torturerIndex: Int {
        victims.firstIndex(where: {victim in !victim.isCompleted}) ?? -1
    }
    private var torturer: String {
        guard (torturerIndex >= 0) else {return "No torturer?!"}
        return victims[torturerIndex].fakeName
    }
    
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: diameter)
            .overlay{
                VStack {
                    Text(torturer)
                        .font(.title)
                    Text("is torturing everyone else")
                }
                .accessibilityElement(children: .combine)
                .foregroundColor(uglyColor.accentColor)
            }
            .overlay {
                TortureArc(currentTorturerIndex: torturerIndex, victimCount: victims.count, diameter: diameter)
                    .rotation(Angle(degrees: -90))
                    .stroke(uglyColor.mainColor, lineWidth: diameter / 2.0)
            }
            .padding(.horizontal)
    }
}

#Preview {
    var madness = DailyMadness.sampleData[1]
    var torturers = madness.victims.asTorturers
    torturers[0].isCompleted = true
    var uglyColor = madness.uglyColor
    return TortureTimerView(victims: torturers, uglyColor: uglyColor)
}
