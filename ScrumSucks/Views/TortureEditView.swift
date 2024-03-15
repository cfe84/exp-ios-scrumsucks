//
//  TortureEditView.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-13.
//

import SwiftUI

struct TortureEditView: View {
    @Binding var torture: DailyMadness
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            Section(header: Text("Details of the torture")) {
                TextField("What is the excuse for that torture", text: $torture.excuse)
                HStack {
                    Slider(value: $torture.durationInMinutesAsDouble, in: 5...180){
                        Text("Length")
                    }
                        .accessibilityValue("\(torture.suppliceDurationInMinutes) excrutiating minutes")
                    Spacer()
                    Text("\(torture.suppliceDurationInMinutes) minutes")
                        .accessibilityHidden(true)
                }
                UglyColorPickerView(uglyColor: $torture.uglyColor)
            }
            
            Section(header: Label("Victims", systemImage: "person.3")) {
                ForEach(torture.victims) { victim in
                    Text(victim.denomination)
                }
                .onDelete { indices in
                    torture.victims.remove(atOffsets: indices)
                }
                HStack {
                    TextField("New Victim", text: $newAttendeeName)
                    Button(action: {
                        withAnimation {
                            let victim = DailyMadness.Victim(denomination: newAttendeeName)
                            torture.victims.append(victim)
                            newAttendeeName = ""
                        }
                    }) {
                        Image(systemName: "plus.circle")
                            .accessibilityLabel("Add victim")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    @State var dailyMadness: DailyMadness = DailyMadness.emptyTorture
    return TortureEditView(torture: $dailyMadness)
}
