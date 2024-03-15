//
//  MeetingFooterView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct TortureSessionFooterView: View {
    let torturers: [TortureTimer.Torturer]
    let skipAction: () -> Void
    
    private var torturerNumber: Int? {
        guard let index = torturers.firstIndex(where: {!$0.isCompleted}) else { return nil }
        return index + 1
    }
    
    private var isLastTorturer: Bool {
        torturers.dropLast().allSatisfy({ $0.isCompleted })
    }
    
    private var torturerText: String {
        guard let torturerNumber = torturerNumber else { return "No more torturers" }
        if isLastTorturer {
            return "Last torturer"
        }
        return "Torturer \(torturerNumber) of \(torturers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(torturerText)
                if (!isLastTorturer)
                {
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next torturer")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    TortureSessionFooterView(torturers: DailyMadness.sampleData[0].victims.asTorturers, skipAction: {})
        .previewLayout(.sizeThatFits)
}
