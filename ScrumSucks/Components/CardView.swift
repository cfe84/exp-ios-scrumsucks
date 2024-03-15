//
//  CardView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI

struct CardView: View {
    let ceremony: DailyMadness
    var body: some View {
        VStack {
            Text(ceremony.excuse)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack {
                Label("\(ceremony.victims.count)", systemImage: "person.3")
                    .accessibilityLabel("\(ceremony.victims.count) victims in this scrum")
                Spacer()
                Label("\(ceremony.suppliceDurationInMinutes)", systemImage: "clock")
                    .padding(.trailing, 20)
                    .labelStyle(.trailingIcon)
                    .accessibilityLabel("\(ceremony.suppliceDurationInMinutes) excruciating minutes")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(ceremony.uglyColor.accentColor)
    }
}

#Preview {
    let ceremony = DailyMadness.sampleData[0]
    let view = CardView(ceremony: ceremony)
        .background(ceremony.uglyColor.mainColor)
        .previewLayout(.fixed(width: 400, height: 60))
    return view
}
