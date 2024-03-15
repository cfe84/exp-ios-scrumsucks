//
//  TortureDetails.swift
//  ScrumSucks
//
//  Created by Charles Feval on 2024-03-12.
//

import SwiftUI

struct TortureDetailsView: View {
    @Binding var nonsense: DailyMadness
    @State private var nonsenseBeingEdited = DailyMadness.emptyTorture
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            NavigationLink(destination: TortureSessionView(supplice: $nonsense)){
                Label("Start the nonsense", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            Section(header: Text("Meeting Info")) {
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(nonsense.suppliceDurationInMinutes) excruciating minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Colour", systemImage: "paintpalette")
                    Spacer()
                    Text(nonsense.uglyColor.name)
                        .padding(4)
                        .foregroundColor(nonsense.uglyColor.accentColor)
                        .background(nonsense.uglyColor.mainColor)
                        .cornerRadius(7)
                }
                .accessibilityElement(children: .combine)
            }
            .accessibilityElement(children: .combine)
            Section(header: Text("Victims")) {
                ForEach(nonsense.victims, id: \.id) { victim in
                    Label(victim.denomination, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if nonsense.history.isEmpty {
                    Label("No tortures yet", systemImage: "calendar.badge.exclamationmark")
                } else {
                    ForEach(nonsense.history) { history in
                        HStack {
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
            }
        }
        .navigationTitle(nonsense.excuse)
        .toolbar {
            Button("Modify this shit") {
                isPresentingEditView = true
                nonsenseBeingEdited = nonsense
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                TortureEditView(torture: $nonsenseBeingEdited)
                    .navigationTitle(nonsense.excuse)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresentingEditView = false
                                nonsense = nonsenseBeingEdited
                            }
                        }
                    }
            }

        }
    }
}

#Preview {
    @State var nonsense = DailyMadness.sampleData[1]
    return TortureDetailsView(nonsense: $nonsense)
}
