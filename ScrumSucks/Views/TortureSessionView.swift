//
//  ContentView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI
import AVFoundation

struct TortureSessionView: View {
    @Binding var supplice: DailyMadness
    @StateObject var timer = TortureTimer()
    
    
    fileprivate func startTorture() {
        timer.reset(lengthInMinutes: supplice.suppliceDurationInMinutes, victims: supplice.victims)
        timer.startTorture()
    }
    
    fileprivate func stopTorture() {
        timer.stopMadness()
        let newHistory = History(victims: supplice.victims)
        supplice.history.insert(newHistory, at: 0)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(supplice.uglyColor.mainColor)
            VStack {
                TortureSessionHeaderView(supplice: supplice, secondsElapsed: timer.secondsElapsed, secondsRemaining: timer.secondsRemaining)
                TortureTimerView(victims: timer.torturers, uglyColor: supplice.uglyColor)
                TortureSessionFooterView(torturers: timer.torturers, skipAction: timer.skipTorturer)
            }
        }
        .padding()
        .foregroundColor(supplice.uglyColor.accentColor)
        .onAppear {
            startTorture()
        }
        .onDisappear {
            stopTorture()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    return TortureSessionView(supplice: .constant(DailyMadness.sampleData[0]))
}
